param(
    [string]$Dest = "D:\llama",
    [string]$ZipDir = "D:\Temp\Zip",
    [string]$AssetPattern1 = "cudart-llama-bin-win-cuda-13.3-x64.zip",
    [string]$AssetPattern2 = "llama-b\d+-bin-win-cuda-13.3-x64.zip"
)

$ErrorActionPreference = "Stop"

# 1. 查最新 release tag（API 限流時 fallback 用已知版本）
$tag = $null
try {
    $release = Invoke-RestMethod -Uri "https://api.github.com/repos/ggml-org/llama.cpp/releases/latest" -Headers @{Accept = "application/vnd.github+json"} -ErrorAction Stop
    $tag = $release.tag_name
} catch {
    Write-Warning "GitHub API 限流，無法查詢最新版"
    $verFile = Join-Path $Dest "version.txt"
    if (Test-Path $verFile) {
        $tag = (Get-Content $verFile -Raw).Trim()
        Write-Host "使用已安裝版本: $tag"
    } else {
        Write-Error "無法取得版本且無本地記錄"
        exit 1
    }
    exit 0
}

Write-Host "Latest release: $tag"

# 2. 比對版本
$verFile = Join-Path $Dest "version.txt"
if ((Test-Path $verFile) -and (Get-Content $verFile -Raw).Trim() -eq $tag) {
    Write-Host "Already up to date ($tag)"
    exit 0
}

# 3. 準備目錄
if (-not (Test-Path $ZipDir)) { New-Item -ItemType Directory -Path $ZipDir -Force | Out-Null }

# 4. 逐一下載
$assets = @($AssetPattern1, $AssetPattern2)
$zipPaths = @()
foreach ($pattern in $assets) {
    $asset = $release.assets | Where-Object { $_.name -match "^$pattern$" } | Select-Object -First 1
    if (-not $asset) {
        Write-Error "Asset matching '$pattern' not found in release $tag"
        exit 1
    }
    $name = $asset.name
    $zipPath = Join-Path $ZipDir $name
    $zipPaths += $zipPath
    if (Test-Path $zipPath) {
        Write-Host "Already downloaded: $name"
    } else {
        Write-Host "Downloading $name ($([math]::Round($asset.size/1MB,1)) MB)..."
        Invoke-WebRequest -Uri $asset.browser_download_url -OutFile $zipPath -Headers @{Accept = "application/octet-stream"}
    }
}

# 5. 解壓縮
$binDir = Join-Path $Dest "bin"
if (Test-Path $binDir) { Remove-Item $binDir -Recurse -Force }

foreach ($zipPath in $zipPaths) {
    Write-Host "Extracting $(Split-Path $zipPath -Leaf)..."
    Expand-Archive -Path $zipPath -DestinationPath $binDir -Force
}

# 6. 記錄版本
Set-Content -Path $verFile -Value $tag -NoNewline

# 7. 列出內容
Write-Host "`nContents:"
Get-ChildItem $binDir | Format-Table Name, Length -AutoSize

Write-Host "`nDone. $tag -> $binDir"

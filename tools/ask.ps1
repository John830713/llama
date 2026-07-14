param(
    [Parameter(Mandatory=$true)]
    [string]$Prompt,
    [string]$System = "",
    [string]$Model = "Gemma-4-Q4_K_M",
    [string]$Server = "http://127.0.0.1:9090",
    [int]$MaxTokens = 2048,
    [float]$Temperature = 0.3,
    [switch]$Raw
)

$messages = @()
if ($System) { $messages += @{ role = "system"; content = $System } }
$messages += @{ role = "user"; content = $Prompt }

$body = @{
    model = $Model
    messages = $messages
    max_tokens = $MaxTokens
    temperature = $Temperature
} | ConvertTo-Json -Depth 3

$response = Invoke-RestMethod -Uri "$Server/v1/chat/completions" -Method Post -ContentType "application/json; charset=utf-8" -Body ([System.Text.Encoding]::UTF8.GetBytes($body))

$content = $response.choices[0].message.content

if ($Raw) { return $content }

# Strip markdown code fencing if present
$content = $content -replace '^\s*```[\w]*\s*','' -replace '\s*```\s*$',''
$content.Trim()

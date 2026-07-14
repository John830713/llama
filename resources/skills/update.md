# update.md — 更新 llama.cpp

## 自動更新（推薦）

1. 雙擊 `D:\llama\update-llama.bat`
2. 腳本自動：
   - 查 GitHub 最新 release
   - 比對 `version.txt`，一樣就跳過
   - 下載兩個 zip 到 `D:\Temp\Zip`（已下載過的會跳過）
   - 解壓到 `D:\llama\bin\`
   - 更新 `version.txt`

## 手動更新

```powershell
powershell -ExecutionPolicy Bypass -File D:\llama\resources\tools\update-llama.ps1
```

## 下載內容

| 資產 | 內容 |
|------|------|
| `cudart-llama-bin-win-cuda-13.3-x64.zip` | CUDA runtime + cuBLAS DLL |
| `llama-b9994-bin-win-cuda-13.3-x64.zip` | llama.cpp 二進位檔 |

## 注意

- API 限流（60 次/小時，無 token）時腳本會 fallback 到本地版本，不會報錯
- 要避免限流可設定 GitHub token：`$env:GITHUB_TOKEN = "ghp_xxx"`
- 暫存 zip 在 `D:\Temp\Zip`，不會重複下載
- 更新會完全替換 `bin\` 目錄

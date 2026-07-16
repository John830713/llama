# spec.md — update-llama.ps1 參數規格

## 參數

| 參數 | 預設值 | 說明 |
|------|--------|------|
| `-Dest` | D:\llama | 安裝目錄 |
| `-ZipDir` | D:\Temp\Zip | 暫存目錄 |
| `-AssetPattern1` | cudart-llama-bin-win-cuda-13.3-x64.zip | CUDA runtime 資產 |
| `-AssetPattern2` | llama-b9994-bin-win-cuda-13.3-x64.zip | llama.cpp 二進位資產 |

## 流程

1. 呼叫 GitHub API 取得最新 release tag
2. 比對 `version.txt`，一樣就跳過
3. 下載兩個 zip 到 ZipDir（已下載過的會跳過）
4. 清空 `bin/` 並解壓
5. 寫入 `version.txt`

## 注意

- API 限流（60 次/小時，無 token）時 fallback 到本地版本
- 模型路徑：`D:\Models\`
- 資產對應 CUDA 13.3（RTX 40/50 系列）

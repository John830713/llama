# usage.md — update-llama 使用範例

## 更新 llama.cpp

```powershell
# 方法 1：雙擊
D:\llama\update-llama.bat

# 方法 2：PowerShell
powershell -ExecutionPolicy Bypass -File D:\llama\resources\tools\update-llama\update-llama.ps1
```

## 查看版本

```powershell
Get-Content D:\llama\version.txt
```

## 跳過更新

腳本自動比對 `version.txt`，已是最新的話會自動跳過，不需要手動處理。

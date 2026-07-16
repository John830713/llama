# llama.cpp Local Deployment

llama.cpp Windows 本地部署，自動更新 + 模型管理。

## 安裝

1. 確認 CUDA 版本（RTX 40/50 用 CUDA 13.3，RTX 20/30 用 CUDA 12.4）
2. 執行 `update-llama.bat` 下載最新二進位
3. 在 `D:\Models\` 放入 GGUF 模型檔
4. 執行 `D:\llama_Models.bat` 啟動 server

## 更新

```powershell
# 方法 1：雙擊
D:\llama\update-llama.bat

# 方法 2：PowerShell
powershell -ExecutionPolicy Bypass -File D:\llama\resources\tools\local\update-llama\update-llama.ps1
```

腳本自動檢查 GitHub 最新版，下載到 `D:\Temp\Zip`，解壓到 `D:\llama\bin\`。

## 啟動 Server

```powershell
# Router 模式（自動掃描 Models 目錄）
D:\llama\bin\llama-server.exe --models-dir "D:\Models" --host 127.0.0.1 --port 9090 -ngl 10 -c 4096

# 或用 bat 自動排版
D:\llama_Models.bat
```

## API

Server 啟動後提供 OpenAI 相容 API：

```python
from openai import OpenAI

client = OpenAI(base_url="http://127.0.0.1:9090/v1", api_key="none")
response = client.chat.completions.create(
    model="qwen",
    messages=[{"role": "user", "content": "你好"}]
)
```

## 目錄結構

```
D:\llama\
├── bin\              # llama 二進位（gitignored，由 update-llama 管理）
├── resources\        # 文件與腳本（進 git）
│   ├── reference/    # 參數規格
│   ├── skills/       # 操作指引
│   └── tools/        # 系統工具
│       ├── common/   # 跨專案通用（ask）
│       └── local/    # 本機限定（update-llama）
├── update-llama.bat  # 更新入口
├── version.txt       # 目前版本
└── .agent\           # Runtime 資料（gitignored）
```

## 相關專案

- [ggml-org/llama.cpp](https://github.com/ggml-org/llama.cpp) — 上游專案
- [huggingface.co](https://huggingface.co) — GGUF 模型來源（搜尋 `gguf` tag）

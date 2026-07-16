# llama — llama.cpp 本地部署管理

管理 llama.cpp Windows 二進位、模型、server 啟動。

## 目錄

```
D:\llama\
├── INDEX.md              # 本檔案
├── AGENTS.md             # Agent 操作指引
├── opencode.json         # OpenCode 設定
├── README.md             # 專案文件
├── README.txt            # 快速 cheatsheet
├── update-llama.bat      # 更新入口
├── update-llama.ps1      # 更新腳本
├── version.txt           # 目前版本 (gitignored)
├── bin\                  # llama 二進位 (gitignored)
├── D:\Models\             # GGUF 模型（gitignored，外部目錄）
├── resources\            # 專案文件（進 git）
└── .agent\               # Runtime 資料 (gitignored)
```

## 快速開始

1. `update-llama.bat` — 下載最新 llama.cpp
2. 放 GGUF 模型到 `D:\Models\`
3. `D:\llama_Models.bat` — 啟動 server

## Forward links

| Path | Description |
|------|-------------|
| [resources/](resources/INDEX.md) | 專案文件與工具 |

## Referenced by

- *(Root node — entry point for this project's INDEX chain)*

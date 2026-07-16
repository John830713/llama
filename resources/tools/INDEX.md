# Tools — 系統工具

本機可用的腳本與工具。

## 結構

```
tools/
├── INDEX.md              # 本檔案
├── ask/                  # 本地模型 API
│   ├── INDEX.md
│   ├── spec.md
│   ├── usage.md
│   └── ask.ps1
└── update-llama/         # llama.cpp 更新
    ├── INDEX.md
    ├── spec.md
    ├── usage.md
    ├── update-llama.ps1
    └── update-llama.bat
```

## 工具清單

| 工具 | 用途 | 說明 |
|------|------|------|
| [ask](ask/) | 本地模型 API | 腳本生成、翻譯、摘要 |
| [update-llama](update-llama/) | 更新 llama.cpp | 自動下載最新二進位 |

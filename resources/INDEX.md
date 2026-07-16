# Resources — 專案文件

llama.cpp 本地部署的文件與操作指引。

## 結構

```
resources/
├── INDEX.md              # 本檔案
├── reference/            # 設計參考、規格
│   ├── INDEX.md
│   └── spec.md           # llama.cpp 參數、模型格式、CUDA 版本
├── skills/               # 操作指引
│   ├── INDEX.md
│   ├── update.md         # 更新流程
│   └── server.md         # llama-server 啟動與 API
└── tools/                # 系統工具
    ├── INDEX.md
    ├── update-llama.ps1  # 主更新腳本
    └── update-llama.bat  # bat 入口
```

## 查找

| 需要 | 位置 |
|------|------|
| llama-server 參數怎麼下 | `reference/spec.md` |
| 怎麼更新到最新版 | `skills/update.md` |
| 怎麼啟動 server / 用 API | `skills/server.md` |
| 更新腳本原始碼 | `tools/update-llama.ps1` |

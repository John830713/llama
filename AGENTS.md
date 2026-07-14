# AGENTS.md

## 角色

本倉庫管理 **llama.cpp 本地部署**，包含二進位更新、模型管理、server 啟動。

---

## 每次 Session 自動載入

### 啟動流程

1. 讀 `INDEX.md` — 理解專案結構
2. 讀 `AGENTS.md` — 確認操作規則
3. `mneme.switch_scope("llama")` — 切換 scope
4. 檢查 `.agent/TASKS/` — 處理未完成任務

### 安全規則

- **D:\Agent 所有內容僅供參考** — 不應修改 D:\Agent 目錄下任何檔案
- 寫入操作限於 `D:\llama\` 內
- 模型檔（GGUF）不進 git
- bin/ 目錄不進 git（由更新腳本管理）

---

## 查找

| 需要 | 位置 |
|------|------|
| 更新 llama.cpp | `resources/skills/update.md` 或雙擊 `update-llama.bat` |
| 啟動 server / API 用法 | `resources/skills/server.md` |
| 參數規格、模型格式 | `resources/reference/spec.md` |
| 更新腳本原始碼 | `resources/tools/update-llama.ps1` |
| 新機台環境建置 | `resources/reference/spec.md`（CUDA 版本對照） |

---

## 指令速查

```powershell
# 更新 llama.cpp
D:\llama\update-llama.bat

# 啟動 server（Router 模式）
D:\llama\bin\llama-server.exe --models-dir "D:\Models" --host 127.0.0.1 --port 9090 -ngl 10 -c 4096

# 啟動 server（bat 自動排版）
D:\llama_Models.bat

# 健康檢查
curl http://127.0.0.1:9090/health

# 查看已安裝版本
Get-Content D:\llama\version.txt
```

---

## 目錄結構

```
D:\llama\
├── AGENTS.md              # 本檔案
├── opencode.json          # OpenCode 設定
├── README.md              # 專案文件
├── README.txt             # 快速 cheatsheet
├── update-llama.ps1       # 更新腳本（根目錄副本）
├── update-llama.bat       # bat 入口（根目錄副本）
├── version.txt            # 目前版本 (gitignored)
├── bin\                   # llama 二進位 (gitignored)
├── Models\                # GGUF 模型 (gitignored)
├── resources\             # 專案文件（進 git）
│   ├── reference/         # 設計參考
│   ├── skills/            # 操作指引
│   └── tools/             # 系統工具
└── .agent\                # Runtime 資料 (gitignored)
```

---

## 工具管理

| 工具 | 位置 | 用途 |
|------|------|------|
| ask.ps1 | `resources/tools/` | 本地模型 API（腳本生成、翻譯、摘要） |
| update-llama.ps1 | `resources/tools/` | 更新 llama.cpp 二進位 |
| update-llama.bat | 根目錄 + `resources/tools/` | 雙擊執行入口 |
| D:\llama_Models.bat | D:\ 根目錄 | 啟動 server + Interpreter |

### Token 節省流程

簡單任務可丟給本地模型，我只負責檢查與修正：

```powershell
# 1. 本地模型寫腳本
powershell -File D:\llama\tools\ask.ps1 -Prompt "寫一個 xxx 腳本" -System "Output raw code only"

# 2. 我檢查修正
# 3. 執行驗證
```

---

## mneme 設定

- scope: `llama`
- 跨 session 記憶：使用 `remember`/`recall`
- 決策、偏好 → `mneme_pin`
- 臨時進度 → `.agent/LOGS/`

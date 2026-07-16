# AGENTS.md

llama.cpp 本地部署管理（Windows），包含二進位更新、模型管理、server 啟動。

## 安全規則

- **D:\Agent 所有內容僅供參考** — 不應修改 D:\Agent 目錄下任何檔案
- 寫入操作限於 `D:\llama\` 內
- 模型檔（GGUF）不進 git，`bin/` 不進 git（由更新腳本管理）

## Git 規則

提交前必須先讀 `D:\Agent\resources\reference\git\INDEX.md`，遵守其中的 commit 規則、undo 流程與 safety 規範。

## 查找

| 需要 | 位置 |
|------|------|
| 更新 llama.cpp | `resources/skills/update.md` 或雙擊 `update-llama.bat` |
| 啟動 server / API 用法 | `resources/skills/server.md` |
| 參數規格、模型格式 | `resources/reference/spec.md` |
| 更新腳本原始碼 | `resources/tools/local/update-llama/` |
| 本地模型 API | `resources/tools/common/ask/` |
| 新機台環境建置 | `resources/reference/spec.md`（CUDA 版本對照） |
| Git commit 規則 | `D:\Agent\resources\reference\git\INDEX.md`（只讀參考） |

## 指令速查

```powershell
# 更新 llama.cpp
D:\llama\update-llama.bat

# 啟動 server（Router 模式）
D:\llama\bin\llama-server.exe --models-dir "D:\Models" --host 127.0.0.1 --port 8080 -ngl 10 -c 4096

# 啟動 server（bat 自動排版）
D:\llama_Models.bat

# 健康檢查
curl http://127.0.0.1:8080/health

# 查看已安裝版本
Get-Content D:\llama\version.txt
```

## 工具

| 工具 | 位置 | 用途 |
|------|------|------|
| ask.ps1 | `resources/tools/common/ask/` | 本地模型 API（腳本生成、翻譯、摘要） |
| update-llama.ps1 | `resources/tools/local/update-llama/` | 更新 llama.cpp 二進位 |
| update-llama.bat | 根目錄 | 雙擊執行更新入口 |

### Token 節省流程

簡單任務可丟給本地模型，我只負責檢查與修正：

```powershell
powershell -File D:\llama\resources\tools\common\ask\ask.ps1 -Prompt "寫一個 xxx 腳本" -System "Output raw code only"
```

## mneme 設定

- scope: `llama`
- 跨 session 記憶：使用 `remember`/`recall`
- 決策、偏好 → `mneme_pin`
- 臨時進度 → `.agent/LOGS/`

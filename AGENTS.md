# AGENTS.md

llama.cpp Windows 本地部署管理 — 二進位更新、模型管理、server 啟動。

## 安全規則

- **D:\Agent 僅供參考** — 絕不修改 D:\Agent 下任何檔案
- 寫入操作限於 `D:\llama\` 內

## Git 規則

- 提交前必須先讀 `D:\Agent\resources\reference\git\INDEX.md`，遵守其中 commit 規則、undo 流程與 safety 規範
- `bin/`、`version.txt`、`.agent/` 已 gitignore — 由更新腳本管理，不要手動 git add
- 修改 `INDEX.md` 時 pre-commit hook 會提醒更新 `.index.json`
- `model/` 下的 GGUF 檔案不進 git（太大）

## 非顯而易見的约束

- 更新腳本 `update-llama.ps1` 目前硬編碼下載 **CUDA 13.3**（RTX 40/50 系列）。RTX 20/30 系列需改用 CUDA 12.4 zip — 要手動改腳本參數
- Port 8074–8173 被 Hyper-V/WSL 保留，不可用
- `ask.ps1` 需要 server 先啟動才能使用（它打 `http://127.0.0.1:8080/v1/chat/completions`）
- `chat.bat` 使用 `open-interpreter` 指向 Gemma-4 模型，需先安裝 `pip install open-interpreter`
- GitHub API 限流（60 次/小時無 token）時更新腳本會 fallback 到已知版本，不會報錯。可設 `$env:GITHUB_TOKEN` 避免

## 參考文件

| 需要 | 位置 |
|------|------|
| 更新 llama.cpp | `resources/skills/update.md` 或雙擊 `update-llama.bat` |
| 啟動 server / API 用法 | `resources/skills/server.md` |
| 參數規格、模型格式、CUDA 版本對照 | `resources/reference/spec.md` |
| 更新腳本原始碼 | `resources/tools/local/update-llama/update-llama.ps1` |
| 本地模型 API 工具 | `resources/tools/common/ask/ask.ps1` |

## 常用指令

```powershell
# 更新 llama.cpp
D:\llama\update-llama.bat

# 啟動 server（Router 模式，自動掃描 D:\Models）
D:\llama\bin\llama-server.exe --models-dir "D:\Models" --host 127.0.0.1 --port 8080 -ngl 10 -c 4096

# 健康檢查
curl http://127.0.0.1:8080/health

# 查看已安裝版本
Get-Content D:\llama\version.txt

# 問本地模型（需 server 先跑起來）
powershell -File D:\llama\resources\tools\common\ask\ask.ps1 -Prompt "你的問題" -System "Output raw code only"
```

## mneme 設定

- scope: `llama`
- 跨 session 記憶：`remember`/`recall`
- 決策、偏好 → `mneme_pin`
- 臨時進度 → `.agent/LOGS/`

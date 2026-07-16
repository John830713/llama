# spec.md — ask.ps1 參數規格

## 參數

| 參數 | 類型 | 預設值 | 說明 |
|------|------|--------|------|
| `-Prompt` | string | （必填） | 輸入指令 |
| `-System` | string | "" | 系統提示（角色設定） |
| `-Model` | string | Gemma-4-Q4_K_M | 模型名稱 |
| `-Server` | string | http://127.0.0.1:8080 | API 端點 |
| `-MaxTokens` | int | 2048 | 最大輸出 token |
| `-Temperature` | float | 0.3 | 溫度（越低越穩定） |
| `-Raw` | switch | false | 輸出原始內容（不清理 markdown） |

## 模型

| 模型 | 速度 | 適合 |
|------|------|------|
| Gemma-4-Q4_K_M | 21 tok/s | 中文、腳本生成 |
| Qwen2.5-VL-7B-Instruct-Q4_K_M | 63 tok/s | 快速任務（英文為主） |
| Qwen3.6-35B-A3B-Uncensored-HauhauCS-Aggressive-IQ2_M | 17 tok/s | 特殊用途 |

## 輸出處理

- 預設會清理 markdown code fencing（```` ``` ````）
- 加 `-Raw` 參數保留原始輸出
- Gemma-4 是思考模型，推理 token 會佔用預算，建議 MaxTokens >= 2048

## 依賴

- llama-server 必須在 port 8080 運行
- PowerShell 5.1+

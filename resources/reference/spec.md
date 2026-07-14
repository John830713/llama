# spec.md — llama.cpp 參數規格

## llama-server 常用參數

| 參數 | 說明 | 範例 |
|------|------|------|
| `--model` | 指定單一模型路徑 | `--model D:\Models\qwen.gguf` |
| `--models-dir` | 模型目錄（自動掃描 .gguf） | `--models-dir D:\Models` |
| `--host` | 監聽地址 | `--host 127.0.0.1` |
| `--port` | 監聽 port | `--port 9090` |
| `-ngl` | GPU offload 層數 | `-ngl 10`（越大越吃 VRAM） |
| `-c` | context window size | `-c 4096` |
| `-t` | 執行緒數 | `-t 4` |
| `--chat-template` | 聊天模板 | `--chat-template chatml` |

## 啟動模式

- **單模型**：`llama-server.exe --model <path>` — 直接載入指定模型
- **Router 模式**：`llama-server.exe --models-dir <dir>` — 自動掃描，按需載入（預設）

## API 端點

| 端點 | 方法 | 說明 |
|------|------|------|
| `/health` | GET | 健康檢查 |
| `/v1/models` | GET | 列出可用模型 |
| `/v1/chat/completions` | POST | OpenAI 相容 Chat API |
| `/v1/completions` | POST | OpenAI 相容 Completion API |
| `/v1/embeddings` | POST | 向量嵌入 |

## 模型格式

- 唯一支援格式：**GGUF**（`.gguf` 副檔名）
- 來源：[huggingface.co](https://huggingface.co) 搜尋 `gguf` tag
- 量化等級（由大到小）：`Q8_0` > `Q6_K` > `Q5_K_M` > `Q4_K_M` > `Q3_K_M` > `IQ2_M`
- 越小越省 VRAM，但品質略降

## CUDA 版本對照

| 資產名稱 | CUDA 版本 | 適用 |
|----------|-----------|------|
| `cudart-llama-bin-win-cuda-12.4-x64.zip` | CUDA 12.4 | 舊卡（RTX 20/30 系列） |
| `cudart-llama-bin-win-cuda-13.3-x64.zip` | CUDA 13.3 | 新卡（RTX 40/50 系列） |

## VRAM 估算

| 模型大小 | Q4_K_M 估算 VRAM | Q8_0 估算 VRAM |
|----------|-------------------|-----------------|
| 7B | ~4 GB | ~7 GB |
| 14B | ~8 GB | ~14 GB |
| 35B-A3B | ~3 GB | ~5 GB |
| 70B | ~35 GB | ~70 GB |

> MoE 模型（如 Qwen3.6-35B-A3B）實際只啟動少量專家，VRAM 需求遠小於參數量。

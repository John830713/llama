# server.md — llama-server 啟動與 API

## 啟動方式

### Router 模式（推薦）

自動掃描 Models 目錄，按需載入模型：

```powershell
D:\llama\bin\llama-server.exe --models-dir "D:\Models" --host 127.0.0.1 --port 9090 -ngl 10 -c 4096
```

### 單模型模式

直接載入指定模型：

```powershell
D:\llama\bin\llama-server.exe --model "D:\Models\Gemma-4-Q4_K_M.gguf" --host 127.0.0.1 --port 9090 -ngl 10 -c 4096
```

## 用 bat 啟動

| bat | 用途 |
|-----|------|
| `start-server.bat` | 啟動 server + 列出模型 |
| `interpreter.bat` | 互動對話（Gemma-4） |
| `D:\llama_Models.bat` | 啟動 server + Interpreter + 自動排版 |

## API 用法

### 健康檢查

```bash
curl.exe -s http://127.0.0.1:9090/health
```

### 列出模型

```bash
curl.exe -s http://127.0.0.1:9090/v1/models
```

### Chat API（OpenAI 相容）

```bash
curl.exe -s http://127.0.0.1:9090/v1/chat/completions ^
  -H "Content-Type: application/json" ^
  -d "{\"model\":\"Gemma-4-Q4_K_M\",\"messages\":[{\"role\":\"user\",\"content\":\"hello\"}]}"
```

### Python 連接

```python
from openai import OpenAI

client = OpenAI(base_url="http://127.0.0.1:9090/v1", api_key="none")
response = client.chat.completions.create(
    model="Gemma-4-Q4_K_M",
    messages=[{"role": "user", "content": "你好"}]
)
print(response.choices[0].message.content)
```

## Port 衝突處理

如果遇到 `couldn't bind HTTP server socket`：
1. 確認 port 沒被佔用：`netstat -ano | findstr :9090`
2. 換個 port：`--port 8888` 或 `--port 7860`
3. 注意：port 8074-8173 被 Hyper-V/WSL 保留，不可用

## 最佳參數（RTX PRO 2000 Blackwell 8GB VRAM）

| 模型 | 參數 | 速度 | VRAM |
|------|------|------|------|
| Qwen2.5-VL-7B Q4_K_M | `-ngl 99 -c 32768` | 63 tok/s | 6.2 GB |
| Gemma-4 Q4_K_M | `-ngl 10 -c 4096` | 21 tok/s | 6.0 GB |
| Qwen3.6-35B-A3B IQ2_M | `-ngl 10 -c 4096` | 17 tok/s | 3.1 GB |

### 常用參數組合

| 場景 | 參數 |
|------|------|
| 日常快速任務 | `-ngl 99 -c 32768`（Qwen2.5-VL-7B） |
| 強推理 | `-ngl 10 -c 4096`（Gemma-4） |
| 純 CPU | `-ngl 0 -c 2048` |

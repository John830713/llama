# server.md — llama-server 啟動與 API

## 啟動方式

### Router 模式（推薦）

自動掃描 Models 目錄，按需載入模型：

```powershell
D:\llama\bin\llama-server.exe --models-dir "D:\Models" --host 127.0.0.1 --port 8080 -ngl 10 -c 4096
```

### 單模型模式

直接載入指定模型：

```powershell
D:\llama\bin\llama-server.exe --model "D:\Models\qwen.gguf" --host 127.0.0.1 --port 8080 -ngl 10 -c 4096
```

## 用 bat 啟動

`D:\llama_Models.bat` 會自動：
1. 指向 `D:\llama\bin\`
2. 從 `D:\Models` 載入模型
3. 啟動 server + Interpreter
4. 自動並排視窗

## API 用法

### 健康檢查

```bash
curl http://127.0.0.1:8080/health
```

### 列出模型

```bash
curl http://127.0.0.1:8080/v1/models
```

### Chat API（OpenAI 相容）

```bash
curl http://127.0.0.1:8080/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "qwen",
    "messages": [{"role": "user", "content": "你好"}]
  }'
```

### Python 連接

```python
from openai import OpenAI

client = OpenAI(base_url="http://127.0.0.1:8080/v1", api_key="none")
response = client.chat.completions.create(
    model="qwen",
    messages=[{"role": "user", "content": "你好"}]
)
print(response.choices[0].message.content)
```

## Port 衝突處理

如果遇到 `couldn't bind HTTP server socket`：
1. 確認 port 沒被佔用：`netstat -ano | findstr :8080`
2. 換個 port：`--port 8081` 或 `--port 9090`
3. 注意：`D:\llama_Models.bat` 目前設定 port 9090

## 常用參數組合

| 場景 | 參數 |
|------|------|
| 輕量測試 | `-ngl 0 -c 2048`（純 CPU） |
| 一般使用 | `-ngl 10 -c 4096` |
| 大 context | `-ngl 10 -c 32768` |
| 最大 GPU | `-ngl 99 -c 4096`（全部 offload） |

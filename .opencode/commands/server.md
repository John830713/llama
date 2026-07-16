# /server — 啟動 llama-server

啟動 llama-server 並顯示可用模型清單。

## 流程

1. 檢查 port 9090 是否已被佔用
2. 如果已在跑，直接查詢模型清單
3. 如果沒在跑，啟動 server 並等待就緒
4. 呼叫 `/v1/models` 顯示模型清單

## 用法

在 OpenCode 中輸入 `/server` 即可。

## 依賴

- `D:\llama\bin\llama-server.exe`
- `D:\Models\` 目錄下有 GGUF 模型

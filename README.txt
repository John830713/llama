# llama.cpp 快速 cheatsheet

## 更新
  D:\llama\update-llama.bat

## 啟動 server
  D:\llama\bin\llama-server.exe --models-dir "D:\Models" --host 127.0.0.1 --port 9090 -ngl 10 -c 4096

## 啟動（自動排版）
  D:\llama_Models.bat

## 健康檢查
  curl http://127.0.0.1:9090/health

## 列出模型
  curl http://127.0.0.1:9090/v1/models

## Chat API
  curl http://127.0.0.1:9090/v1/chat/completions -H "Content-Type: application/json" -d "{\"model\":\"qwen\",\"messages\":[{\"role\":\"user\",\"content\":\"hi\"}]}"

## 查看版本
  type D:\llama\version.txt

## Port 衝突
  netstat -ano | findstr :9090
  換 port: --port 8081

## 模型放置
  D:\Models\  放 .gguf 檔案

## VRAM 估算（Q4_K_M）
  7B ~4GB | 14B ~8GB | 70B ~35GB

## 文件
  resources/skills/update.md    更新流程
  resources/skills/server.md    API 用法
  resources/reference/spec.md   參數規格

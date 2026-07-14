@echo off
chcp 65001 >nul
setlocal

:: Usage: gen.bat "write a powershell script that..."
:: Output: script content on stdout

set "PROMPT=%~1"
if "%PROMPT%"=="" (
    echo Usage: gen.bat "your prompt here"
    exit /b 1
)

set "FULL_PROMPT=You are a script generator. Output ONLY the raw script code, no explanation, no markdown fencing, no comments. Task: %PROMPT%"

curl.exe -s http://127.0.0.1:9090/v1/chat/completions ^
  -H "Content-Type: application/json" ^
  -d "{\"model\":\"Qwen2.5-VL-7B-Instruct-Q4_K_M\",\"messages\":[{\"role\":\"user\",\"content\":\"%FULL_PROMPT%\"}],\"max_tokens\":2048,\"temperature\":0.1}" | powershell -NoProfile -Command "$input | ConvertFrom-Json | Select-Object -ExpandProperty choices | ForEach-Object { $_.message.content }"

endlocal

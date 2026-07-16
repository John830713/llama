@echo off
chcp 65001 >nul

set "HOST=127.0.0.1"
set "PORT=8080"

echo Starting llama-server...
start "llama_server" D:\llama\bin\llama-server.exe --models-dir "D:\Models" --host %HOST% --port %PORT% -ngl 10 -c 4096

echo Waiting for server...
timeout /t 5 /nobreak >nul

echo.
echo === Model List ===
curl.exe -s http://%HOST%:%PORT%/v1/models
echo.
echo.
pause

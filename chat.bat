@echo off
chcp 65001 >nul

set "PORT=8080"
set "MODEL=Gemma-4-Q4_K_M"

curl -s http://127.0.0.1:%PORT%/health >nul 2>&1
if %errorlevel%==0 (
    echo Server already running on port %PORT%
    goto START_INTERPRETER
)

echo Starting llama-server on port %PORT%...
powershell -NoProfile -Command "Start-Process -FilePath 'D:\llama\bin\llama-server.exe' -ArgumentList '--models-dir D:\Models --host 127.0.0.1 --port 8080 -ngl 10 -c 4096' -WindowStyle Hidden"

echo Waiting for server...
:WAIT_LOOP
timeout /t 3 /nobreak >nul
curl -s http://127.0.0.1:%PORT%/health >nul 2>&1
if %errorlevel% neq 0 goto WAIT_LOOP
echo Server ready!

:START_INTERPRETER
echo ============================================
echo   llama.cpp Interpreter (via open-interpreter)
echo   Model: %MODEL%
echo ============================================
echo.

interpreter --api_base http://127.0.0.1:%PORT%/v1 --model "%MODEL%" -y

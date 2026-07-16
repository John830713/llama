@echo off
chcp 65001 >nul
setlocal

echo ============================================
echo   llama.cpp Interpreter (via open-interpreter)
echo   Server: http://127.0.0.1:8080/v1
echo   Model: Gemma-4-Q4_K_M
echo ============================================
echo.

interpreter --api_base http://127.0.0.1:8080/v1 --model "openai/Gemma-4-Q4_K_M" --context_window 4096 --max_tokens 2048 -y

endlocal

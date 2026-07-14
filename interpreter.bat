@echo off
chcp 65001 >nul
setlocal

set "MODEL=D:\Models\Gemma-4-Q4_K_M.gguf"

echo ============================================
echo   llama.cpp Interpreter
echo   Model: Gemma-4
echo   Type /exit to quit
echo ============================================
echo.

D:\llama\bin\llama-cli.exe --model "%MODEL%" -ngl 10 -c 4096 -sys "You are a helpful assistant. Reply in Traditional Chinese." -cnv -t 4

endlocal

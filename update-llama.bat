@echo off
chcp 65001 >nul
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0resources\tools\local\update-llama\update-llama.ps1"
pause

# usage.md — ask.ps1 使用範例

## 基本用法

```powershell
# 寫腳本
powershell -File D:\llama\resources\tools\ask\ask.ps1 -Prompt "寫一個 ps1 把 CSV 轉 JSON" -System "Output raw code only"

# 翻譯
powershell -File D:\llama\resources\tools\ask\ask.ps1 -Prompt "Translate: hello world" -System "翻譯成繁體中文"

# 摘要
powershell -File D:\llama\resources\tools\ask\ask.ps1 -Prompt "摘要: <長文>" -System "用一句話總結"

# Code 解釋
powershell -File D:\llama\resources\tools\ask\ask.ps1 -Prompt "解釋這段 code: <code>" -System "用繁體中文解釋"
```

## Token 節省流程

```
你提需求 → 我判斷難度 →
  簡單 → ask.ps1 生成 → 我檢查 → 執行
  複雜 → 我自己做
```

## 適合委派的任務

| 任務 | 範例 |
|------|------|
| 簡單腳本 | CSV→JSON、檔案篩選 |
| 翻譯 | 英↔中 |
| 摘要 | 長文壓縮 |
| Code 解釋 | 單段落 |
| 格式轉換 | JSON↔CSV |
| HTML/CSS | 簡單頁面 |

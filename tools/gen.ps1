param(
    [Parameter(Mandatory=$true)]
    [string]$Prompt,
    [string]$Model = "Qwen2.5-VL-7B-Instruct-Q4_K_M",
    [string]$Server = "http://127.0.0.1:9090",
    [int]$MaxTokens = 2048,
    [float]$Temperature = 0.1
)

$fullPrompt = "You are a script generator. Output ONLY the raw script code, no explanation, no markdown fencing, no backticks, no comments. Task: $Prompt"

$body = @{
    model = $Model
    messages = @(@{ role = "user"; content = $fullPrompt })
    max_tokens = $MaxTokens
    temperature = $Temperature
} | ConvertTo-Json -Depth 3

$response = Invoke-RestMethod -Uri "$Server/v1/chat/completions" -Method Post -ContentType "application/json; charset=utf-8" -Body ([System.Text.Encoding]::UTF8.GetBytes($body))
$response.choices[0].message.content

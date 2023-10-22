param(
  [string]$test1,
  [parameter(ValueFromRemainingArguments=$true)]
  $rest
)

Write-Host $rest
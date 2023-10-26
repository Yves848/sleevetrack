$l = Import-Csv -Path './JournalPoids 2023-10-23.csv'


class pesee {
  [string]$date
  [string]$poids

  Pesee(
    [string]$date,
    [string]$poids
  ){
    $this.date = $date
    $this.poids = $poids
  }
}
$w = $l | Where-Object { $_.units -match "\d{4}-\d{2}-\d{2}"}

$weights = @()
$w | foreach-Object {
   $x = $_.units | Select-String -Pattern "\d{4}-\d{2}-\d{2}"
   #$x.Matches[0].Value
   $y = $_.kg | Select-String -Pattern "\d{3}\.\d{1}"
   #$y.Matches[0].Value
  $pesee = [pesee]::new($x.Matches[0].Value,$y.Matches[0].Value)
   $weights += $pesee
}
$weights | ConvertTo-Json | Out-File -FilePath ./poids.json 
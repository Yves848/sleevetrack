$path = Join-Path -Path $PSScriptRoot 'sqlite.net\System.Data.SQLite.dll'

[System.Reflection.Assembly]::LoadFile($path) | Out-Null

$Database = Join-Path -Path $PSScriptRoot -ChildPath "Data/weights.sqlite"

$requests = Join-Path -Path $PSScriptRoot -ChildPath "requests.ps1"

. $requests

if (-not (Test-Path -Path $Database)) {
  Write-Host "Database Missing"
  Write-Host "Creating Database ...."
  $folder = Join-Path -Path $PSScriptRoot -ChildPath "Data"
  if (-not (Test-Path -Path $folder -PathType Container)) {
    New-Item -Path $folder -ItemType Directory | Out-Null
  }
  [System.Data.SQLite.SQLiteConnection]::CreateFile($Database)
  $DatabaseConnectionString = [string]::Format("data source={0}", $Database)
  $SQLiteDBConnection = New-Object System.Data.SQLite.SQLiteConnection
  $SQLiteDBConnection.ConnectionString = $DatabaseConnectionString
  $SQLiteDBConnection.open()
  $SQLiteDBCommand = $SQLiteDBConnection.CreateCommand()
  $SQLiteDBCommand.Commandtext = $create_poids
  $SQLiteDBCommand.CommandType = [System.Data.CommandType]::Text
  $SQLiteDBCommand.ExecuteNonQuery()
  $SQLiteDBConnection.close()
  Remove-Variable -Name $SQLiteDBConnection
}

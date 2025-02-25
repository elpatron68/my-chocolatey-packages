$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://download.yajhfc.de/releases/yajhfc-0_6_3-setup.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'YajHFC*'

  checksum      = '5777BACC6AD1CF3954EBD1CBFB74460984196F04621DE3B6690B6381436844B5'
  checksumType  = 'sha256'

  silentArgs    = "/VERYSILENT /NORESTART /SUPRESSMSGBOXES"
  validExitCodes= @(0)
}

# silent install requires AutoHotKey after installer removed silent flag
$ahkFile = Join-Path $toolsPath "yajhfc.ahk"
$ahkProc = Start-Process -FilePath AutoHotkey.exe -ArgumentList "$ahkFile" -PassThru
Write-Debug "AutoHotKey start time:`t$($ahkProc.StartTime.ToShortTimeString())"
Write-Debug "AutoHotKey Process ID:`t$($ahkProc.Id)"

Install-ChocolateyPackage @packageArgs

Remove-Item -Force -ea 0 "$toolsDir\*.$($packageArgs.fileType)*"
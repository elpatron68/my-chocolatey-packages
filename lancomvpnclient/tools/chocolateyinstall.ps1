$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://www.lancom-systems.de/download/LC-VPN-Client/LC-Advanced-VPN-Client-Win-410-Rel-x86.exe'
$url64      = 'http://www.lancom-systems.de/download/LC-VPN-Client/LC-Advanced-VPN-Client-Win-410-Rel-x86-64.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  url64bit      = $url64

  softwareName  = 'lancomvpnclient*'

  checksum      = '1B720F85FB4DD41755B54B4C8F0A27CDB06382675306B027F6469F4617BCB911'
  checksumType  = 'sha256'
  checksum64    = '4633939642E29FD88C2D31DB6FEA0BE57EFCCE08D55797E0266E38CEC33E089F'
  checksumType64= 'sha256'

  silentArgs    = '/s /v" /qn/norestart"'
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs

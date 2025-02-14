$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://my.lancom-systems.de/download/LC-VPN-Client/LC-Advanced-VPN-Client-Win-622-Rel-x86-64.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  
  softwareName  = 'LANCOM Trusted Access Client*'

  checksum      = '89CB5E95986E195E4DAF5B3CE4FDD892A4FD2849FC08EAFFC7D5A28C02B1DA0C'
  checksumType  = 'sha256'
  
  silentArgs    = '/s /l1031< /v"/qn /norestart"'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

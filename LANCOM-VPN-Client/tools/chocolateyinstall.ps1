$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://my.lancom-systems.de/download/LC-VPN-Client/LC-Advanced-VPN-Client-Win-623-Rel-x86-64.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  
  softwareName  = 'LANCOM Trusted Access Client*'

  checksum      = 'b933ea0f31ae163fc6184f6932690a9e15d006b96fd3894d91a1025f52484b0d'
  checksumType  = 'sha256'
  
  silentArgs    = '/s /l1031< /v"/qn /norestart"'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

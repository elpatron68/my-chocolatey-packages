$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://my.lancom-systems.de/download/LC-VPN-Client/LC-Advanced-VPN-Client-Win-624-Rel-x86-64.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  
  softwareName  = 'LANCOM Trusted Access Client*'

  checksum      = '3b3cf3b41d0185425652eefe883694dd6a2c2b087ac50a3d72672cb6c748819b'
  checksumType  = 'sha256'
  
  silentArgs    = '/s /l1031< /v"/qn /norestart"'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

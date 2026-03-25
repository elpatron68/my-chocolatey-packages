$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://my.lancom-systems.de/download/LC-VPN-Client/LC-Advanced-VPN-Client-Win-625-Rel-x86-64.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  
  softwareName  = 'LANCOM Trusted Access Client*'

  checksum      = '3be63daaf76442dc00d8ab77bac7e11b0c0786b0a91e5be7c1e51d71f189933f'
  checksumType  = 'sha256'
  
  silentArgs    = '/s /l1031< /v"/qn /norestart"'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

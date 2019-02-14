$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/royhills/ike-scan/releases/download/1.9/ike-scan-win32-1.9.zip'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  url           = $url
  UnzipLocation = $toolsDir
  softwareName  = 'ike-scan*'

  checksum      = 'A1FC3AB759DB70DEBC282E39196F36612221F48BAFCFE6CFF718FF37C988A810'
  checksumType  = 'sha256'
  
}
Install-ChocolateyZipPackage @packageArgs

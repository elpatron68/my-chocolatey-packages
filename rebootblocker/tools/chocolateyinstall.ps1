$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://www.udse.de/download/RebootBlockerSetup.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'rebootblocker*'

  checksum      = '0AC4C5E204C9AD74233AA183F0FBE6E24605A8804CFC0EB17DEAE31A92D4BA02'
  checksumType  = 'sha256'
  
  silentArgs    = "/silent /norestart"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

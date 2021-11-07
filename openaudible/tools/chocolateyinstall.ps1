$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/openaudible/openaudible/releases/download/v3.2.1/OpenAudible_3.2.1.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  
  softwareName  = 'openaudible*'

  checksum      = 'b235084c2c8642bb5d2358c63e17362b55a9f9837ebb3cb5f28ca48c6f1f5b9f'
  checksumType  = 'sha256'

  silentArgs    = "-q"
  validExitCodes= @(0)
  
}

Install-ChocolateyPackage @packageArgs

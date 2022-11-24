$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/openaudible/openaudible/releases/download/v3.6.3/OpenAudible_3.6.3_x86_64.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  
  softwareName  = 'openaudible*'

  checksum      = '08170f1d7247f21812bcb8e57d65120b1d41f67637fc4f744ecb869348e34d72'
  checksumType  = 'sha256'

  silentArgs    = "-q"
  validExitCodes= @(0)
  
}

Install-ChocolateyPackage @packageArgs

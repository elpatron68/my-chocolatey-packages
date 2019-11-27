$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/openaudible/openaudible/releases/download/v1.6.2/OpenAudible_1.6.2_win.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  
  softwareName  = 'openaudible*'

  checksum      = 'e8e6708e958369b4356be1acabd8a94b3b2c5bfb0f5d4a4489f560500552cb95'
  checksumType  = 'sha256'

  silentArgs    = "-q -overwrite"
  validExitCodes= @(0)
  
}

Install-ChocolateyPackage @packageArgs

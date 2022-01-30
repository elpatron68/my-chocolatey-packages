$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/openaudible/openaudible/releases/download/v3.4/OpenAudible_3.4_x86_64.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  
  softwareName  = 'openaudible*'

  checksum      = '329b301c44059908eb4cc95c165bdc13df50188c62fe2fea7a676b8b92e0efc1'
  checksumType  = 'sha256'

  silentArgs    = "-q"
  validExitCodes= @(0)
  
}

Install-ChocolateyPackage @packageArgs

$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/openaudible/openaudible/releases/download/v3.0.2/OpenAudible_3.0.2.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  
  softwareName  = 'openaudible*'

  checksum      = '7d5b6ccd2d7c364769c79aef5e5e9775249aeb623f02891c50e4de44c6194102'
  checksumType  = 'sha256'

  silentArgs    = "-q"
  validExitCodes= @(0)
  
}

Install-ChocolateyPackage @packageArgs

$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/openaudible/openaudible/releases/download/v3.5.1/OpenAudible_3.5.1_x86_64.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  
  softwareName  = 'openaudible*'

  checksum      = 'f076321c8ceafb96b3b7d0d547fa908122750439581d946fc4f93a48c102fac4'
  checksumType  = 'sha256'

  silentArgs    = "-q"
  validExitCodes= @(0)
  
}

Install-ChocolateyPackage @packageArgs

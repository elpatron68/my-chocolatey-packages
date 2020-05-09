$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/openaudible/openaudible/releases/download/v2.0.6/OpenAudible_2.0.6_win.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  
  softwareName  = 'openaudible*'

  checksum      = '4e218234d4c36591d4eb9c4fe6c2da34c13836ba52a9c8869e476d029ce98864'
  checksumType  = 'sha256'

  silentArgs    = "-q -overwrite"
  validExitCodes= @(0)
  
}

Install-ChocolateyPackage @packageArgs

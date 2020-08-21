$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/openaudible/openaudible/releases/download/v2.3.4/OpenAudible_2.3.4_win.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  
  softwareName  = 'openaudible*'

  checksum      = '92cc05f5faa4aa0451b3e85e199e3aacbad79e29a2ffb4582d9b5222b4ad2f4a'
  checksumType  = 'sha256'

  silentArgs    = "-q -overwrite"
  validExitCodes= @(0)
  
}

Install-ChocolateyPackage @packageArgs

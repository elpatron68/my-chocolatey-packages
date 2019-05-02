$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64      = 'https://github.com/openaudible/openaudible/releases/download/v1.5.0/OpenAudible_win_1.5.0.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url64bit      = $url64
  
  softwareName  = 'openaudible*'

  checksum64    = '2D52F536972F55C6440BB47B5F3688CD684FE6B2CFC0675387A9B7B024A0B439'
  checksumType64= 'sha256'

  silentArgs    = "-q -overwrite"
  validExitCodes= @(0)
  
}

Install-ChocolateyPackage @packageArgs

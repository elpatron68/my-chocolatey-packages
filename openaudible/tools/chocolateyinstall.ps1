$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64      = 'https://github.com/openaudible/openaudible/releases/download/v1.5.1/OpenAudible_win_1.5.1.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url64bit      = $url64
  
  softwareName  = 'openaudible*'

  checksum64    = '27C36506C0C11568E49D91368238B4EEDF35672795FBFCC13AE6D4E1960908C6'
  checksumType64= 'sha256'

  silentArgs    = "-q -overwrite"
  validExitCodes= @(0)
  
}

Install-ChocolateyPackage @packageArgs

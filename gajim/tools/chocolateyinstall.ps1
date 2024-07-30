$ErrorActionPreference = 'Stop';
$url64      = 'https://gajim.org/downloads/1.9/Gajim-1.9.3-64bit.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url64

  softwareName  = 'gajim*'

  checksum64    = '2d84d8b8fe4e1cd6d59c024bb92354c6cd05ae48d922dfeacccc0b8481b828b7'
  checksumType  = 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

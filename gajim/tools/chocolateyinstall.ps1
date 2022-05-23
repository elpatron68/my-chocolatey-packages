$ErrorActionPreference = 'Stop';
$url      = 'https://gajim.org/downloads/1.4/Gajim-1.4.1-64bit.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'gajim*'

  checksum    = 'a91fe698279ff0fb6548228b04ca4c0d26cc4c598c4bb8b397551e32f0b9b402'
  checksumType= 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

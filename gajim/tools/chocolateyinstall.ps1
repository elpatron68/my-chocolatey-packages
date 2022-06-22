$ErrorActionPreference = 'Stop';
$url64      = 'https://gajim.org/downloads/1.4/Gajim-1.4.5-64bit.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url64

  softwareName  = 'gajim*'

  checksum64    = '1dcfd307ebafcd795a52ef8384c939934fd711a640f10620f5f59d4154164d2d'
  checksumType  = 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

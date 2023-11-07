$ErrorActionPreference = 'Stop';
$url64      = 'https://gajim.org/downloads/1.8/Gajim-1.8.3-64bit.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url64

  softwareName  = 'gajim*'

  checksum64    = '80bc31f5ddef5b81900ed05ba35484da4583bcf59a5b12b9c77b7da0d067ce67'
  checksumType  = 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

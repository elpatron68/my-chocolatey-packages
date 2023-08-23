$ErrorActionPreference = 'Stop';
$url64      = 'https://gajim.org/downloads/1.8/Gajim-1.8.1-64bit.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url64

  softwareName  = 'gajim*'

  checksum64    = 'e60930c8aa325d5f3407a1884b9d140f8837ad7dd8bda825aabe7120d2330b50'
  checksumType  = 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

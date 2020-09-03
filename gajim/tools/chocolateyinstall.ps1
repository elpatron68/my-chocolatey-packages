$ErrorActionPreference = 'Stop';
$url        = 'https://gajim.org/downloads/1.2/Gajim-1.2.2-32bit-1.exe'
$url64      = 'https://gajim.org/downloads/1.2/Gajim-1.2.2-64bit-1.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  url64bit      = $url64

  softwareName  = 'gajim*'

  checksum      = 'b3c3421524563ae37c425333e4445ece46f30ba15d30e7cd90e4834ac2ad5397'
  checksumType  = 'sha256'
  checksum64    = '6ad30a1259b106fa0f0aeee04392f46bc1728bedbe77ef49ab0bd6462798801b'
  checksumType64= 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

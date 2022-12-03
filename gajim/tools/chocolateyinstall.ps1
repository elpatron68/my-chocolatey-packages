$ErrorActionPreference = 'Stop';
$url64      = 'https://gajim.org/downloads/1.5/Gajim-1.5.4-64bit.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url64

  softwareName  = 'gajim*'

  checksum64    = 'add28ce87cb400f09ed25b48b9d11e7bca0fe43b9c812c227f605605dfb0ead7'
  checksumType  = 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

$ErrorActionPreference = 'Stop';
$url        = 'https://gajim.org/downloads/1.1/gajim-1.1.2-32bits-1.exe'
$url64      = 'https://gajim.org/downloads/1.1/gajim-1.1.2-64bits-1.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  url64bit      = $url64

  softwareName  = 'gajim*'

  checksum      = 'C0A5883D5B06B427B5B8B63E5920B79C6332795F6E265B116A895E50B83F33E2'
  checksumType  = 'sha256'
  checksum64    = '4249474573E96F08C2B351326F410DCC8B55A8EEA81D791241A9A02D49C3D3A4'
  checksumType64= 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

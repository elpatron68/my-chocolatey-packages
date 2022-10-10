$ErrorActionPreference = 'Stop';
$url64      = 'https://gajim.org/downloads/1.5/Gajim-1.5.2-64bit.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url64

  softwareName  = 'gajim*'

  checksum64    = '9a89073bebd830872f359d7cb31866f06ba87027d045f151e4e830ebca9b2ffb'
  checksumType  = 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

$ErrorActionPreference = 'Stop';
$url        = 'https://gajim.org/downloads/1.3/Gajim-1.3.3-32bit-1.exe'
$url64      = 'https://gajim.org/downloads/1.3/Gajim-1.3.3-64bit-1.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  url64bit      = $url64

  softwareName  = 'gajim*'

  checksum      = '9A15F608DFC6A45710B222263E2E756CBD048E9F00A0B53D056A87348543F93A'
  checksumType  = 'sha256'
  checksum64    = '50A693C5EDFB62F624B63AD96E81133C734C4257854ACB132F24FA6BAC99BB89'
  checksumType64= 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

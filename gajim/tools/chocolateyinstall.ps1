$ErrorActionPreference = 'Stop';
$url        = 'https://gajim.org/downloads/1.3/Gajim-1.3.0-32bit-1.exe'
$url64      = 'https://gajim.org/downloads/1.3/Gajim-1.3.0-64bit-1.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  url64bit      = $url64

  softwareName  = 'gajim*'

  checksum      = '0B6A62020D7DFDF2D1A0F796643565FD8899CA1B494A72D04CF5D6840D572787'
  checksumType  = 'sha256'
  checksum64    = '186320636607BC18521FEF83EF08E7EDD41E1E5BD885D10099F1E715C4E8D5CB'
  checksumType64= 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

$ErrorActionPreference = 'Stop';
$url        = 'https://gajim.org/downloads/1.1/gajim-1.1.0-32bits-2.exe'
$url64      = 'https://gajim.org/downloads/1.1/gajim-1.1.0-64bits-2.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  url64bit      = $url64

  softwareName  = 'gajim*'

  checksum      = '62966084E9B90A46253DF5DA04A394E32C64C88EE57DFFBD47F7E9E7C8C3856E'
  checksumType  = 'sha256'
  checksum64    = 'F4A2EBEB93B401F65916267B9D1015971679DC0CD0729FA5A6E34BFA70F86076'
  checksumType64= 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

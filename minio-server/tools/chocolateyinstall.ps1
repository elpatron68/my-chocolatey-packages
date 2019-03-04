$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64      = 'https://dl.minio.io/server/minio/release/windows-amd64/minio.exe'
$url        = 'https://dl.minio.io/server/minio/release/windows-386/minio.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  url64bit      = $url64
  FileFullPath  = "$toolsDir\minio.exe"
  softwareName  = 'minio-server*'

  checksum      = '4AB74F1094DD315C316315C3C121CA03A10BCA1F9E76F0058651CBD831665B17'
  checksumType  = 'sha256'
  checksum64    = '84F4298D9B5ED097F06359A890291E597B9C02C8687F3EF19AEC5C5EC7AA0034'
  checksumType64= 'sha256'
}
Get-ChocolateyWebFile @packageArgs
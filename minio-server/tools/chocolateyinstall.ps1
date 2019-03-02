$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://dl.minio.io/server/minio/release/windows-amd64/minio.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  FileFullPath  = "$toolsDir\minio.exe"
  softwareName  = 'minio-server*'

  checksum      = '84F4298D9B5ED097F06359A890291E597B9C02C8687F3EF19AEC5C5EC7AA0034'
  checksumType  = 'sha256'

  
}
Get-ChocolateyWebFile @packageArgs
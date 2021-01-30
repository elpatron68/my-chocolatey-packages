$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64      = 'https://dl.min.io/client/mc/release/windows-amd64/mc.exe'

$packageArgs = @{
  packageName     = $env:ChocolateyPackageName
  unzipLocation   = $toolsDir
  fileType        = 'EXE'
  url64bit        = $url64
  FileFullPath    = "$toolsDir\mc.exe"
  softwareName    = 'minio-client*'

  checksum64    = '71e7b5e8829c8d37e55268df0c96c37cfc3462b6a606b4c9d4b8ecd5468ed507'
  checksumType64  = 'sha256'
}
Get-ChocolateyWebFile @packageArgs
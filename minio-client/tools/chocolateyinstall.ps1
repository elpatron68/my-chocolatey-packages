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

  checksum64    = '5a377f80b9f5770e98e7e9c2a803ef77bae00cac4e4cd3cca94f5be74c1a39e1'
  checksumType64  = 'sha256'
}
Get-ChocolateyWebFile @packageArgs
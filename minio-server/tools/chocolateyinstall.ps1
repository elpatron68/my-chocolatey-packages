$ErrorActionPreference = 'Stop';	
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"	
$url64      = 'https://dl.min.io/server/minio/release/windows-amd64/minio.exe'	

 $packageArgs = @{	
  packageName     = $env:ChocolateyPackageName	
  unzipLocation   = $toolsDir	
  fileType        = 'EXE'	
  url64bit        = $url64	
  FileFullPath    = "$toolsDir\minio.exe"	
  softwareName    = 'minio-server*'	

   checksum64    = '02d2879e964f7bfcb4ed4a972fb461772529a0781027bba0d3d36a5454d4f56b'	
  checksumType64  = 'sha256'	
}	
Get-ChocolateyWebFile @packageArgs 
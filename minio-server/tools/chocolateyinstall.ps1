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

   checksum64    = '23ef8b8c6a2d8ad1a53dbaa961ec240aa7fa53a38432db32d643cfbcdacd65b8'	
  checksumType64  = 'sha256'	
}	
Get-ChocolateyWebFile @packageArgs 
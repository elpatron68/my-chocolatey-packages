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

   checksum64    = '4aa24eb2577cc38650c81e647118811985f832eb10d0d9c0b1d23b4a72c90239'	
  checksumType64  = 'sha256'	
}	
Get-ChocolateyWebFile @packageArgs 
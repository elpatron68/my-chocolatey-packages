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

   checksum64    = '3175ed8247f011010cc54034dc390f5fff1b3521d7fde2f8be463d566c7803e3'	
  checksumType64  = 'sha256'	
}	
Get-ChocolateyWebFile @packageArgs 
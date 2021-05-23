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

  checksum64    = 'c78777c2ad3f4bfa9532e7ce0dcd79df61f867e85739ca98c38611808e5dc6de'	
  checksumType64  = 'sha256'	
}	
Get-ChocolateyWebFile @packageArgs 
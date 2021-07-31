$ErrorActionPreference = 'Stop';	
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"	
$url64      = 'https://dl.min.io/server/minio/release/windows-amd64/archive/minio.RELEASE.2021-07-30T00-02-00Z'	

$packageArgs = @{	
  packageName     = $env:ChocolateyPackageName	
  unzipLocation   = $toolsDir	
  fileType        = 'EXE'	
  url64bit        = $url64	
  FileFullPath    = "$toolsDir\minio.exe"	
  softwareName    = 'minio-server*'	

  checksum64    = '8b1dcf607d2b58376757fb0893480ca78447d857b0177399e804849c6a865397'	
  checksumType64  = 'sha256'	
}	
# Get-ChocolateyWebFile @packageArgs 
Install-ChocolateyZipPackage @packageArgs
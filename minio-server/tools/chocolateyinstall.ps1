$ErrorActionPreference = 'Stop';	
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"	
$url64      = 'https://dl.min.io/server/minio/release/windows-amd64/archive/minio.RELEASE.2021-09-09T21-37-07Z'	

$packageArgs = @{	
  packageName     = $env:ChocolateyPackageName	
  unzipLocation   = $toolsDir	
  fileType        = 'EXE'	
  url64bit        = $url64	
  FileFullPath    = "$toolsDir\minio.exe"	
  softwareName    = 'minio-server*'	

  checksum64    = '531026ea794d3c5aef35231e86381e91d93c4349ed178348ec46b6090dca08d2'	
  checksumType64  = 'sha256'	
}	
# Get-ChocolateyWebFile @packageArgs 
Install-ChocolateyZipPackage @packageArgs
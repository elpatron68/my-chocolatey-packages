$ErrorActionPreference = 'Stop';	
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"	
$url64      = 'https://dl.min.io/server/minio/release/windows-amd64/archive/minio.RELEASE.2021-11-05T09-16-26Z'	

$packageArgs = @{	
  packageName     = $env:ChocolateyPackageName	
  unzipLocation   = $toolsDir	
  fileType        = 'EXE'	
  url64bit        = $url64	
  FileFullPath    = "$toolsDir\minio.exe"	
  softwareName    = 'minio-server*'	

  checksum64    = '19fb987c06304c242a46a871e85451d215456ca15622aa8dba2e8d40d6ae1f9f'	
  checksumType64  = 'sha256'	
}	
# Get-ChocolateyWebFile @packageArgs 
Install-ChocolateyZipPackage @packageArgs
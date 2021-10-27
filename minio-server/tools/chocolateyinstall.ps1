$ErrorActionPreference = 'Stop';	
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"	
$url64      = 'https://dl.min.io/server/minio/release/windows-amd64/archive/minio.RELEASE.2021-10-23T03-28-24Z'	

$packageArgs = @{	
  packageName     = $env:ChocolateyPackageName	
  unzipLocation   = $toolsDir	
  fileType        = 'EXE'	
  url64bit        = $url64	
  FileFullPath    = "$toolsDir\minio.exe"	
  softwareName    = 'minio-server*'	

  checksum64    = 'b368b98bfdecac33f5a0e0d329fa32a901db4afe4f403201b70b8a0dc1fed809'	
  checksumType64  = 'sha256'	
}	
# Get-ChocolateyWebFile @packageArgs 
Install-ChocolateyZipPackage @packageArgs
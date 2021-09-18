$ErrorActionPreference = 'Stop';	
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"	
$url64      = 'https://dl.min.io/server/minio/release/windows-amd64/archive/minio.RELEASE.2021-09-15T04-54-25Z'	

$packageArgs = @{	
  packageName     = $env:ChocolateyPackageName	
  unzipLocation   = $toolsDir	
  fileType        = 'EXE'	
  url64bit        = $url64	
  FileFullPath    = "$toolsDir\minio.exe"	
  softwareName    = 'minio-server*'	

  checksum64    = '137fa2b0988374fb7e8504f9a8828ea747bea3727c13a27870558f54d3675897'	
  checksumType64  = 'sha256'	
}	
# Get-ChocolateyWebFile @packageArgs 
Install-ChocolateyZipPackage @packageArgs
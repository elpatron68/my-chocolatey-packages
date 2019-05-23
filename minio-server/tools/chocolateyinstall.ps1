$ErrorActionPreference = 'Stop';	
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"	
$url64      = 'https://dl.minio.io/server/minio/release/windows-amd64/minio.exe'	

 $packageArgs = @{	
  packageName     = $env:ChocolateyPackageName	
  unzipLocation   = $toolsDir	
  fileType        = 'EXE'	
  url64bit        = $url64	
  FileFullPath    = "$toolsDir\minio.exe"	
  softwareName    = 'minio-server*'	

   checksum64      = 'E06A2483C51E1FAFF9F8E547E3C7EB289B679DC31892612D4B71BE4D12EB16EF'	
  checksumType64  = 'sha256'	
}	
Get-ChocolateyWebFile @packageArgs 
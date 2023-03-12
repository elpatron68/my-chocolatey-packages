$ErrorActionPreference = 'Stop';
$url64      = 'https://gajim.org/downloads/1.7/Gajim-1.7.2-64bit.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url64

  softwareName  = 'gajim*'

  checksum64    = 'c7c1e87f74a0a769fed8b305ce43f926bd68e02e80f40976698366baa045b0cf'
  checksumType  = 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

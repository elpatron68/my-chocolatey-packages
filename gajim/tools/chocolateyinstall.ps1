$ErrorActionPreference = 'Stop';
$url64      = 'https://gajim.org/downloads/1.8/Gajim-1.8.2-64bit.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url64

  softwareName  = 'gajim*'

  checksum64    = '9e4271255ed3b19f0bb931dae999eb661ca37e5489711c0397b3e0a750c37562'
  checksumType  = 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

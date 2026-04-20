$ErrorActionPreference = 'Stop';
$url        = 'https://gajim.org/downloads/2.4/Gajim-2.4.6-64bit.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'gajim*'

  checksum      = '065f6e6fa6d8edfdaf5148acb1c6768fb6e7e8064147e0b54d4b74c24435139c'
  checksumType  = 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

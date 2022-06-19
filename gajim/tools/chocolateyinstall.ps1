$ErrorActionPreference = 'Stop';
$url64      = 'https://gajim.org/downloads/1.4/Gajim-1.4.4-64bit.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url64

  softwareName  = 'gajim*'

  checksum64    = '077c47cb9e373970f1c9ab5580193a8ec86e9c397672263c817503eaf2486474'
  checksumType  = 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

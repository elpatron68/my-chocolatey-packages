$ErrorActionPreference = 'Stop';
$url        = 'https://gajim.org/downloads/2.6/Gajim-2.6.0-64bit.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'gajim*'

  checksum      = 'ac99c3e04a1282cc47346b75bcc597062a2d4ab4e246d32b52290a7821b4251c'
  checksumType  = 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

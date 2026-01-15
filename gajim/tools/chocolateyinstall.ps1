$ErrorActionPreference = 'Stop';
$url        = 'https://gajim.org/downloads/2.4/Gajim-2.4.2-64bit.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'gajim*'

  checksum      = 'f947f27d79f7a4dc649989169a90b0bc669d32bfede94d6b43afa4ddbfed94a4'
  checksumType  = 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

$ErrorActionPreference = 'Stop';
$url        = 'https://gajim.org/downloads/2.4/Gajim-2.4.4-64bit.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'gajim*'

  checksum      = '7e8c1c1fea7042b5fe18356791b00dd4d16794081e8da6887993116d470b6547'
  checksumType  = 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

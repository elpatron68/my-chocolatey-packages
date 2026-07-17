$ErrorActionPreference = 'Stop';
$url        = 'https://gajim.org/downloads/2.5/Gajim-2.5.0-64bit.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'gajim*'

  checksum      = '03d4fa00db1ba66b4ac28075d218bfc27df4a600ed473bedebef15e4cc7b3902'
  checksumType  = 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

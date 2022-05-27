$ErrorActionPreference = 'Stop';
$url64 = 'https://gajim.org/downloads/1.4/Gajim-1.4.2-64bit.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url64

  softwareName  = 'gajim*'

  checksum64    = 'F68DDC70E2E9F5CD4BE9B4D953E1D20CF4489312C11C49B81601A1C91EF85BF8'
  checksumType  = 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

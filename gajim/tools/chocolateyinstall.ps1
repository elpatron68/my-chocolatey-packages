$ErrorActionPreference = 'Stop';
$url        = 'https://gajim.org/downloads/1.2/gajim-1.2.1-32bits-1.exe'
$url64      = 'https://gajim.org/downloads/1.2/Gajim-1.2.1-64bit-1.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  url64bit      = $url64

  softwareName  = 'gajim*'

  checksum      = '52EBC3F12F6375FF855A766004E098606F6A1856E1EBD5C5E82291655713088D'
  checksumType  = 'sha256'
  checksum64    = '93E973E06E9C79E216BABAC820C8D6B7B70009573E8A05ED88EF5E7A7A9DC4FF'
  checksumType64= 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

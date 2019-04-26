$ErrorActionPreference = 'Stop';
$url        = 'https://gajim.org/downloads/1.1/gajim-1.1.3-32bits-1.exe'
$url64      = 'https://gajim.org/downloads/1.1/gajim-1.1.3-64bits-1.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  url64bit      = $url64

  softwareName  = 'gajim*'

  checksum      = '934FE01FC3391A699C12ACA09872176A371236F07FFD0D39C62AC7D247546C39'
  checksumType  = 'sha256'
  checksum64    = '1921A5EC774BC4EE5F20752E39FA1E00E1A87E7233C3CFEFC07B9C497C3E34E6'
  checksumType64= 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

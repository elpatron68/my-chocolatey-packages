$ErrorActionPreference = 'Stop';
$url        = 'https://gajim.org/downloads/2.4/Gajim-2.4.0-64bit.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'gajim*'

  checksum      = '86b9dc15ef1c147899cd6f3dc1df300b8c874aeaea536ca4cc8d7126776a7b83'
  checksumType  = 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

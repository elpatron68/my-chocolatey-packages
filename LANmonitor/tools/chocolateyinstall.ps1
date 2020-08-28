$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://www.lancom-systems.de/fileadmin/download/LANtools/LANmonitor-10.40.0020-RU2.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'LANmonitor*'

  checksum      = '8a42ddafcc424917f4bac1528f94cee9fdf55186a3964040be4d47f990d71309'
  checksumType  = 'sha256'

  silentArgs    = "/params:/silent"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

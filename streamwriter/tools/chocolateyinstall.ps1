$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://streamwriter.org/en/downloads/2/'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'streamwriter*'

  checksum      = 'FF0A282548F8CE317007EE77A6A7A9C05EE5F8C4F3DDD73DFF851B2CAB29A190'
  checksumType  = 'sha256'

  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

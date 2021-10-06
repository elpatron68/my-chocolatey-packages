$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://streamwriter.org/en/downloads/2/'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'streamwriter*'

  checksum      = 'e2618fd080bf37ac41e57c6be6a07d8ee615a45682768442c8b27c92ebeda1d3'
  checksumType  = 'sha256'

  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

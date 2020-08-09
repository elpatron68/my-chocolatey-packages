$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://streamwriter.org/en/downloads/2/'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'streamwriter*'

  checksum      = '0856e85b246dbbd7cbed70c362a30bf52b2817706b826c111c87ea55cc4489e9'
  checksumType  = 'sha256'

  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

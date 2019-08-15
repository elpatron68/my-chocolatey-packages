$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://streamwriter.org/en/downloads/2/'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'streamwriter*'

  checksum      = 'ba9dcc9974f4071cdee83092dde23dbe8fb0eb56967fa3e2c19e7cea832224c4'
  checksumType  = 'sha256'

  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

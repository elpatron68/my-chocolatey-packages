$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://download.yajhfc.de/releases/yajhfc-0_6_2-setup.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'YajHFC*'

  checksum      = '0636784A1CFAE7FE78565DF8A4A8D5463FE19004A82ABF75B35FE6E6C7B19DF1'
  checksumType  = 'sha256'

  silentArgs    = "/VERYSILENT /NORESTART"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

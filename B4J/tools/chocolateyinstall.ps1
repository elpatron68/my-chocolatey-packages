
$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://www.b4x.com/b4j/files/B4J.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE_MSI_OR_MSU'
  url           = $url

  softwareName  = 'B4J*'

  checksum      = '668AAE80A25C1F1F18BC8E0A1414D790E96F4E597621A4CDC25B5E70833F06C7'
  checksumType  = 'sha256'
  
  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

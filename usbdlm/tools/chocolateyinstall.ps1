
$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://www.uwe-sieber.de/files/usbdlm.msi'
$url64      = 'https://www.uwe-sieber.de/files/usbdlm_x64.msi'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'MSI'
  url           = $url
  url64bit      = $url64

  softwareName  = 'usbdlm*'

  checksum      = 'a13769377fc363f2feeb2afb6a8107753981445c25f0fa8d6a99e56e2c54a2ee'
  checksumType  = 'sha256'
  checksum64    = '5d15433273a95586c446871df26e18e959283252e1a17df29e905fa8db4b9e8f'
  checksumType64= 'sha256'

  silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes= @(0,3010)
}

Install-ChocolateyPackage @packageArgs

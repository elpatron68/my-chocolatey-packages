
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

  checksum      = 'D0A1C93AF9325FE9AFDE1EB47C5602D9A33A040EB32BC242F197278A807A4BAF'
  checksumType  = 'sha256'
  checksum64    = '9E5F2CF322A451F634E711B6662EA852465EADE274B01CA40865D620454C1A11'
  checksumType64= 'sha256'

  silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes= @(0,3010)
}

Install-ChocolateyPackage @packageArgs

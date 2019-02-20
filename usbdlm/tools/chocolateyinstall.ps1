
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

  checksum      = '486C9023B40DD46F99B1764947E6973DB8F125A8A91EE62DC1E99FAC7A4D37B0'
  checksumType  = 'sha256'
  checksum64    = 'D37DE00F2FDED9985A4ACD881B72F9F7AEB578C08526693EDDF97B18CF0BE9A6'
  checksumType64= 'sha256'

  silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes= @(0,3010)
}

Install-ChocolateyPackage @packageArgs

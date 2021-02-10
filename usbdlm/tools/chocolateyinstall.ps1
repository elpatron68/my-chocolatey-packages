
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

  checksum      = 'f4a26ccea65f5577818ed5be60a7ac297092fa0f6dce396619bb0d706d18c76f'
  checksumType  = 'sha256'
  checksum64    = 'da9425bfa50bb124623bf1eaac146f9ffa1fc888dd71fc6c491f8cb4769ea9e6'
  checksumType64= 'sha256'

  silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes= @(0,3010)
}

Install-ChocolateyPackage @packageArgs

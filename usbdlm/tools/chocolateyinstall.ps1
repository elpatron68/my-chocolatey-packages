
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

  checksum      = '2af65646ef5b4cb99652cac9dde056b50861c39b4830d52defd30ceecbfdfbb4'
  checksumType  = 'sha256'
  checksum64    = '63108a45765b30e277f45cf074ec88635d992bb6ebadc5fb227338c5f767f976'
  checksumType64= 'sha256'

  silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes= @(0,3010)
}

Install-ChocolateyPackage @packageArgs

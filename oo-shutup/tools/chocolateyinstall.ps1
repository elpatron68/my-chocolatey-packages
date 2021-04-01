
$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://dl5.oo-software.com/files/ooshutup10/OOSU10.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  FileFullPath    = "$toolsDir\OOSU10.exe"	
  softwareName  = 'oo-shutup*'

  checksum      = 'd37c4fe1e09b05ae4f47c2167afaa0bc11f6468b1e23e3b2a6743ed4814edb37'
  checksumType  = 'sha256'
}

Get-ChocolateyWebFile @packageArgs 

$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://www.lancom-systems.de/fileadmin/download/LANtools/LANconfig-10.20.0047-Rel.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  
  softwareName  = 'LANconfig*'

  checksum      = '476FDF718F412FB99873A82D9E4DE8CD7F960F393B18F6FB435E8EEDEAB4A3F3'
  checksumType  = 'sha256'
  
  silentArgs    = "/params:/silent"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

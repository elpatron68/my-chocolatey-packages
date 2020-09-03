$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://www.udse.de/download/RebootBlockerSetup.zip'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'rebootblocker*'

  checksum      = '007FCDFC49FBCED0C131DC0284B9EB0A2B091D6A1F849D5C586511F89A6AF1C4'
  checksumType  = 'sha256'
  
  silentArgs    = "/silent /norestart"
  validExitCodes= @(0)
}

Install-ChocolateyZipPackage @packageArgs

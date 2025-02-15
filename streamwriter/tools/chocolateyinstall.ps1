$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://streamwriter.org/en/downloads/streamwriter_setup-x86_64.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'streamwriter*'

  checksum      = 'BE0A5A6636BB52DAD4D3685BE47EF919C8F667582ABCBD7421332FFDF345ED31'
  checksumType  = 'sha256'

  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

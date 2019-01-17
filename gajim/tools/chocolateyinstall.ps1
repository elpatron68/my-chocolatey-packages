$ErrorActionPreference = 'Stop';
$url        = 'https://gajim.org/downloads/1.1/gajim-1.1.1-32bits-1.exe'
$url64      = 'https://gajim.org/downloads/1.1/gajim-1.1.1-64bits-1.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  url64bit      = $url64

  softwareName  = 'gajim*'

  checksum      = '2ECA5A9F2A1F36E4CB46368C1080FC14A49D6DBD3874E17FB834CF0C2438F39F'
  checksumType  = 'sha256'
  checksum64    = '84B7A247D3951DED9F4F00E9F9BA9C016555D15BE13022589557649E995BFEA8'
  checksumType64= 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

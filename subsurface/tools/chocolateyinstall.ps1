$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/subsurface/nightly-builds/releases/download/v6.0.5112-CICD-release/subsurface-6.0.5112-CICD-release-installer.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url

  softwareName  = 'subsurface*'

  checksum      = 'a362c5f820860e4aadd1bd69095eeb758aa3dc33b68f860cdc72d43024ab354e'
  checksumType  = 'sha256'

  silentArgs    = '/S'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

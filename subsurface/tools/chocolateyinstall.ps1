$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/subsurface/nightly-builds/releases/download/v6.0.5038-CICD-release/subsurface-6.0.5038-CICD-release-installer.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url

  softwareName  = 'subsurface*'

  checksum      = 'B2B692BD3EA4948F87425CF824F6CD9C27E1D4738D68D07E483C2F72F0CF86B7'
  checksumType  = 'sha256'

  silentArgs    = '/S'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/subsurface/nightly-builds/releases/download/v6.0.5053-CICD-release/subsurface-6.0.5053-CICD-release-installer.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url

  softwareName  = 'subsurface*'

  checksum      = '2d163dc9fb2dc59f4e87bd04102279f62ebfa31d8917fcfdabfc02821d5bd47d'
  checksumType  = 'sha256'

  silentArgs    = '/S'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

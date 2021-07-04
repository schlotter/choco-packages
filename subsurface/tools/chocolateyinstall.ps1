
$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://subsurface-divelog.org/downloads/subsurface-5.0.2.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url

  softwareName  = 'subsurface*'

  checksum      = 'A6F6122998402CAE0FD7167D4E4A9510C7EB5218C2015412D0E44E2FA53D6D96'
  checksumType  = 'sha256'

  silentArgs    = '/S'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs










    









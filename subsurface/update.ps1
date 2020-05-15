import-module au

$releases    = 'https://subsurface-divelog.org/downloads/'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^[$]url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*fileType\s*=\s*)('.*')"     = "`$1'$($Latest.FileType)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
        }
    }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge }

function global:au_GetLatest {
    $releasesPage = Invoke-WebRequest -Uri $releases

    $re  = "subsurface-.*\.exe"
    $url = $releasesPage.Links | Where-Object href -Match $re | Select-Object -Last 1 -ExpandProperty href
    $url = $releases + $url

    $version = $url -Split '-|.exe' | Select-Object -Last 1 -Skip 1

    return @{
        URL32        = $url
        Version      = $version
    }
}

Update-Package -NoReadme -ChecksumFor all

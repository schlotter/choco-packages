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

    $versionre = "(\d+\.){2}\d+"
    $re  = "subsurface-$versionre-CICD-release-installer\.exe"
    $url = $releasesPage.Links | Where-Object href -Match $re | Sort-Object { [Version]([regex]::Match($_.href, $versionre).Value) } | Select-Object -Last 1 -ExpandProperty href
    $url = $releases + $url

    $version = $url -Split '-|.exe' | Select-Object -Last 1 -Skip 4

    return @{
        URL32        = $url
        Version      = $version
    }
}

Update-Package -NoReadme -ChecksumFor all

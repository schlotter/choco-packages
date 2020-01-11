import-module au

$releases    = 'https://subsurface-divelog.org/downloads/'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*[$]packageName\s*=\s*)('.*')"= "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*[$]fileType\s*=\s*)('.*')"   = "`$1'$($Latest.FileType)'"
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

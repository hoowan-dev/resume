# Runs src/make_cv.py once per job posting link. A failed link doesn't stop the rest.
#   .\scripts\make_cv.ps1 "<url>"
#   .\scripts\make_cv.ps1 "<url1>", "<url2>"
param(
    [Parameter(Mandatory)]
    [string[]]$Links
)

$makeCv = Join-Path $PSScriptRoot "..\src\make_cv.py"
$failed = @()

foreach ($link in $Links) {
    Write-Host "`n$link"
    python $makeCv $link
    if ($LASTEXITCODE -ne 0) {
        $failed += $link
    }
}

if ($failed) {
    Write-Host "`nFailed:"
    $failed | ForEach-Object { Write-Host "  $_" }
    exit 1
}

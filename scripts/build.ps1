# Compiles a .tex file to <OutDir>\<name>.pdf with Tectonic.
#   .\scripts\build.ps1 resume.tex out
#   .\scripts\build.ps1 targets\src\res\11_3_26_res_1.tex targets\out\res
param(
    [Parameter(Mandatory)]
    [string]$TexFile,

    [Parameter(Mandatory)]
    [string]$OutDir,

    # Also write the build log to OutDir.
    [switch]$KeepLogs
)

$tectonic = (Get-Command tectonic -ErrorAction SilentlyContinue).Source
if (-not $tectonic) {
    $tectonic = Join-Path $HOME ".local\bin\tectonic.exe"
}
if (-not (Test-Path $tectonic)) {
    [Console]::Error.WriteLine("Tectonic is not on PATH or in ~/.local/bin.")
    exit 1
}

New-Item -ItemType Directory -Force -Path $OutDir -ErrorAction Stop | Out-Null

$tectonicArgs = @("--untrusted", "-o", $OutDir, $TexFile)
if ($KeepLogs) {
    $tectonicArgs = @("--keep-logs") + $tectonicArgs
}
& $tectonic @tectonicArgs
exit $LASTEXITCODE

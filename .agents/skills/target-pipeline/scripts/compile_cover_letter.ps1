[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$Target,

    [Parameter()]
    [string]$TexFile = ""
)

$ErrorActionPreference = "Stop"

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..\..\..")).Path
$cleanName = [System.IO.Path]::GetFileNameWithoutExtension($Target)
$clOutDir = Join-Path $repoRoot "targets\out\cl"

if (-not (Test-Path $clOutDir)) {
    New-Item -ItemType Directory -Path $clOutDir -Force | Out-Null
}

# Find tectonic binary
$tectonicCmd = Get-Command tectonic -ErrorAction SilentlyContinue
if ($tectonicCmd) {
    $tectonic = $tectonicCmd.Source
}
else {
    $localTectonic = Join-Path $HOME ".local\bin\tectonic.exe"
    if (Test-Path $localTectonic) {
        $tectonic = $localTectonic
    }
}

if (-not $tectonic) {
    Write-Error "Tectonic could not be found. Please ensure it is on PATH or installed at ~/.local/bin/tectonic.exe"
    exit 1
}

if ([string]::IsNullOrWhiteSpace($TexFile)) {
    $TexFile = Join-Path $clOutDir "$cleanName.tex"
}

if (-not (Test-Path $TexFile)) {
    Write-Error "Cover letter TeX file not found: $TexFile"
    exit 1
}

Write-Host "Compiling cover letter $TexFile with Tectonic..." -ForegroundColor Cyan
& $tectonic -o $clOutDir $TexFile

if ($LASTEXITCODE -ne 0) {
    Write-Error "Cover letter compilation failed with exit code $LASTEXITCODE"
    exit $LASTEXITCODE
}

# Remove intermediate .tex if it was staged in out/cl so out/cl stays clean with .md and .pdf
$stagedTex = Join-Path $clOutDir "$cleanName.tex"
if (Test-Path $stagedTex) {
    Remove-Item -LiteralPath $stagedTex -Force
}

$outPdf = Join-Path $clOutDir "$cleanName.pdf"
Write-Host "Successfully generated cover letter PDF: $outPdf" -ForegroundColor Green


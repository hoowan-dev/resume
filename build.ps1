[CmdletBinding()]
param(
    [Parameter(Position = 0)]
    [string]$OutputName = "resume.pdf"
)

$ErrorActionPreference = "Stop"

# Determine script directory
$scriptDir = $PSScriptRoot
if (-not $scriptDir) {
    $scriptDir = (Get-Location).Path
}

# Resolve target output filename
if ([string]::IsNullOrWhiteSpace($OutputName)) {
    $OutputName = "resume.pdf"
}
elseif (-not $OutputName.EndsWith(".pdf", [System.StringComparison]::OrdinalIgnoreCase)) {
    $OutputName = "$OutputName.pdf"
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

$texFile = Join-Path $scriptDir "resume.tex"
$outDir = Join-Path $scriptDir "out"

if (-not (Test-Path $outDir)) {
    New-Item -ItemType Directory -Path $outDir -Force | Out-Null
}

Write-Host "Compiling $texFile with Tectonic..." -ForegroundColor Cyan
& $tectonic -o $outDir $texFile

if ($LASTEXITCODE -ne 0) {
    Write-Error "Compilation failed with exit code $LASTEXITCODE"
    exit $LASTEXITCODE
}

$defaultOut = Join-Path $outDir "resume.pdf"
$targetOut = Join-Path $outDir $OutputName

if ($OutputName -ne "resume.pdf" -and (Test-Path $defaultOut)) {
    Move-Item -LiteralPath $defaultOut -Destination $targetOut -Force
}

Write-Host "Successfully generated: $targetOut" -ForegroundColor Green


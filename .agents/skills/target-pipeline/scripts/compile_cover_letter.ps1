[CmdletBinding()]
param(
    [Parameter(Mandatory = $false)]
    [string]$Target = "",

    [Parameter()]
    [switch]$AllTargets,

    [Parameter()]
    [string]$TexFile = ""
)

$ErrorActionPreference = "Stop"

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..\..\..")).Path
$clSrcDir = Join-Path $repoRoot "targets\src\cl"
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

function Build-CoverLetterTex {
    param(
        [string]$TargetName,
        [string]$CustomTexFile = ""
    )
    $cleanName = [System.IO.Path]::GetFileNameWithoutExtension($TargetName)
    $resolvedTex = if (-not [string]::IsNullOrWhiteSpace($CustomTexFile)) {
        $CustomTexFile
    }
    else {
        Join-Path $clSrcDir "$cleanName.tex"
    }

    if (-not (Test-Path $resolvedTex)) {
        Write-Error "Cover letter TeX file not found: $resolvedTex"
        exit 1
    }

    Write-Host "Compiling cover letter $resolvedTex with Tectonic..." -ForegroundColor Cyan
    & $tectonic -o $clOutDir $resolvedTex

    if ($LASTEXITCODE -ne 0) {
        Write-Error "Cover letter compilation failed with exit code $LASTEXITCODE"
        exit $LASTEXITCODE
    }

    $outPdf = Join-Path $clOutDir "$cleanName.pdf"
    Write-Host "Successfully generated cover letter PDF: $outPdf" -ForegroundColor Green
}

if ($AllTargets) {
    $texFiles = Get-ChildItem -Path $clSrcDir -Filter "*.tex"
    foreach ($file in $texFiles) {
        Build-CoverLetterTex -TargetName $file.BaseName
    }
    exit 0
}

if ([string]::IsNullOrWhiteSpace($Target)) {
    Write-Error "Please provide -Target <id> or -AllTargets"
    exit 1
}

Build-CoverLetterTex -TargetName $Target -CustomTexFile $TexFile

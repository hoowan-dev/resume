[CmdletBinding()]
param(
    [Parameter(Position = 0)]
    [string]$OutputName = "resume.pdf",

    [Parameter()]
    [string]$Target = "",

    [Parameter()]
    [switch]$AllTargets
)

$ErrorActionPreference = "Stop"

# Determine script directory
$scriptDir = $PSScriptRoot
if (-not $scriptDir) {
    $scriptDir = (Get-Location).Path
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

$targetsTexDir = Join-Path $scriptDir "targets\src\res"
$targetsResDir = Join-Path $scriptDir "targets\out\res"

function Build-TargetTex {
    param(
        [string]$TargetName
    )
    $cleanName = [System.IO.Path]::GetFileNameWithoutExtension($TargetName)
    $texPath = Join-Path $targetsTexDir "$cleanName.tex"
    if (-not (Test-Path $texPath)) {
        Write-Error "Target TeX file not found: $texPath"
        exit 1
    }
    if (-not (Test-Path $targetsResDir)) {
        New-Item -ItemType Directory -Path $targetsResDir -Force | Out-Null
    }

    Write-Host "Compiling target $texPath with Tectonic..." -ForegroundColor Cyan
    & $tectonic -o $targetsResDir $texPath

    if ($LASTEXITCODE -ne 0) {
        Write-Error "Compilation failed for $texPath with exit code $LASTEXITCODE"
        exit $LASTEXITCODE
    }

    $generatedPdf = Join-Path $targetsResDir "$cleanName.pdf"
    Write-Host "Successfully generated target resume: $generatedPdf" -ForegroundColor Green
}

# 1. Build all targets if -AllTargets is set
if ($AllTargets) {
    if (-not (Test-Path $targetsTexDir)) {
        Write-Warning "No targets/src/res directory found."
        exit 0
    }
    $texFiles = Get-ChildItem -Path $targetsTexDir -Filter "*.tex"
    if ($texFiles.Count -eq 0) {
        Write-Warning "No .tex files found in $targetsTexDir"
        exit 0
    }
    foreach ($file in $texFiles) {
        Build-TargetTex -TargetName $file.BaseName
    }
    exit 0
}

# 2. Build specific target if -Target is provided, or if positional arg matches a file in targets/src/res
if (-not [string]::IsNullOrWhiteSpace($Target)) {
    Build-TargetTex -TargetName $Target
    exit 0
}

$candidateTargetName = [System.IO.Path]::GetFileNameWithoutExtension($OutputName)
$candidateTargetTex = Join-Path $targetsTexDir "$candidateTargetName.tex"
if ($OutputName -ne "resume.pdf" -and (Test-Path $candidateTargetTex)) {
    Build-TargetTex -TargetName $candidateTargetName
    exit 0
}

# 3. Default behavior: compile root resume.tex -> out/<OutputName>.pdf
if ([string]::IsNullOrWhiteSpace($OutputName)) {
    $OutputName = "resume.pdf"
}
elseif (-not $OutputName.EndsWith(".pdf", [System.StringComparison]::OrdinalIgnoreCase)) {
    $OutputName = "$OutputName.pdf"
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

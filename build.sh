#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT_NAME="${1:-resume.pdf}"

# Ensure .pdf extension
if [[ ! "$OUTPUT_NAME" =~ \.[pP][dD][fF]$ ]]; then
    OUTPUT_NAME="${OUTPUT_NAME}.pdf"
fi

# Locate tectonic
TECTONIC_BIN=""
if command -v tectonic >/dev/null 2>&1; then
    TECTONIC_BIN="tectonic"
elif [ -f "$HOME/.local/bin/tectonic.exe" ]; then
    TECTONIC_BIN="$HOME/.local/bin/tectonic.exe"
elif [ -f "$HOME/.local/bin/tectonic" ]; then
    TECTONIC_BIN="$HOME/.local/bin/tectonic"
else
    echo "Error: Tectonic could not be found on PATH or in ~/.local/bin" >&2
    exit 1
fi

TEX_FILE="$SCRIPT_DIR/resume.tex"
OUT_DIR="$SCRIPT_DIR/out"

mkdir -p "$OUT_DIR"

echo "Compiling $TEX_FILE with Tectonic..."
"$TECTONIC_BIN" -o "$OUT_DIR" "$TEX_FILE"

DEFAULT_OUT="$OUT_DIR/resume.pdf"
TARGET_OUT="$OUT_DIR/$OUTPUT_NAME"

if [ "$OUTPUT_NAME" != "resume.pdf" ] && [ -f "$DEFAULT_OUT" ]; then
    mv -f "$DEFAULT_OUT" "$TARGET_OUT"
fi

echo "Successfully generated: $TARGET_OUT"


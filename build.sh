#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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

TARGETS_TEX_DIR="$SCRIPT_DIR/targets/src/res"
TARGETS_RES_DIR="$SCRIPT_DIR/targets/out/res"

resolve_target_res_name() {
    local name="$1"
    name="${name%.tex}"
    name="${name%.pdf}"
    name="${name%.md}"
    if [ -f "$TARGETS_TEX_DIR/${name}.tex" ]; then
        echo "$name"
        return
    fi
    if [[ "$name" =~ ^(.+)_(ctx|cl|res)_([0-9]+)$ ]]; then
        echo "${BASH_REMATCH[1]}_res_${BASH_REMATCH[3]}"
        return
    fi
    if [[ "$name" =~ ^(.+)_([0-9]+)$ ]]; then
        echo "${BASH_REMATCH[1]}_res_${BASH_REMATCH[2]}"
        return
    fi
    echo "$name"
}

build_target_tex() {
    local target_name
    target_name="$(resolve_target_res_name "$1")"
    local tex_path="$TARGETS_TEX_DIR/${target_name}.tex"

    if [ ! -f "$tex_path" ]; then
        echo "Error: Target TeX file not found: $tex_path" >&2
        exit 1
    fi

    mkdir -p "$TARGETS_RES_DIR"
    echo "Compiling target $tex_path with Tectonic..."
    "$TECTONIC_BIN" -o "$TARGETS_RES_DIR" "$tex_path"
    echo "Successfully generated target resume: $TARGETS_RES_DIR/${target_name}.pdf"
}

if [ "$1" = "--all-targets" ] || [ "$1" = "-AllTargets" ]; then
    shopt -s nullglob
    for tex_file in "$TARGETS_TEX_DIR"/*.tex; do
        base_name="$(basename "$tex_file" .tex)"
        build_target_tex "$base_name"
    done
    exit 0
fi

if [ "$1" = "--target" ] || [ "$1" = "-Target" ] || [ "$1" = "-t" ]; then
    if [ -z "$2" ]; then
        echo "Error: Missing target name after $1" >&2
        exit 1
    fi
    build_target_tex "$2"
    exit 0
fi

OUTPUT_NAME="${1:-resume.pdf}"
CANDIDATE_NAME="$(resolve_target_res_name "$OUTPUT_NAME")"

if [ "$OUTPUT_NAME" != "resume.pdf" ] && [ -f "$TARGETS_TEX_DIR/${CANDIDATE_NAME}.tex" ]; then
    build_target_tex "$CANDIDATE_NAME"
    exit 0
fi

# Ensure .pdf extension
if [[ ! "$OUTPUT_NAME" =~ \.[pP][dD][fF]$ ]]; then
    OUTPUT_NAME="${OUTPUT_NAME}.pdf"
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

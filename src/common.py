"""Repository paths and the error type shared by the pipeline modules."""

from __future__ import annotations

from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
POS_DIR = ROOT / "targets" / "ctx" / "pos"
SRC_DIR = ROOT / "targets" / "src"
OUT_DIR = ROOT / "targets" / "out"
SKILL = ROOT / ".agents" / "skills" / "target-pipeline" / "SKILL.md"
BUILD_SCRIPT = ROOT / "scripts" / "build.ps1"


class PipelineError(Exception):
    """A failure with a message the user can act on."""

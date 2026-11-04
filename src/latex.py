"""Compiles LaTeX through scripts/build.ps1 and reports the page count."""

from __future__ import annotations

import re
import shutil
import subprocess
import tempfile
from pathlib import Path

from common import BUILD_SCRIPT, PipelineError


def compile_tex(tex_path: Path, out_dir: Path) -> tuple[str | None, int]:
    """Compile tex_path into out_dir. Returns (compile error or None, page count)."""
    with tempfile.TemporaryDirectory() as build_dir:
        result = subprocess.run(
            ["powershell", "-NoProfile", "-ExecutionPolicy", "Bypass", "-File", str(BUILD_SCRIPT),
             str(tex_path), build_dir, "-KeepLogs"],
            capture_output=True, encoding="utf-8", errors="replace",
        )
        if result.returncode != 0:
            return (result.stdout + result.stderr).strip()[-3000:], 0
        log = (Path(build_dir) / f"{tex_path.stem}.log").read_text(encoding="utf-8", errors="replace")
        pages = re.search(r"Output written on .*?\((\d+) pages?", log)
        if not pages:
            raise PipelineError(f"Could not find the page count in the build log for {tex_path.name}.")
        out_dir.mkdir(parents=True, exist_ok=True)
        shutil.copy2(Path(build_dir) / f"{tex_path.stem}.pdf", out_dir / f"{tex_path.stem}.pdf")
    return None, int(pages.group(1))

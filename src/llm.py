"""Calls Claude through the logged-in CLI, with every tool disabled."""

from __future__ import annotations

import shutil
import subprocess
import tempfile

from common import PipelineError

MODEL = "claude-opus-5-5"
LLM_TIMEOUT_S = 600


def ask_claude(system: str, prompt: str, model: str) -> str:
    """Run one stateless, tool-less completion through the logged-in Claude CLI."""
    claude = shutil.which("claude")
    if not claude:
        raise PipelineError("The `claude` CLI is not on PATH.")
    command = [
        claude, "-p", "--model", model, "--effort", "high", "--system-prompt", system,
        "--tools", "", "--strict-mcp-config", "--disable-slash-commands",
        "--no-session-persistence", "--output-format", "text",
    ]
    with tempfile.TemporaryDirectory() as empty_dir:  # Keeps project config out of the session.
        try:
            result = subprocess.run(
                command, input=prompt, capture_output=True, encoding="utf-8",
                errors="replace", timeout=LLM_TIMEOUT_S, cwd=empty_dir,
            )
        except subprocess.TimeoutExpired:
            raise PipelineError(f"Claude did not answer within {LLM_TIMEOUT_S}s.") from None
    if result.returncode != 0:
        detail = (result.stderr or result.stdout).strip()
        raise PipelineError(f"Claude CLI failed (exit {result.returncode}): {detail}")
    return result.stdout.strip()

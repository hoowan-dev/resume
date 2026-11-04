"""Picks target numbers under targets/ using the <MM_DD_YY>_<X>_<Y> naming convention."""

from __future__ import annotations

from common import POS_DIR, SRC_DIR


def next_target(today: str) -> int:
    """Return the next unused target number for today across postings and generated sources."""
    used = [0]
    for directory, kind in ((POS_DIR, "ctx"), (SRC_DIR / "res", "res"), (SRC_DIR / "cl", "cl")):
        for path in directory.glob(f"{today}_{kind}_*"):
            suffix = path.stem.rsplit("_", 1)[-1]
            if suffix.isdigit():
                used.append(int(suffix))
    return max(used) + 1

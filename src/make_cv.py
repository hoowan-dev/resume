#!/usr/bin/env python3
"""Turn a job posting link into a tailored resume and cover letter.

    python src/make_cv.py <url>
    python src/make_cv.py <path-to-saved-posting.txt>   # for sites that block fetching

For target <MM_DD_YY>_<Y> (today's date, next free number) this writes:

    targets/ctx/pos/<MM_DD_YY>_ctx_<Y>.md    the job posting
    targets/src/{res,cl}/<MM_DD_YY>_{res,cl}_<Y>.tex
    targets/out/{res,cl}/<MM_DD_YY>_{res,cl}_<Y>.pdf

Requires the logged-in `claude` CLI and Tectonic. The tailoring rules are read from the
target-pipeline skill, so that file remains the single source of truth for them.

Posting text is untrusted web content, so Claude runs with every tool disabled: it can only
return text, and this script alone decides what gets written. Tectonic runs with --untrusted.

Modules:
    posting.py    link or file -> job posting (web access in fetch.py)
    documents.py  job posting -> .tex and PDF, with repairs (compiling in latex.py)
    llm.py        the call to Claude
    targets.py    target numbering
    common.py     shared paths and PipelineError
"""

from __future__ import annotations

import argparse
import sys
from datetime import date

from common import POS_DIR, ROOT, PipelineError
from documents import build, generate_tex
from llm import MODEL
from posting import read_posting
from targets import next_target


def run(source: str, model: str) -> None:
    posting = read_posting(source, model)

    now = date.today()
    today = f"{now.month}_{now.day}_{now:%y}"
    target = next_target(today)
    POS_DIR.mkdir(parents=True, exist_ok=True)
    pos_path = POS_DIR / f"{today}_ctx_{target}.md"
    header = f"Source: {source}\n\n" if source.lower().startswith("http") else ""
    pos_path.write_text(header + posting + "\n", encoding="utf-8", newline="\n")
    print(f"Saved posting to {pos_path.relative_to(ROOT)}")

    print("Writing resume")
    resume_tex = generate_tex("res", posting, None, model)
    resume_tex, res_tex, res_pdf = build("res", resume_tex, f"{today}_res_{target}", model)

    print("Writing cover letter")
    letter_tex = generate_tex("cl", posting, resume_tex, model)
    _, cl_tex, cl_pdf = build("cl", letter_tex, f"{today}_cl_{target}", model)

    print("\nDone. Review both documents before sending:")
    for path in (pos_path, res_tex, res_pdf, cl_tex, cl_pdf):
        print(f"  {path.relative_to(ROOT)}")


def main() -> int:
    parser = argparse.ArgumentParser(description="Generate a tailored resume and cover letter from a job posting.")
    parser.add_argument("source", help="Job posting URL, or a path to a text file holding the posting")
    parser.add_argument("--model", default=MODEL, help=f"Claude model (default: {MODEL})")
    args = parser.parse_args()
    for stream in (sys.stdout, sys.stderr):  # Windows consoles can't encode all web text.
        stream.reconfigure(errors="replace")
    try:
        run(args.source, args.model)
    except PipelineError as error:
        print(f"Error: {error}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())

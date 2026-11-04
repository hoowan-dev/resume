"""Downloads web pages and reduces them to readable text."""

from __future__ import annotations

import html
import json
import re
import shutil
import subprocess
import tempfile
import urllib.request
from html.parser import HTMLParser
from pathlib import Path

from common import PipelineError

FETCH_TIMEOUT_S = 30
USER_AGENT = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/130 Safari/537.36"
MIN_PAGE_CHARS = 500  # Less readable text than this means a JS shell or an error page.


class _TextExtractor(HTMLParser):
    SKIP = {"script", "style", "noscript", "svg", "nav", "footer", "header", "template", "head"}
    BLOCK = {"p", "div", "br", "li", "ul", "ol", "tr", "section", "article",
             "h1", "h2", "h3", "h4", "h5", "h6"}

    def __init__(self) -> None:
        super().__init__(convert_charrefs=True)
        self.parts: list[str] = []
        self.skip_depth = 0

    def handle_starttag(self, tag, attrs):
        if tag in self.SKIP:
            self.skip_depth += 1
        elif tag in self.BLOCK:
            self.parts.append("\n")

    def handle_endtag(self, tag):
        if tag in self.SKIP:
            self.skip_depth = max(0, self.skip_depth - 1)
        elif tag in self.BLOCK:
            self.parts.append("\n")

    def handle_data(self, data):
        if not self.skip_depth:
            self.parts.append(data)


def html_to_text(markup: str) -> str:
    parser = _TextExtractor()
    parser.feed(markup)
    lines = (re.sub(r"[ \t\xa0]+", " ", line).strip() for line in "".join(parser.parts).splitlines())
    return re.sub(r"\n{3,}", "\n\n", "\n".join(lines)).strip()


def _job_posting_json_ld(markup: str) -> str | None:
    """Return the schema.org JobPosting embedded in a page, if it has a full description."""
    blocks = re.findall(
        r"<script[^>]*application/ld\+json[^>]*>(.*?)</script>", markup, re.DOTALL | re.IGNORECASE
    )
    for block in blocks:
        try:
            data = json.loads(block)
        except json.JSONDecodeError:
            continue
        items = data if isinstance(data, list) else data.get("@graph", [data])
        for item in items:
            if not isinstance(item, dict) or item.get("@type") != "JobPosting":
                continue
            description = html_to_text(html.unescape(str(item.get("description", ""))))
            if len(description) < MIN_PAGE_CHARS:
                continue
            company = item.get("hiringOrganization")
            company = company.get("name") if isinstance(company, dict) else company
            return (
                f"Title: {item.get('title', '')}\nCompany: {company or ''}\n"
                f"Location: {json.dumps(item.get('jobLocation', ''))}\n\n{description}"
            )
    return None


def page_text(markup: str) -> str:
    return _job_posting_json_ld(markup) or html_to_text(markup)


def fetch_static(url: str) -> str:
    request = urllib.request.Request(url, headers={"User-Agent": USER_AGENT})
    with urllib.request.urlopen(request, timeout=FETCH_TIMEOUT_S) as response:
        charset = response.headers.get_content_charset() or "utf-8"
        return response.read().decode(charset, errors="replace")


def find_browser() -> str | None:
    program_dirs = [r"C:\Program Files", r"C:\Program Files (x86)"]
    candidates = [
        rf"{base}\{app}" for base in program_dirs
        for app in (r"Microsoft\Edge\Application\msedge.exe", r"Google\Chrome\Application\chrome.exe")
    ]
    for name in ("msedge", "chrome", "google-chrome", "chromium"):
        if found := shutil.which(name):
            return found
    return next((path for path in candidates if Path(path).exists()), None)


def fetch_rendered(url: str) -> str:
    """Load the page in a headless browser, for postings that are rendered by JavaScript."""
    browser = find_browser()
    if not browser:
        raise PipelineError("No Edge or Chrome found to render the page.")
    with tempfile.TemporaryDirectory() as profile:
        result = subprocess.run(
            [browser, "--headless=new", "--disable-gpu", f"--user-data-dir={profile}",
             "--virtual-time-budget=15000", "--dump-dom", url],
            capture_output=True, encoding="utf-8", errors="replace", timeout=120,
        )
    return result.stdout

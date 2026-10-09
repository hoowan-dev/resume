# LaTeX Resume

A clean, modern, and ATS-friendly LaTeX resume template compiled using **[Tectonic](https://tectonic-typesetting.github.io/)** — a lightweight, zero-configuration TeX engine that downloads required packages on the fly without needing a full multi-gigabyte TeX Live distribution.

Based on the popular [Jake Gutierrez resume template](https://github.com/sb2nov/resume), customized and updated for native Unicode/XeTeX compilation.

---

## Features

- **Lightweight & Fast**: Powered by Tectonic; no massive TeX distributions required.
- **ATS-Friendly**: Fully machine-readable with clean Unicode character mappings.
- **Cross-Platform Build Scripts**: Includes scripts for PowerShell and Bash.
- **Custom Output Naming**: Easily export role-specific or personalized filenames with a single argument.
- **Clean Output Directory**: Compiles directly into `out/`, keeping your project root clutter-free.
- **VS Code Integration**: Press <kbd>F5</kbd> to compile instantly using the *LaTeX Instant Runner* extension.

---

## Quick Start

### Prerequisites

Ensure **Tectonic** is available on your system. It can be found automatically in either:
- Your system `PATH`
- `~/.local/bin/tectonic` (installed automatically when using the VS Code extension)

To install Tectonic manually if needed:
- **Windows (PowerShell)**:
  ```powershell
  irm https://drop-sh.tectonic-typesetting.github.io/install-tectonic.ps1 | iex
  ```
- **macOS / Linux**:
  ```bash
  curl --proto '=https' --tlsv1.2 -fsSL https://drop-sh.tectonic-typesetting.github.io/install-tectonic.sh | sh
  ```

---

## Building the Resume

### Option 1: PowerShell (Windows)

```powershell
# Compile default: out/resume.pdf
.\build.ps1

# Compile with a custom name: out/Juan_Becerra_Resume.pdf
.\build.ps1 Juan_Becerra_Resume
```

*(Note: Specifying the `.pdf` extension is optional; `.\build.ps1 Juan_Becerra_Resume.pdf` works identically).*

### Option 2: Bash / Git Bash (Linux / macOS / Windows)

```bash
# Compile default: out/resume.pdf
./build.sh

# Compile with a custom name: out/Juan_Becerra_Resume.pdf
./build.sh Juan_Becerra_Resume
```

### Option 3: VS Code Interactive Build

1. Open `resume.tex` in VS Code.
2. Press <kbd>F5</kbd> to run the **LaTeX Instant Runner**.

---

## Project Structure

```text
├── resume.tex              # Main LaTeX resume source
├── build.ps1               # PowerShell build script
├── build.sh                # Bash build script
├── out/                    # Output directory for compiled PDFs
├── GEMINI.md               # Context & guidelines for Gemini AI
├── .geminiignore           # Excluded patterns for Gemini AI
├── .gitignore              # Git ignore rules for build artifacts
└── resume.code-workspace   # VS Code workspace settings
```

---

## Customization Tips

- **Sections & Entries**: Use the custom macros defined in `resume.tex`:
  - `\resumeSubheading{Role}{Dates}{Company}{Location}`
  - `\resumeItem{Description}`
  - `\resumeProjectHeading{Project Title | Tech Stack}{Dates}`
- **Spacing**: Margins and line heights are calibrated in the preamble. Adjust `\vspace` increments if you need extra room to keep the document strictly single-page.

---

## License & Credits

- Template layout originally adapted from [sb2nov/resume](https://github.com/sb2nov/resume) by Jake Gutierrez.
- Released under the [MIT License](https://opensource.org/licenses/MIT).


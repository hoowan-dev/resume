# Gemini Workspace Context: Resume Project

This project compiles a professional LaTeX resume to PDF using **Tectonic**.

## Architecture & File Structure

- `resume.tex`: Main LaTeX source file (customized based on the Jake Gutierrez template).
- `build.ps1`: PowerShell build script compiling `resume.tex` into `out/` with optional custom output name.
- `build.sh`: Bash build script for Unix / Git Bash environments.
- `out/`: Build output directory containing generated PDFs.
- `resume.code-workspace`: VS Code workspace settings.

## Build and Run Instructions

### 1. Build via Scripts
- **PowerShell**:
  ```powershell
  # Compile to out/resume.pdf
  .\build.ps1

  # Compile to custom output name (e.g., out/Juan_Becerra_Resume.pdf)
  .\build.ps1 Juan_Becerra_Resume
  ```

- **Bash / Git Bash**:
  ```bash
  # Compile to out/resume.pdf
  ./build.sh

  # Compile to custom output name
  ./build.sh Juan_Becerra_Resume
  ```

### 2. VS Code Interactive Build
- Press <kbd>F5</kbd> to compile the active file using the **LaTeX Instant Runner** extension (Tectonic engine).

## LaTeX Engine & Compatibility Rules

- **Engine**: The project uses **Tectonic** (XeTeX-based).
- **Unicode & ATS Parsing**: XeTeX/Tectonic natively emits Unicode without requiring pdfTeX glyph maps. Any pdfTeX-specific commands (such as `\input{glyphtounicode}` and `\pdfgentounicode=1`) **must** be guarded with `\ifdefined\pdfgentounicode ... \fi` to prevent undefined control sequence errors.
- **Formatting Conventions**:
  - Keep styling consistent with custom macros (`\resumeSubheading`, `\resumeItem`, `\resumeProjectHeading`, `\classesList`).
  - Spacing is carefully tuned via `\vspace` and list definitions to fit neatly on a single page.


# Gemini Workspace Context: Resume Project

This project compiles a professional LaTeX resume to PDF using **Tectonic** and includes a targeted job application pipeline under `targets/`.

## Architecture & File Structure

- `resume.tex`: Main base LaTeX resume source file (customized based on the Jake Gutierrez template).
- `build.ps1`: PowerShell build script compiling either root `resume.tex` into `out/` or targeted resumes/cover letters under `targets/src/` into `targets/out/`.
- `build.sh`: Bash build script for Unix / Git Bash environments supporting both root and `targets/` builds.
- `out/`: Build output directory containing generated base PDFs (`out/resume.pdf`).
- `targets/`: Targeted job application pipeline:
  - `targets/ctx/<id>.md`: Input job description Markdown files.
  - `targets/src/res/<id>.tex`: Generated ATS-optimized LaTeX resumes subtly tailored to each job description.
  - `targets/src/cl/<id>.tex`: Generated tailored cover letter LaTeX source files.
  - `targets/out/res/<id>.pdf`: Compiled PDF resumes generated from `targets/src/res/<id>.tex`.
  - `targets/out/cl/<id>.pdf`: Compiled typeset PDF cover letters generated from `targets/src/cl/<id>.tex`.
- `.agents/skills/target-pipeline/`: Workspace skill defining the automated target resume & cover letter generation pipeline.
- `resume.code-workspace`: VS Code workspace settings.

## Target Tailoring Rules

- **Subtle & Honest Modifications Only**: When creating unique resumes in `targets/src/res/<id>.tex`, changes from `resume.tex` must be subtle—slightly emphasizing and reordering the candidate's existing experience and skills to align with the target position without fabricating experience, altering actual job titles/projects, or adding unverified technologies.

## Build and Run Instructions

### 1. Build via Scripts
- **PowerShell**:
  ```powershell
  # Compile base resume to out/resume.pdf
  .\build.ps1

  # Compile base resume to custom output name (e.g., out/Juan_Becerra_Resume.pdf)
  .\build.ps1 Juan_Becerra_Resume

  # Compile a specific target resume (targets/src/res/<id>.tex -> targets/out/res/<id>.pdf)
  .\build.ps1 -Target 10_26_26_1

  # Compile all target resumes in targets/src/res/
  .\build.ps1 -AllTargets
  ```

- **Bash / Git Bash**:
  ```bash
  # Compile base resume to out/resume.pdf
  ./build.sh

  # Compile base resume to custom output name
  ./build.sh Juan_Becerra_Resume

  # Compile a specific target resume (targets/src/res/<id>.tex -> targets/out/res/<id>.pdf)
  ./build.sh --target 10_26_26_1

  # Compile all target resumes in targets/src/res/
  ./build.sh --all-targets
  ```

### 2. VS Code Interactive Build
- Press <kbd>F5</kbd> to compile the active file using the **LaTeX Instant Runner** extension (Tectonic engine).

## LaTeX Engine & Compatibility Rules

- **Engine**: The project uses **Tectonic** (XeTeX-based).
- **Unicode & ATS Parsing**: XeTeX/Tectonic natively emits Unicode without requiring pdfTeX glyph maps. Any pdfTeX-specific commands (such as `\input{glyphtounicode}` and `\pdfgentounicode=1`) **must** be guarded with `\ifdefined\pdfgentounicode ... \fi` to prevent undefined control sequence errors.
- **Formatting Conventions**:
  - Keep styling consistent with custom macros (`\resumeSubheading`, `\resumeItem`, `\resumeProjectHeading`, `\classesList`).
  - Spacing is carefully tuned via `\vspace` and list definitions to fit neatly on a single page.

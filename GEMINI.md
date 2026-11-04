# Gemini Workspace Context: Resume Project

This project compiles a professional LaTeX resume to PDF using **Tectonic** and includes a targeted job application pipeline under `targets/`.

## Architecture & File Structure

- `resume.tex`: Main base LaTeX resume source file (customized based on the Jake Gutierrez template).
- `scripts/build.ps1`: PowerShell build script compiling a given `.tex` file into a given output directory.
- `scripts/make_cv.ps1`: Runs `src/make_cv.py` for one or more job posting links.
- `src/make_cv.py`: Entry point that turns a job posting link into a saved posting, tailored `.tex` files, and PDFs, following the `target-pipeline` skill's rules. Its modules in `src/`:
  - `posting.py`: Link or file to clean job posting.
  - `fetch.py`: Downloads pages and reduces them to text.
  - `documents.py`: Writes and repairs the resume and cover letter.
  - `latex.py`: Compiles through `scripts/build.ps1` and counts pages.
  - `llm.py`: Calls Claude through the CLI, with tools disabled.
  - `targets.py`: Target numbering.
  - `common.py`: Shared paths and error type.
- `out/`: Build output directory containing generated base PDFs (`out/resume.pdf`).
- `targets/`: Targeted job application pipeline (files follow `<MM_DD_YY>_<X>_<Y>` where `<X>` is `ctx`, `res`, or `cl` and `<Y>` is the target number):
  - `targets/ctx/pos/<MM_DD_YY>_ctx_<Y>.md`: Input job description Markdown files.
  - `targets/ctx/cv/cv.md`: Master skills inventory with evidence for each skill; used as context for every tailored resume and cover letter.
  - `targets/src/res/<MM_DD_YY>_res_<Y>.tex`: Generated ATS-optimized LaTeX resumes subtly tailored to each job description.
  - `targets/src/cl/<MM_DD_YY>_cl_<Y>.tex`: Generated tailored cover letter LaTeX source files.
  - `targets/out/res/<MM_DD_YY>_res_<Y>.pdf`: Compiled PDF resumes generated from `targets/src/res/<MM_DD_YY>_res_<Y>.tex`.
  - `targets/out/cl/<MM_DD_YY>_cl_<Y>.pdf`: Compiled typeset PDF cover letters generated from `targets/src/cl/<MM_DD_YY>_cl_<Y>.tex`.
- `.agents/skills/target-pipeline/`: Workspace skill defining the automated target resume & cover letter generation pipeline.
- `resume.code-workspace`: VS Code workspace settings.

## Target Tailoring Rules

- **Subtle & Honest Modifications Only**: When creating unique resumes in `targets/src/res/<MM_DD_YY>_res_<Y>.tex`, changes from `resume.tex` must be subtle—slightly emphasizing and reordering the candidate's existing experience and skills to align with the target position without fabricating experience, altering actual job titles/projects, or adding unverified technologies. Skills may come from `resume.tex` or the main sections of `targets/ctx/cv/cv.md`; never use its `Confirm Before Claiming` section, and never tie a "confirmed by Juan" skill to a specific role or project.

## Build and Run Instructions

### 1. Build via Script
`scripts/build.ps1` takes a `.tex` file and an output directory, and writes `<OutDir>/<name>.pdf`. Add `-KeepLogs` to also keep the build log.

```powershell
# Compile base resume to out/resume.pdf
.\scripts\build.ps1 resume.tex out

# Compile a target resume to targets/out/res/10_26_26_res_1.pdf
.\scripts\build.ps1 targets\src\res\10_26_26_res_1.tex targets\out\res

# Compile a target cover letter to targets/out/cl/10_26_26_cl_1.pdf
.\scripts\build.ps1 targets\src\cl\10_26_26_cl_1.tex targets\out\cl
```

### 2. Generate from Job Links
```powershell
# Save each posting, then generate and compile its resume and cover letter
.\scripts\make_cv.ps1 "<url1>", "<url2>"
```

### 3. VS Code Interactive Build
- Press <kbd>F5</kbd> to compile the active file using the **LaTeX Instant Runner** extension (Tectonic engine).

## LaTeX Engine & Compatibility Rules

- **Engine**: The project uses **Tectonic** (XeTeX-based).
- **Unicode & ATS Parsing**: XeTeX/Tectonic natively emits Unicode without requiring pdfTeX glyph maps. Any pdfTeX-specific commands (such as `\input{glyphtounicode}` and `\pdfgentounicode=1`) **must** be guarded with `\ifdefined\pdfgentounicode ... \fi` to prevent undefined control sequence errors.
- **Formatting Conventions**:
  - Keep styling consistent with custom macros (`\resumeSubheading`, `\resumeItem`, `\resumeProjectHeading`, `\classesList`).
  - Spacing is carefully tuned via `\vspace` and list definitions to fit neatly on a single page.

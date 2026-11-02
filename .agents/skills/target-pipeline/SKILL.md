---
name: target-pipeline
description: >-
  Use this skill when generating tailored, ATS-optimized resumes and cover letters
  from job descriptions under targets/ctx/. Handles reading job descriptions in
  targets/ctx/<MM_DD_YY>_ctx_<Y>.md, authoring a subtly tailored LaTeX resume in
  targets/src/res/<MM_DD_YY>_res_<Y>.tex based on resume.tex, compiling the PDF resume
  to targets/out/res/<MM_DD_YY>_res_<Y>.pdf via Tectonic, and generating a tailored
  LaTeX cover letter in targets/src/cl/<MM_DD_YY>_cl_<Y>.tex and targets/out/cl/<MM_DD_YY>_cl_<Y>.pdf.
---

# Target Application Pipeline (`targets/`)

This skill executes the end-to-end job application pipeline under `targets/` for one or more job description files placed in `targets/ctx/`.

## Pipeline Directory Layout & Naming Convention

All files under `targets/` follow the convention `<MM_DD_YY>_<X>_<Y>`, where `<X>` is `ctx`, `res`, or `cl`, and `<Y>` is the target number:

```text
targets/
├── ctx/            # Input: Job descriptions as Markdown files (<MM_DD_YY>_ctx_<Y>.md)
├── src/
│   ├── res/        # Generated: Subtly tailored LaTeX resumes (<MM_DD_YY>_res_<Y>.tex)
│   └── cl/         # Generated: Tailored cover letters in LaTeX (<MM_DD_YY>_cl_<Y>.tex)
└── out/
    ├── res/        # Output: Compiled PDF resumes (<MM_DD_YY>_res_<Y>.pdf)
    └── cl/         # Output: Compiled PDF cover letters (<MM_DD_YY>_cl_<Y>.pdf)
```

---

## Step-by-Step Workflow

For each target `<MM_DD_YY>_ctx_<Y>.md` in `targets/ctx/`:

### 1. Analyze Profile & Job Context
1. Read `resume.tex` and `README.md` at the repository root to load the candidate's base profile, experience, projects, education, and skills.
2. Read `targets/ctx/<MM_DD_YY>_ctx_<Y>.md` to extract:
   - **Role Title & Role ID**
   - **Company, Studio/Department, and Team Mission**
   - **Location & Work Model**
   - **Hiring Manager & Recruiter** (if listed)
   - **Core Responsibilities & Qualifications**
   - **Relevant Overlapping Keywords** (languages, tools, systems, and workflows that genuinely overlap with `resume.tex`)

### 2. Generate Subtly Tailored LaTeX Resume (`targets/src/res/<MM_DD_YY>_res_<Y>.tex`)
Create `targets/src/res/<MM_DD_YY>_res_<Y>.tex` modeled on `resume.tex` (and matching the concise style of `10_26_26_res_3.tex`) while adhering to these strict truthfulness and formatting rules:
- **Strict Truthfulness & Subtlety Rule (CRITICAL)**:
  - Changes from the original `resume.tex` **must be subtle**.
  - **NEVER lie, fabricate, or exaggerate experience.** Do not claim the candidate used languages, databases, or frameworks in a role unless stated in `resume.tex`.
  - **NEVER add skills or technologies** to `Technical Skills` that are not already in `resume.tex` / `README.md`.
  - **Preserve actual job titles and project names** (`Software Engineer -- Tools \& Tech-Art`, `Software Engineer -- Gameplay \& Animation`, `Senior Games Test Engineer`, `Hoowan Game Engine`, `DoomSlop`).
- **How to Tailor Subtly for ATS**:
  - **Header Subtitle**: Keep close to `Software Engineer -- Gameplay, Animation \& Tools` or `Software Engineer -- Gameplay, Animation \& Systems`.
  - **Bullet Reordering & Slight Emphasis**: Reorder the existing bullets within each role so the accomplishment most relevant to the target position appears first, and make only slight, truthful wording refinements.
  - **Technical Skills Ordering**: Keep the exact skills from `resume.tex` on compact single lines per category, reordering categories and items so matching skills appear first.
- **Engine & Single-Page Fit**:
  - Preserve the exact preamble, margins, custom commands, and `\ifdefined\pdfgentounicode ... \fi` guard required for Tectonic (XeTeX).
  - Ensure the compiled document fits cleanly on **1 page**.

### 3. Compile Resume PDF (`targets/out/res/<MM_DD_YY>_res_<Y>.pdf`)
Run the root build script to compile `targets/src/res/<MM_DD_YY>_res_<Y>.tex` into `targets/out/res/<MM_DD_YY>_res_<Y>.pdf`:

```powershell
.\build.ps1 -Target <MM_DD_YY>_ctx_<Y>
```
*(Or compile all targets at once with `.\build.ps1 -AllTargets`)*.

Verify that:
- Tectonic exits with code `0`.
- `targets/out/res/<MM_DD_YY>_res_<Y>.pdf` exists and fits on 1 page.

### 4. Generate Tailored Cover Letter (`targets/src/cl/<MM_DD_YY>_cl_<Y>.tex` & `targets/out/cl/<MM_DD_YY>_cl_<Y>.pdf`)
Generate an honest, compelling, role-specific LaTeX cover letter grounded strictly in Juan Becerra's true profile (matching the style and formatting of `targets/src/cl/10_26_26_cl_3.tex`, without em-dashes):
1. **Header & Addressee**:
   - Include Juan Becerra's contact information (Seattle, WA, phone, email, portfolio `hoowan.dev`, LinkedIn, GitHub).
   - Address the letter to the specific **Hiring Manager** if named in `targets/ctx/<MM_DD_YY>_ctx_<Y>.md`, or to the `<Company/Studio> Hiring Team` if unnamed. Reference the exact **Role Title** and **Role ID** (if present).
2. **Output Files**:
   - Write the LaTeX source to `targets/src/cl/<MM_DD_YY>_cl_<Y>.tex`.
   - Compile the matching typeset PDF version to `targets/out/cl/<MM_DD_YY>_cl_<Y>.pdf` using [compile_cover_letter.ps1](./scripts/compile_cover_letter.ps1):
     ```powershell
     .\.agents\skills\target-pipeline\scripts\compile_cover_letter.ps1 -Target <MM_DD_YY>_ctx_<Y>
     ```

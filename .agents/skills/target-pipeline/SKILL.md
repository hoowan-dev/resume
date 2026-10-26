---
name: target-pipeline
description: >-
  Use this skill when generating tailored, ATS-optimized resumes and cover letters
  from job descriptions under targets/ctx/. Handles reading job descriptions,
  authoring a subtly tailored LaTeX resume in targets/src/res/<id>.tex based on resume.tex,
  compiling the PDF resume to targets/out/res/<id>.pdf via Tectonic, and generating
  a tailored cover letter in targets/src/cl/<id>.md and targets/out/cl/<id>.pdf.
---

# Target Application Pipeline (`targets/`)

This skill executes the end-to-end job application pipeline under `targets/` for one or more job description files placed in `targets/ctx/`.

## Pipeline Directory Layout

```text
targets/
├── ctx/            # Input: Job descriptions as Markdown files (<id>.md)
├── src/
│   ├── res/        # Generated: Subtly tailored ATS-optimized LaTeX resumes (<id>.tex)
│   └── cl/         # Generated: Tailored cover letters in Markdown (<id>.md)
└── out/
    ├── res/        # Output: Compiled PDF resumes (<id>.pdf)
    └── cl/         # Output: Compiled PDF cover letters (<id>.pdf)
```

---

## Step-by-Step Workflow

For each target `<id>.md` in `targets/ctx/<id>.md`:

### 1. Analyze Profile & Job Context
1. Read `resume.tex` and `README.md` at the repository root to load the candidate's base profile, experience, projects, education, and skills.
2. Read `targets/ctx/<id>.md` to extract:
   - **Role Title & Role ID**
   - **Company, Studio/Department, and Team Mission**
   - **Location & Work Model**
   - **Hiring Manager & Recruiter** (if listed)
   - **Core Responsibilities & Qualifications**
   - **Relevant Overlapping Keywords** (languages, tools, systems, and workflows that genuinely overlap with `resume.tex`)

### 2. Generate Subtly Tailored LaTeX Resume (`targets/src/res/<id>.tex`)
Create `targets/src/res/<id>.tex` modeled directly on `resume.tex` while adhering to these strict truthfulness and formatting rules:
- **Strict Truthfulness & Subtlety Rule (CRITICAL)**:
  - Changes from the original `resume.tex` **must be subtle**.
  - **NEVER lie, fabricate, or exaggerate experience.** Do not claim the candidate used languages, databases, or frameworks in a role unless stated in `resume.tex`.
  - **NEVER add skills or technologies** to `Technical Skills` that are not already in `resume.tex` / `README.md`.
  - **Preserve actual job titles and project names** (`Software Engineer -- Tools \& Tech-Art`, `Software Engineer -- Gameplay \& Animation`, `Senior Games Test Engineer`, `Hoowan Game Engine`, `DoomSlop`).
- **How to Tailor Subtly for ATS**:
  - **Header Subtitle**: Keep close to `Software Engineer -- Gameplay, Animation \& Systems` (e.g., adjusting word order or subtly highlighting `Systems, Tools \& Gameplay` or `Systems, ML Pipelines \& Gameplay` when relevant).
  - **Bullet Reordering & Slight Emphasis**: Reorder the existing bullets within each role so the accomplishment most relevant to the target position appears first, and make only slight, truthful wording refinements to highlight transferable aspects (e.g., data export to query databases, multi-threaded asynchronous APIs, memory/compute profiling, PyTorch/ONNX pipeline integration, or cross-studio Python tooling).
  - **Technical Skills Ordering**: Keep the exact skills from `resume.tex`, but reorder categories and items within each list so the candidate's existing skills that match the job description (e.g., `Python, SQL, Rust, C++` or `C++, Java, Python, SQL`) appear first.
- **Engine & Single-Page Fit**:
  - Preserve the exact preamble, margins, custom commands, and `\ifdefined\pdfgentounicode ... \fi` guard required for Tectonic (XeTeX).
  - Ensure the compiled document fits cleanly on **1 page**.

### 3. Compile Resume PDF (`targets/out/res/<id>.pdf`)
Run the root build script to compile `targets/src/res/<id>.tex` into `targets/out/res/<id>.pdf`:

```powershell
.\build.ps1 -Target <id>
```
*(Or compile all targets at once with `.\build.ps1 -AllTargets`)*.

Verify that:
- Tectonic exits with code `0`.
- `targets/out/res/<id>.pdf` exists and fits on 1 page.

### 4. Generate Tailored Cover Letter (`targets/src/cl/<id>.md` & `targets/out/cl/<id>.pdf`)
Generate an honest, compelling, role-specific cover letter grounded strictly in Juan Becerra's true profile:
1. **Header & Addressee**:
   - Include Juan Becerra's contact information (Seattle, WA, phone, email, portfolio `hoowan.dev`, LinkedIn, GitHub).
   - Address the letter to the specific **Hiring Manager** if named in `targets/ctx/<id>.md` (e.g., `Dear Yen Feng,` or `Dear Sara Khurshid Uppal,`), or to the `<Department/Team> Hiring Team` if unnamed. Reference the exact **Role Title** and **Role ID**.
2. **Narrative Structure**:
   - **Opening**: Express enthusiasm for the role and team mission, highlighting current tenure at Electronic Arts (EA Lifestyle in Kirkland, WA & EA Maxis Studios).
   - **Body Paragraphs**: Truthfully describe Juan's work at EA Lifestyle (Maya/Python tools, high-throughput UE C++ trajectory/pose/velocity data export plugin for motion-matching query databases, PyTorch/ONNX ML authoring pipelines) and EA Maxis Studios (UE5/C++ multi-threaded async path-planning/navigation API within <1.5ms budgets, locomotion/motion-matching systems, compute/memory profiling, and visual debuggers), plus Lionbridge QA leadership and University of Washington graduate ML/DL coursework—explaining how these engineering foundations transfer to the target team's problems.
   - **Closing**: Reiterate excitement to contribute in Kirkland/Seattle and thank the reader.
3. **Output Files**:
   - Write the Markdown source to `targets/src/cl/<id>.md`.
   - Compile the matching typeset PDF version to `targets/out/cl/<id>.pdf` using [compile_cover_letter.ps1](./scripts/compile_cover_letter.ps1):
     ```powershell
     .\.agents\skills\target-pipeline\scripts\compile_cover_letter.ps1 -Target <id>
     ```

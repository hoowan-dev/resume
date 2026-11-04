# Juan Becerra — Resume

Professional resume for **Juan Becerra** (Software Engineer & Game Developer), tailored for AAA game engineering, runtime gameplay systems, and tools/tech-art pipelines.

👉 **[View / Download Resume (PDF)](out/resume.pdf)**

Compiled to PDF using **[Tectonic](https://tectonic-typesetting.github.io/)** — a lightweight, modern TeX engine that handles native Unicode/XeTeX compilation and downloads required packages on the fly with zero configuration.

---

## Profile Summary

* **Role**: Software Engineer · Game Developer
* **Resume (PDF)**: **[out/resume.pdf](out/resume.pdf)**
* **Location**: Seattle, WA
* **Website / Portfolio**: [hoowan.dev](https://hoowan.dev)
* **GitHub**: [github.com/hoowan-dev](https://github.com/hoowan-dev)
* **LinkedIn**: [linkedin.com/in/hoowan](https://www.linkedin.com/in/hoowan/)
* **Email**: [becerrajuan007@gmail.com](mailto:becerrajuan007@gmail.com)

---

## Overview & Highlights

* **AAA Experience**: 5+ years across **Electronic Arts** (Lifestyle, Maxis Studios) and **Lionbridge**.
  * *EA Lifestyle*: Maya/Python stylization tools, Unreal Engine C++ trajectory data export plugins for motion matching, ML-assisted authoring pipelines (PyTorch/ONNX).
  * *EA Maxis Studios (Project Rene / The Sims)*: Multi-threaded async path-planning APIs (<1.5ms budget), motion-matching locomotion, distance matching, custom IK solvers, runtime memory/frame optimizations, designer tuning tools.
  * *Lionbridge*: QA test leadership, technical repro pipelines, and engine diagnostics in JIRA.
* **Featured Projects**:
  * **Hoowan Game Engine**: Custom C++ engine with OpenGL rendering submission pipeline, EnTT ECS, event polling, collision detection, and editor application.
  * **DoomSlop**: 3D browser first-person shooter built in Three.js and Vite with Web Audio API sound synthesis and automated GitHub Pages CI/CD ([Live Demo](https://hoowan-dev.github.io/DoomSlop/)).
* **Education & Continuing Studies**:
  * *Boise State University*: B.S. in Computer Science (2017 – 2021).
  * *University of Washington (Continuing Education)*: Graduate Coursework in Machine Learning & Deep Learning (Non-Degree, In Progress, 2026 – Present).
* **Core Competencies**:
  * *Languages*: Modern C++ (Modern, Multi-threading), C#, Python, Rust, GLSL/HLSL, Java, JavaScript, SQL
  * *Engines & Graphics*: Unreal Engine 5 (Source, Motion Matching, GAS, Mass/Crowd), Unity, Godot, Vulkan, OpenGL
  * *Gameplay & Systems*: Locomotion & Character Physics, Async Navigation/Pathfinding, Animation Runtime (IK, Motion Matching), State Machines
  * *Tools & ML Pipelines*: Maya API, PySide/Qt, DCC Pipeline Automation, Unreal Plugin Development, PyTorch/ONNX, In-Editor Tooling
  * *Infrastructure & Tools*: Perforce (P4), Git, Docker, JIRA, CMake, Visual Studio, Linux, AWS, CI/CD

---

## Building the Resume

### Prerequisites

Compilation requires **Tectonic**, which is resolved automatically from:
1. System `PATH`
2. Local installation at `~/.local/bin/tectonic.exe` (installed automatically if using the VS Code extension)

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

### Build Commands

#### Option 1: PowerShell

`scripts/build.ps1` takes a `.tex` file and an output directory, and writes `<OutDir>/<name>.pdf`. Add `-KeepLogs` to also keep the build log.

```powershell
# Base resume -> out/resume.pdf
.\scripts\build.ps1 resume.tex out

# Target resume -> targets/out/res/10_26_26_res_1.pdf
.\scripts\build.ps1 targets\src\res\10_26_26_res_1.tex targets\out\res

# Target cover letter -> targets/out/cl/10_26_26_cl_1.pdf
.\scripts\build.ps1 targets\src\cl\10_26_26_cl_1.tex targets\out\cl
```

#### Option 2: VS Code Interactive Build

1. Open `resume.tex` (or any `targets/src/res/<MM_DD_YY>_res_<Y>.tex`) in VS Code.
2. Press <kbd>F5</kbd> to compile instantly via the **LaTeX Instant Runner** extension.

---

## Target Application Pipeline (`targets/`)

The `targets/` pipeline generates role-specific, ATS-optimized resumes and cover letters from Markdown job descriptions using the naming convention `<MM_DD_YY>_<X>_<Y>` (where `<X>` is `ctx`, `res`, or `cl`, and `<Y>` is the target number).

Everything under `targets/` (job postings, the skills inventory, and generated documents) is private and git-ignored, so it exists only on the machine that created it. On a fresh clone, the pipeline needs `targets/ctx/cv/cv.md` plus the style examples named in `src/documents.py` before it can run.

### From a job link

Requires PowerShell, Tectonic, and the logged-in [`claude` CLI](https://claude.com/claude-code).

```powershell
# One or more links; a failed link doesn't stop the rest
.\scripts\make_cv.ps1 "<url>"
.\scripts\make_cv.ps1 "<url1>", "<url2>"

# A single link, or a text file holding a posting for sites that block fetching
python src\make_cv.py "<url>"
python src\make_cv.py posting.txt
```

Each posting is saved to `targets/ctx/pos/`, then its resume and cover letter are generated and compiled to one page each, using today's date and the next free target number. Review both documents before sending.

### From a saved job description

1. Place a job description in `targets/ctx/pos/<MM_DD_YY>_ctx_<Y>.md`. The skills inventory in `targets/ctx/cv/cv.md` is used as context for every target.
2. Run the **`target-pipeline`** skill (located in `.agents/skills/target-pipeline/SKILL.md`), which:
   - Generates a subtly tailored, ATS-optimized LaTeX resume at `targets/src/res/<MM_DD_YY>_res_<Y>.tex`.
   - Compiles the PDF resume to `targets/out/res/<MM_DD_YY>_res_<Y>.pdf`.
   - Generates a tailored LaTeX cover letter at `targets/src/cl/<MM_DD_YY>_cl_<Y>.tex` and compiles `targets/out/cl/<MM_DD_YY>_cl_<Y>.pdf`.

---

## Project Structure

```text
├── resume.tex                        # Main base LaTeX resume source (single-page, ATS-optimized)
├── scripts/
│   ├── build.ps1                     # Compiles a .tex file into an output directory
│   └── make_cv.ps1                   # Runs src/make_cv.py for one or more job links
├── src/
│   ├── make_cv.py                    # Entry point: job link -> posting, tailored .tex files, and PDFs
│   ├── posting.py                    # Link or file -> clean job posting
│   ├── fetch.py                      # Downloads pages and reduces them to text
│   ├── documents.py                  # Writes and repairs the resume and cover letter
│   ├── latex.py                      # Compiles through scripts/build.ps1 and counts pages
│   ├── llm.py                        # Calls Claude through the CLI, with tools disabled
│   ├── targets.py                    # Target numbering
│   └── common.py                     # Shared paths and error type
├── out/resume.pdf                    # Compiled base PDF resume (tracked in git)
├── targets/
│   ├── ctx/
│   │   ├── pos/                      # Input job descriptions (<MM_DD_YY>_ctx_<Y>.md)
│   │   └── cv/cv.md                  # Master skills inventory with evidence
│   ├── src/
│   │   ├── res/                      # Tailored ATS-optimized LaTeX resumes (<MM_DD_YY>_res_<Y>.tex)
│   │   └── cl/                       # Tailored LaTeX cover letters (<MM_DD_YY>_cl_<Y>.tex)
│   └── out/
│       ├── res/                      # Compiled target PDF resumes (<MM_DD_YY>_res_<Y>.pdf)
│       └── cl/                       # Compiled target PDF cover letters (<MM_DD_YY>_cl_<Y>.pdf)
├── .agents/skills/target-pipeline/   # Workspace skill for the target application pipeline
├── GEMINI.md                         # Context & guidelines for Gemini AI
├── README.md                         # Repository documentation
├── .geminiignore                     # Excluded patterns for Gemini AI
├── .gitignore                        # Git ignore rules
└── resume.code-workspace             # VS Code workspace settings
```

---

## Credits & License

- Resume formatting adapted from the [Jake Gutierrez resume template](https://github.com/sb2nov/resume).
- Released under the [MIT License](https://opensource.org/licenses/MIT).

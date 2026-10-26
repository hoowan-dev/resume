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

#### Option 1: PowerShell (Windows)

```powershell
# Default build -> out/resume.pdf
.\build.ps1

# Custom output filename -> out/Juan_Becerra_Resume.pdf
.\build.ps1 Juan_Becerra_Resume

# Target pipeline build -> targets/out/res/<id>.pdf
.\build.ps1 -Target 10_26_26_1

# Build all targets in targets/src/res/
.\build.ps1 -AllTargets
```

#### Option 2: Bash / Git Bash (Linux / macOS / Windows)

```bash
# Default build -> out/resume.pdf
./build.sh

# Custom output filename -> out/Juan_Becerra_Resume.pdf
./build.sh Juan_Becerra_Resume

# Target pipeline build -> targets/out/res/<id>.pdf
./build.sh --target 10_26_26_1

# Build all targets in targets/src/res/
./build.sh --all-targets
```

#### Option 3: VS Code Interactive Build

1. Open `resume.tex` (or any `targets/src/res/<id>.tex` / `targets/src/cl/<id>.tex`) in VS Code.
2. Press <kbd>F5</kbd> to compile instantly via the **LaTeX Instant Runner** extension.

---

## Target Application Pipeline (`targets/`)

The `targets/` pipeline generates role-specific, ATS-optimized resumes and cover letters from Markdown job descriptions:

1. Place a job description in `targets/ctx/<id>.md`.
2. Run the **`target-pipeline`** skill (located in `.agents/skills/target-pipeline/SKILL.md`), which:
   - Generates a subtly tailored, ATS-optimized LaTeX resume at `targets/src/res/<id>.tex`.
   - Compiles the PDF resume to `targets/out/res/<id>.pdf`.
   - Generates a tailored LaTeX cover letter at `targets/src/cl/<id>.tex` and compiles `targets/out/cl/<id>.pdf`.

---

## Project Structure

```text
├── resume.tex                        # Main base LaTeX resume source (single-page, ATS-optimized)
├── build.ps1                         # PowerShell build script (root & target pipeline support)
├── build.sh                          # Bash build script (root & target pipeline support)
├── out/resume.pdf                    # Compiled base PDF resume (tracked in git)
├── targets/
│   ├── ctx/                          # Input job descriptions (<id>.md)
│   ├── src/
│   │   ├── res/                      # Tailored ATS-optimized LaTeX resumes (<id>.tex)
│   │   └── cl/                       # Tailored LaTeX cover letters (<id>.tex)
│   └── out/
│       ├── res/                      # Compiled target PDF resumes (<id>.pdf)
│       └── cl/                       # Compiled target PDF cover letters (<id>.pdf)
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

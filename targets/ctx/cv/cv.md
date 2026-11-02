# CV Skills Inventory: Juan Becerra

Master list of skills for tailoring resumes and cover letters, with evidence where available so tailored documents only claim what can be backed up.

**Sources:** `resume.tex`, earlier tailored resumes and cover letters, [hoowan.dev](https://hoowan.dev/), [hoowan.dev/portfolio.html](https://hoowan.dev/portfolio.html), [LinkedIn](https://www.linkedin.com/in/hoowan/), and skills confirmed directly by Juan.

Each entry reads: **Skill**: evidence. *Keywords:* matching wording from target postings. Entries marked "confirmed by Juan" have no written evidence yet; add a project or role when you have one.

---

## 1. Languages

- **C++ (Modern, Multi-threading)**: UE5 navigation/animation systems (Maxis), UE plugin (Lifestyle), Hoowan Game Engine, BroncoDrome, Fractal Image Generator. *Keywords:* modern C++, C++17/20
- **Python**: Maya stylization tool, ML-assisted DCC pipelines, PySide/Qt UIs (Lifestyle); JAMN Sales Tracker (Flask); Grocery Agent. *Keywords:* scripting languages
- **C#**: Chasm, Terrain Engine, Common Co-op (Unity). *Keywords:* Unity scripting
- **Java**: tutored Java projects (BSU Learning Assistant); Chon (Android), Resume Sorter, Bioinformatics BTree, Suspicion Agent
- **JavaScript**: React Native and Express.js API (TurnUp); DoomSlop, 3D Marble Game, Heightmap Terrain. *Keywords:* scripting languages, web
- **TypeScript**: confirmed by Juan. *Keywords:* scripting languages, web
- **C**: Smash Linux shell
- **SQL**: Resume Sorter (SQL Server, prepared statements); asset-tagging schema design (BSU research)
- **Bash**: Smash Linux shell; build scripts in this repo
- **PowerShell**: build scripts in this repo
- **GLSL / HLSL**: vertex and fragment shaders in Heightmap Terrain (WebGL). *Keywords:* shaders
- **ShaderLab / Cg**: Terrain Engine (Unity); Udemy course on Unity shader development
- **Rust**
- **Lua**: confirmed by Juan. *Keywords:* game scripting, tools and editor extensions

## 2. Engines, Graphics & Real-Time 3D

- **Unreal Engine 5 (engine source)**: Project Rene (The Sims) pre-production; Lifestyle plugin work. *Keywords:* 3D engine, real-time rendering platform
- **UE5 Motion Matching**: locomotion (Maxis); trajectory/pose export plugin (Lifestyle)
- **UE5 Gameplay Ability System (GAS)**: gameplay systems (Maxis)
- **UE5 Mass / Crowd**: dense crowd simulation (Maxis)
- **Unreal Engine 4 + Blueprints**: BroncoDrome, a vehicle combat game with AI opponents (team senior design project)
- **Unity**: Chasm, Terrain Engine, Common Co-op (WebGL export), Dreamwoods. *Keywords:* 3D engine
- **OpenGL**: rendering submission pipeline (Hoowan); wheel animation (Chon). *Keywords:* graphics APIs
- **WebGL**: Heightmap Terrain, 3D Marble Game, Common Co-op export
- **Three.js**: DoomSlop, 3D Marble Game. *Keywords:* browser 3D
- **Real-time lighting & shading**: point and ambient lighting, heightmap-driven shaders (Heightmap Terrain)
- **Procedural generation**: fractal terrain, biome partitioning, procedural model placement (Terrain Engine); Mandelbrot rendering (Fractal Image Generator)
- **Web Audio API**: synthesized sound effects (DoomSlop)
- **Godot**
- **Vulkan**: Udemy course "Vulkan API with C++". *Keywords:* graphics APIs
- **Unreal Chaos physics**: confirmed by Juan. *Keywords:* Unreal Engine (Chaos), physics middleware
- **Unity DOTS / Unity Physics**: confirmed by Juan. *Keywords:* Unity (DOTS/Physics), data-oriented design
- **GPU compute (CUDA / compute shaders)**: confirmed by Juan. *Keywords:* GPU compute, compute shaders
- **Direct3D**. *Keywords:* graphics APIs

## 3. Engine & Systems Architecture

- **Multi-threaded / async API design**: async path-planning and navigation API in UE5/C++ (Maxis). *Keywords:* concurrency, systems design
- **Event systems**: animation event systems and navigation events (Maxis); input and event handling (Hoowan)
- **Entity-component systems (ECS)**: EnTT integration (Hoowan). *Keywords:* data-oriented design
- **Data-oriented design & memory management**: confirmed by Juan. *Keywords:* data-oriented design, cache-friendly data structures, memory management, frame/memory budgeting
- **Custom engine development**: Hoowan Game Engine, with 2D rendering API, input polling, and collision. *Keywords:* engine architecture
- **Desktop applications**: Hoowan companion editor; Resume Sorter (Java GUI). *Keywords:* cross-platform desktop software
- **Systems programming**: Smash Linux shell, with piping, redirection, multithreading, and command history; memory-leak checks with Valgrind
- **Large / complex codebases**: large multi-disciplinary UE5/C++ codebase (Maxis). *Keywords:* large or complex codebases

## 4. Gameplay, Animation & Simulation

- **Locomotion & character physics**: core locomotion for Project Rene
- **Animation runtime (motion matching, distance matching, custom IK)**: Maxis
- **Async navigation / pathfinding**: deterministic routing, real-time obstacle avoidance (Maxis)
- **Crowd / multi-agent simulation**: dense crowd scenarios, shared multiplayer simulation (Maxis)
- **State machines & behavior trees**: gameplay state machines; behavior-tree tuning tools (Maxis)
- **Player controls & camera**: responsive character controls (Maxis); pointer-lock movement and camera (DoomSlop)
- **Combat mechanics**: hitscan raycasting, boss encounters (DoomSlop); vehicle combat and power-ups (BroncoDrome); melee action RPG (Chasm)
- **Game AI**: AI opponents (BroncoDrome); Suspicion board-game agent; Grocery bagging agent
- **Physics & collision**: 2D collision detection and correction (Hoowan); rolling physics (3D Marble Game)
- **Collision algorithms (broad-phase / narrow-phase, GJK, SAT, continuous collision detection)**: confirmed by Juan. *Keywords:* collision detection, time of impact, sweep-and-prune, BVH
- **Physics integrators & constraint solvers (semi-implicit Euler, RK, numerical stability)**: confirmed by Juan. *Keywords:* integration schemes, constraint solvers, error control
- **Input systems**: mouse-and-keyboard event polling (Hoowan)
- **HUD / UI**: canvas radar minimap and damage indicators (DoomSlop)
- **Level & puzzle design**: dungeon puzzles (Chasm); sequential levels (3D Marble Game)

## 5. Performance & Engineering Quality

- **Profiling & benchmarking**: runtime memory, compute, and frame budgets (Maxis). *Keywords:* performance
- **Profilers & GPU debuggers (VTune, PIX, Nsight, RenderDoc)**: confirmed by Juan. *Keywords:* profiling/debugging
- **Frame-budget engineering**: navigation API held under 1.5ms (Maxis). *Keywords:* performance, reliability
- **Hitch elimination**: character evaluation graphs and spatial query sweeps (Maxis)
- **Reliability & maintainability tradeoffs**: managing technical risk and long-term maintainability in a shared codebase (Maxis). *Keywords:* pragmatic engineering judgment
- **Code reviews & pull requests**: handled PRs and code reviews (TurnUp). *Keywords:* code reviews
- **Design reviews**: confirmed by Juan. *Keywords:* design reviews, technical discussions
- **Unit testing**: unit testing (TurnUp); taught test-driven development (BSU Learning Assistant). *Keywords:* testing, engineering quality
- **Test suites & crash/regression fixing**: confirmed by Juan. *Keywords:* test suites, golden scenarios, verification and validation, crashes and regressions
- **QA methods: combinatorial, tree, regression, ad hoc, functional, localization**: Lionbridge. *Keywords:* testing
- **Technical repro & engine diagnostics**: bug reports enriched with engine and gameplay insight, triaged in JIRA (Lionbridge)
- **Memory-leak debugging**: Valgrind (Smash)

## 6. Tools, Pipelines & Developer Productivity

- **Unreal plugin development**: high-throughput C++ trajectory/pose/velocity export plugin (Lifestyle)
- **In-editor tooling & visual debuggers**: animation tuning tools and debuggers for designers and animators (Maxis). *Keywords:* developer tools, developer productivity
- **Maya API**: project-agnostic stylization tool adopted across multiple EA studios, cut manual keyframing by over 70% (Lifestyle)
- **PySide / Qt**: modular tool UIs (Lifestyle). *Keywords:* Qt, cross-platform desktop software
- **ImGui**: confirmed by Juan. *Keywords:* ImGui, cross-platform desktop software
- **DCC pipeline automation**: Lifestyle
- **Animation data pipelines**: trajectory, pose, and velocity datasets for motion matching (Lifestyle)
- **Content production pipelines**: distributed content pipeline for the "World Museum" project (BSU research)
- **Image processing & compression**: web-based digital asset management (BSU research)
- **Auto-grading tooling**: refactored an auto-grading system for an online summer curriculum (BSU Learning Assistant)
- **Cross-studio tool adoption**: tool adopted across multiple internal EA studios (Lifestyle)
- **DCC & audio tools**: Blender, 3ds Max, Cascadeur, Wwise, FMOD

## 7. Machine Learning, AI & Agentic Workflows

- **PyTorch**: ML-assisted authoring pipelines (Lifestyle). *Keywords:* AI systems
- **ONNX Runtime**: model inference inside DCC tools (Lifestyle). *Keywords:* integrating AI into production workflows
- **GenAI / ML content tools**: fast, non-intrusive automated asset tagging and procedural pose generation tools for EA projects (Lifestyle). *Keywords:* AI in production developer workflows
- **Classical AI & search**: DFS/BFS with pruning and arc consistency (Grocery Agent); entropy and information gain (Suspicion Agent)
- **ML & deep learning coursework**: UW Continuing Education, covering Intro to ML, Advanced ML, and Deep Learning (2026 to present); BSU graduate-level Artificial Intelligence. *Keywords:* understanding of AI systems
- **AI-assisted development tools (Claude Code, Gemini, Cursor, Codex)**: daily use; this repo is driven by Claude Code and Gemini; Cursor and Codex confirmed by Juan. *Keywords:* Cursor, Claude Code, Codex
- **Agent skill authoring**: `.agents/skills/target-pipeline` with skill instructions and helper scripts. *Keywords:* tools and ecosystems for AI agents
- **Context engineering**: `GEMINI.md`, `.geminiignore`, and skill docs that scope what agents see and do. *Keywords:* context engineering, context management
- **Agentic workflow design**: job-posting-to-PDF pipeline, where an agent reads a posting, writes LaTeX, compiles, and checks the output. *Keywords:* agentic development workflows, tool use
- **Multi-agent systems**: confirmed by Juan. *Keywords:* multi-agent systems
- **Agent harness engineering**: confirmed by Juan. *Keywords:* agent harness engineering, building tools for AI agents
- **Agent evaluation**: confirmed by Juan. *Keywords:* evaluation, reliability of agentic systems

## 8. Web, Mobile & Data

- **React Native**: cross-platform web/mobile app (TurnUp)
- **Express.js / REST APIs**: cross-platform API (TurnUp)
- **Flask**: JAMN Sales Tracker
- **Third-party API integration**: Square, Squarespace, Venmo, and Google Sheets (JAMN Sales Tracker)
- **Data normalization & reporting**: standardized and categorized sales data, net-earnings reports (JAMN Sales Tracker)
- **Android development**: Chon (Android Studio, Java, OpenGL). *Keywords:* mobile development
- **Database schema design**: asset-tagging system (BSU research)
- **SQL Server**: Resume Sorter
- **MySQL / PostgreSQL**
- **Data structures**: self-balancing B-tree (Bioinformatics BTree)

## 9. Build, Infrastructure & DevOps

- **Perforce (P4)**: EA. *Keywords:* version control
- **Git / GitHub / GitLab**: all projects
- **CMake**: Hoowan Game Engine. *Keywords:* build systems
- **CI/CD**: automated GitHub Pages deployments (DoomSlop). *Keywords:* developer infrastructure
- **GitHub Actions**: confirmed by Juan. *Keywords:* build systems, developer infrastructure
- **Vite**: DoomSlop
- **LaTeX / Tectonic**: scripted document builds in this repo
- **Linux**: Smash shell
- **JIRA**: bug tracking and triage (Lionbridge)
- **Jenkins**. *Keywords:* build systems, developer infrastructure
- **Docker**
- **AWS / Google Cloud**
- **Visual Studio**
- **Confluence / Trello**

## 10. Collaboration, Leadership & Process

- **Team leadership**: led a team of QA testers (Lionbridge); led an intern team (TurnUp). *Keywords:* lead by example
- **Cross-discipline partnership**: gameplay designers, technical animators, QA, and the simulation and experience-design teams (Maxis). *Keywords:* cross-functional partners
- **Prototyping & iteration**: prototyped, iterated on, and polished gameplay features with design (Maxis). *Keywords:* iteration speed
- **Technical roadmap planning**: confirmed by Juan. *Keywords:* technical roadmap, architecture decisions
- **Developer enablement**: faster iteration and authoring loops for designers and animators (Maxis, Lifestyle). *Keywords:* developer productivity
- **Teaching & mentoring**: tutored object-oriented design, TDD, and data structures (BSU Learning Assistant)
- **Pre-production**: Project Rene pre-production (Maxis)
- **Agile / Scrum**: BSU coursework in Version Control and Agile Development
- **UX iteration**: HCI course project (Common Co-op)
- **Communication: English (native), Spanish (professional working proficiency)**. *Keywords:* communication skills

## 11. Domains

- AAA game development: Electronic Arts (Maxis Studios, Lifestyle), Lionbridge
- Life simulation: *Project Rene* / *The Sims*
- Live-service multiplayer titles
- Shipped a title: confirmed by Juan (add which title and your role). *Keywords:* shipped a title, AA/AAA
- Character animation and locomotion
- Real-time 3D, both native and in the browser
- Creator / developer tooling
- Educational software: Common Co-op (grades 4 to 5), auto-grading tools
- Music: session musician, music production

---

## Education & Certifications

- **B.S. Computer Science, Boise State University** (2017 to 2021). Coursework: Data Structures, Algorithms, Version Control and Agile Development, Mobile Development, Web Development, Linear Algebra, 2D/3D Game Development
- **BSU graduate-level coursework**: Computer Graphics, Artificial Intelligence, Parallel Computing, Object-Oriented Design Patterns
- **UW Continuing Education (graduate, non-degree)**: Introduction to Machine Learning, Advanced Machine Learning, Deep Learning
- **Udemy**: Unreal Engine C++ Game Development, Advanced C# Scripting in Unity, Advanced C++ Programming, Shader Development for Unity with Cg, Vulkan API with C++
- **Coursera / online series**: Game Engine Architecture, Game Design Patterns, Cherno Game Engine series, Cherno OpenGL series

## Projects (evidence index)

- **DoomSlop** (2026): Three.js/Vite browser FPS with synthesized audio, bosses, radar minimap, and GitHub Pages CI/CD
- **JAMN Sales Tracker** (2026): Python/Flask sales aggregation across Square, Squarespace, Venmo, and Google Sheets
- **BroncoDrome** (2021): UE4 C++/Blueprints vehicle combat game with AI opponents (team senior design project)
- **Common Co-op** (2021): Unity/C# WebGL math game for grades 4 to 5 (HCI course)
- **Hoowan Game Engine** (2020 to present): C++/OpenGL engine with EnTT ECS, events, collision, and an editor
- **Chasm** (2020): Unity/C# third-person action RPG
- **Dreamwoods** (2020): Unity 3D action-adventure game (LinkedIn only)
- **3D Marble Game** (2020): WebGL/three.js rolling physics game (team graphics course project)
- **Fractal Image Generator** (2020): C++ Mandelbrot renderer
- **Terrain Engine** (2020): Unity/C#/ShaderLab procedural terrain with biomes (Advanced Computer Graphics)
- **Chon** (2020): Android/Java/OpenGL decision-wheel app
- **Heightmap Terrain** (2019): JavaScript/WebGL terrain with custom shaders and lighting
- **Suspicion Agent** (2019): Java AI board-game agent
- **Grocery Agent** (2019): Python constraint-search agent
- **Smash** (2019): C/Bash Linux shell, Valgrind-checked
- **Bioinformatics BTree** (2019): Java B-tree for genetic sequences (team project)
- **Resume Sorter** (2018 to 2019): Java GUI with SQL Server for BSU Extended Studies

---

## Confirm Before Claiming

These skills come from target postings (so far `11_2_26_ctx_1`, Snap Lens Studio). None of the sources above back them up yet. When one becomes true, move it into the matching section with its evidence. Delete any that don't apply.

- **Technical specs** (11_2_26_ctx_1): did you write design docs or specs at Maxis or Lifestyle?
- **Conan** (11_2_26_ctx_1)
- **JavaScript engines / embedded runtimes** (11_2_26_ctx_1): running user-provided code in a host app
- **AR / XR development** (11_2_26_ctx_1): Lens Studio, Specs, Snap OS

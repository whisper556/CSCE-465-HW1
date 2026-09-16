# CSCE 465/765 Homework 1: Build and Threat-Model an AI Agent

## Environment Baseline
- **OS:** Ubuntu 24.04 LTS x86_64
- **Node.js:** v24.18.0 (managed via nvm)
- **OpenClaw Version:** 2026.7.1-2
- **Model Adapter:** TAMUS AI API Proxy (`protected.gpt-4o` via local shim)

---

## Repository Structure
```text
hw1/
├── README.md                # Setup and reproduction instructions
├── AI_USAGE.md              # AI assistance disclosure log
├── report.md                # Written homework report
├── benign-tasks.md          # Task 1.5 benign task execution log
├── injection-experiment.md  # Task 3 direct & indirect trial results
├── bin/
│   └── safe_marker.sh       # Input-restricted marker script
├── skills/
│   └── safe-marker/
│       └── SKILL.md         # OpenClaw workspace skill definition
├── web/
│   ├── benign.html          # Fictional status report
│   └── adversarial.html     # Report containing indirect injection payload
├── markers/
│   └── .gitkeep             # Marker destination directory
└── evidence/                # Raw command logs, transcripts, and audit outputs

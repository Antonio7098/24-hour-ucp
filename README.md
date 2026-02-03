# 24h Testers: UCP Testing Suite

> **Mission**: Comprehensive testing of the Unified Content Protocol (UCP) - a graph-based content representation system for LLM manipulation.

---

## Overview

This repository contains an autonomous testing framework configured to thoroughly test UCP across all its platforms and components. The framework uses Stageflow-powered agents to execute 277 test items across 21 tiers.

### What is UCP?

**Unified Content Protocol (UCP)** is a graph-based intermediate representation for structured content, designed for efficient manipulation by Large Language Models. It provides:

- **Graph-based document model** - Blocks, edges, and hierarchical structure
- **Token-efficient command language (UCL)** - DSL for document manipulation
- **Multi-platform SDKs** - Rust, Python, JavaScript
- **Agent traversal system** - Navigation and context management for AI agents
- **LLM optimization tools** - ID mapping, prompt building, token estimation

### Testing Philosophy

We test UCP from first principles: **What should a universal agentic content editing/navigating tool do?** Tests evaluate UCP against these ideals, identifying gaps, bugs, and opportunities.

---

## Quick Start

### 1. Install Dependencies

```bash
# Python environment for the processor
python3 -m venv .venv
source .venv/bin/activate
pip install -r processor/requirements.txt

# UCP SDKs for testing
pip install ucp-content              # Python SDK
npm install @ucp-core/core           # JavaScript SDK
cargo install ucp-cli                # CLI
```

### 2. Configure Agent Permissions

The processor requires non-interactive agent execution:

- **OpenCode**: Enable `bypassPermissions` in your profile
- **Claude Code**: Ensure `--dangerously-skip-permissions` is configured

### 3. Run Tests

```bash
# Finite mode - run through checklist items
python -m processor.cli run \
  --checklist SUT-CHECKLIST.md \
  --mission-brief SUT-PACKET.md \
  --mode finite \
  --batch-size 5

# Dry run to preview
python -m processor.cli run --dry-run

# With specific runtime
python -m processor.cli run \
  --runtime claude-code \
  --model anthropic/claude-3-5-sonnet-20241022
```

---

## Repository Structure

```
24h-ucp-testers/
├── SUT-PACKET.md               # Mission brief (architecture, risks, objectives)
├── SUT-CHECKLIST.md            # 277 test items across 21 tiers
├── config/
│   └── run_config.json         # Structured UCP configuration
├── agent-resources/
│   ├── prompts/
│   │   └── AGENT_SYSTEM_PROMPT.md
│   └── templates/
│       ├── FOLDER_STRUCTURE.md
│       └── FINAL_REPORT_TEMPLATE.md
├── ucp-docs/                   # UCP documentation
├── stageflow-docs/             # StageFlow documentation
├── processor/                  # Stageflow pipeline code
├── tests/                      # Shared test templates
├── runs/                       # Test execution artifacts
└── .processor/                 # Pipeline state
```

---

## Test Coverage

### 21 Tiers, 277 Test Items

| Tier | Focus Area | Items |
|------|------------|-------|
| 1 | Installation & Setup | 8 |
| 2 | Document Lifecycle | 10 |
| 3 | Block Content Types | 18 |
| 4 | Block Metadata | 12 |
| 5 | Document Structure | 18 |
| 6 | Edges & Relationships | 17 |
| 7 | UCL Basic Commands | 23 |
| 8 | UCL Advanced Commands | 17 |
| 9 | UCL Syntax Edge Cases | 12 |
| 10 | Agent Session Management | 6 |
| 11 | Agent Navigation | 16 |
| 12 | Agent Search & Context | 18 |
| 13 | LLM Integration | 15 |
| 14 | Markdown Translation | 15 |
| 15 | HTML Translation | 8 |
| 16 | CLI Operations | 22 |
| 17 | Cross-Platform SDK Parity | 10 |
| 18 | Error Handling | 12 |
| 19 | Performance & Scale | 10 |
| 20 | Developer Experience | 10 |
| 21 | Industry Research | 10 |

### Multi-Platform Testing

Each test is implemented across:
- **Python** - `ucp-content` package
- **JavaScript** - `@ucp-core/core` package
- **Rust** - `ucp-api` crate
- **CLI** - `ucp-cli` commands

---

## Key Documentation

### UCP Components

| Component | Documentation | Description |
|-----------|--------------|-------------|
| ucm-core | `./ucp-docs/ucm-core/` | Core types (Block, Document, Content, Edge) |
| ucl-parser | `./ucp-docs/ucl-parser/` | Unified Content Language |
| ucp-agent | `./ucp-docs/ucp-agent/` | Agent traversal system |
| ucp-llm | `./ucp-docs/ucp-llm/` | LLM utilities |
| ucp-cli | `./ucp-docs/ucp-cli/` | Command-line interface |
| translators | `./ucp-docs/translators/` | Markdown/HTML conversion |

### Testing Resources

- `SUT-PACKET.md` - Mission brief with architecture and focus areas
- `SUT-CHECKLIST.md` - Complete test checklist
- `agent-resources/prompts/AGENT_SYSTEM_PROMPT.md` - Agent instructions
- `agent-resources/templates/FOLDER_STRUCTURE.md` - Output organization

---

## Reporting

Agents report findings in structured formats:

### Finding Types

1. **Bugs** - Incorrect behavior, crashes, data corruption
2. **Doc Gaps** - Missing, incorrect, or unclear documentation
3. **DX Issues** - Confusing APIs, poor error messages, boilerplate
4. **SDK Parity** - Behavioral differences between platforms
5. **Performance** - Slow operations, memory issues
6. **Enhancements** - Missing features, better abstractions
7. **Syntax Issues** - UCL syntax problems

### Output Locations

- Individual test reports: `runs/<tier>/<item>/FINAL_REPORT.md`
- Tier summaries: `runs/<tier>/<tier>-FINAL-REPORT.md`
- Test implementations: `runs/<tier>/<item>/tests/{python,javascript,rust,cli}/`
- Execution logs: `runs/<tier>/<item>/results/`

---

## CLI Commands

```bash
# Run tests
python -m processor.cli run [flags]

# Check status
python -m processor.cli status

# View history
python -m processor.cli history

# Dashboard view
python -m processor.cli dashboard

# Cancel running tests
python -m processor.cli cancel
```

### Run Flags

| Flag | Description |
|------|-------------|
| `--checklist PATH` | Path to checklist file |
| `--mission-brief PATH` | Path to mission brief |
| `--mode {finite,infinite}` | Processing mode |
| `--batch-size N` | Items to process in parallel |
| `--runtime {opencode,claude-code}` | Agent runtime |
| `--model SLUG` | Model to use |
| `--timeout MS` | Execution timeout |
| `--dry-run` | Preview without executing |
| `--verbose` | Enable debug logging |

---

## Success Criteria

| Metric | Target |
|--------|--------|
| API Coverage | 100% of documented APIs tested |
| Cross-Platform Parity | <5% behavioral differences |
| UCL Syntax Coverage | 100% of commands tested |
| Error Path Coverage | All documented error codes triggered |
| Performance Baseline | Document ops <100ms for 1K blocks |
| Translation Fidelity | >95% structural preservation |
| Documentation Accuracy | All examples verified working |

---

## Contributing

1. Update `SUT-PACKET.md` or `SUT-CHECKLIST.md` as needed
2. Ensure agent binaries run non-interactively
3. Run tests: `python -m processor.cli run`
4. Review findings in `runs/`
5. Submit PR with test results and recommendations

---

## Design Principles

1. **First Principles Testing** - Test what the tool *should* do, not just what it claims
2. **Multi-Platform** - Every test runs on all supported platforms
3. **Comprehensive** - Cover all APIs, edge cases, and error paths
4. **Observable** - Clear logging and structured reports
5. **Fail Fast** - Strict validation catches issues early
6. **Research-Backed** - Compare against industry alternatives

# Mission Brief: Unified Content Protocol (UCP)

## Overview

**Unified Content Protocol (UCP)** is a graph-based intermediate representation for structured content, designed for efficient manipulation by Large Language Models (LLMs). It provides a token-efficient, deterministic framework for representing and transforming structured documents across multiple platforms.

This testing mission approaches UCP from first principles: **What should a universal agentic content editing/navigating tool do?** Testers will exercise the protocol's capabilities against the ideal behaviors expected of such a tool, identifying gaps, bugs, documentation issues, and opportunities for enhancement.

## Context & Architecture

### Type
Multi-platform SDK + CLI for structured content manipulation (Rust core with JS/Python bindings)

### Key Interfaces

| Interface | Description | Access |
|-----------|-------------|--------|
| **Rust API** (`ucp-api`) | High-level client for Rust applications | `cargo add ucp-api` |
| **Python SDK** (`ucp-content`) | Python bindings with native types | `pip install ucp-content` |
| **JavaScript SDK** (`@ucp-core/core`) | ESM package for Node/browser | `npm install @ucp-core/core` |
| **CLI** (`ucp-cli`) | Command-line interface for automation | `cargo install ucp-cli` |
| **UCL** | Unified Content Language - token-efficient DSL | Integrated in all SDKs |

### Architecture Stack

```
+------------------------------------------------------------------+
|                         ucp-cli                                   |
|        (Command-line interface & automation tooling)              |
+------------------------------------------------------------------+
|                         ucp-api                                   |
|              (High-level API for applications)                    |
+------------------------------------------------------------------+
|     ucl-parser          |         ucm-engine                      |
|  (Command Language)     |    (Transformation Engine)              |
+------------------------------------------------------------------+
|                         ucm-core                                  |
|         (Core Types: Block, Document, Content, Edge)              |
+------------------------------------------------------------------+
| ucp-translator-markdown / ucp-translator-html |    ucp-observe    |
|             (Format Translators)              | (Observability)   |
+------------------------------------------------------------------+
|          ucp-llm            |          ucp-agent                  |
|    (LLM Utilities)          |   (Agent Traversal System)          |
+------------------------------------------------------------------+
```

### Core Concepts

1. **Blocks** - Fundamental content units with content-addressed IDs (96-bit)
   - Content types: Text, Code, Table, Math, Media, JSON, Binary, Composite
   - Metadata: semantic roles, labels, tags, summaries, token estimates
   - Lifecycle states: Live, Orphaned, Deleted

2. **Documents** - DAG collections of blocks with hierarchical structure
   - Adjacency map (parent-child relationships)
   - Secondary indices (by tag, role, content type, label)
   - Edge index for relationship traversal
   - Validation and token estimation

3. **Edges** - Explicit semantic relationships between blocks
   - Derivation: DerivedFrom, Supersedes, TransformedFrom
   - Reference: References, CitedBy, LinksTo
   - Semantic: Supports, Contradicts, Elaborates, Summarizes
   - Version: VersionOf, AlternativeOf, TranslationOf

4. **UCL (Unified Content Language)** - Token-efficient command DSL
   - Commands: EDIT, APPEND, MOVE, DELETE, PRUNE, FOLD, LINK, UNLINK
   - Transactions: BEGIN, COMMIT, ROLLBACK, ATOMIC
   - Snapshots: CREATE, RESTORE, LIST, DELETE, DIFF

5. **Agent Traversal** - Graph navigation for AI agents
   - Navigation: GOTO, BACK, EXPAND, FOLLOW, PATH
   - Search: SEARCH (semantic), FIND (pattern)
   - Context: CTX ADD/REMOVE/CLEAR/EXPAND/COMPRESS/PRUNE/RENDER/STATS/FOCUS

### Constraints

- Block IDs are deterministic and content-addressed
- Document structure is a DAG (no cycles allowed)
- UCL syntax is strict (specific ordering of parameters)
- Context commands emit events but don't maintain state (host manages context)
- Cross-platform APIs have slight naming convention differences (snake_case vs camelCase)

## Documentation & References

Documentation is provided in `./ucp-docs/` directory:

- [Index](./ucp-docs/index.md) - Documentation entry point
- [Getting Started](./ucp-docs/getting-started/) - Installation and quick start guides
- [UCM Core](./ucp-docs/ucm-core/) - Block, Document, Content, Edge APIs
- [UCL Parser](./ucp-docs/ucl-parser/) - Command language reference
- [UCP Agent](./ucp-docs/ucp-agent/) - Agent traversal system
- [UCP CLI](./ucp-docs/ucp-cli/) - CLI reference
- [UCP LLM](./ucp-docs/ucp-llm/) - LLM utilities
- [Translators](./ucp-docs/translators/) - Markdown/HTML conversion
- [Examples](./ucp-docs/examples/) - Basic, intermediate, advanced examples

StageFlow documentation (for building test pipelines) in `./stageflow-docs/`.

## Focus Areas & Risks

### 1. Cross-Platform SDK Parity
- **Risk**: APIs may behave differently across Rust/Python/JavaScript
- **Focus**: Test identical operations produce identical results
- **Impact**: High - inconsistent behavior breaks multi-platform workflows

### 2. UCL Syntax Correctness
- **Risk**: Parser may reject valid syntax or accept invalid syntax
- **Focus**: Exhaustive command syntax testing, edge cases, error messages
- **Impact**: High - UCL is the primary interface for LLM agents

### 3. Agent Traversal Reliability
- **Risk**: Navigation commands may fail silently or produce unexpected results
- **Focus**: Session management, cursor positioning, context events
- **Impact**: High - agent workflows depend on reliable traversal

### 4. Document Integrity
- **Risk**: Operations may leave documents in invalid states
- **Focus**: Validation after mutations, orphan detection, cycle prevention
- **Impact**: Critical - data corruption is unacceptable

### 5. Performance at Scale
- **Risk**: Large documents may cause performance degradation
- **Focus**: Block counts >10K, deep hierarchies, token estimation accuracy
- **Impact**: Medium - limits practical applicability

### 6. Translation Fidelity
- **Risk**: Markdown/HTML round-trips may lose content or structure
- **Focus**: Complex documents, edge cases, semantic preservation
- **Impact**: Medium - affects content import/export workflows

### 7. LLM Integration Correctness
- **Risk**: IdMapper/PromptBuilder may produce invalid or suboptimal output
- **Focus**: Short ID mapping, UCL expansion, capability prompts
- **Impact**: High - affects agent instruction quality

### 8. Error Messages & DX
- **Risk**: Error messages may be unhelpful or misleading
- **Focus**: All error paths, suggestions, recovery options
- **Impact**: Medium - affects developer adoption

## Automation Objectives

### Phase 1: SDK Verification
- Verify all documented APIs work as specified
- Test each content type, edge type, and command
- Compare behavior across all three SDKs
- Document any discrepancies or undocumented behaviors

### Phase 2: Agent Workflow Testing
- Build realistic agent workflows using ucp-agent
- Test navigation, search, and context management patterns
- Verify session isolation and cleanup
- Stress-test with concurrent sessions

### Phase 3: Integration Scenarios
- Import complex Markdown/HTML documents
- Transform and export back
- Verify round-trip fidelity
- Test with real-world content structures

### Phase 4: Edge Cases & Stress
- Push scale limits (block counts, hierarchy depth)
- Test error recovery and graceful degradation
- Verify resource cleanup and memory behavior
- Document performance characteristics

## Access & Configuration

### Installation Commands

```bash
# Rust CLI
cargo install ucp-cli

# Python SDK
pip install ucp-content

# JavaScript SDK
npm install @ucp-core/core
```

### Verification Commands

```bash
# CLI
ucp --version
ucp --help

# Python
python -c "from ucp_content import Document; print(Document.create().id)"

# JavaScript
node -e "const {Document}=require('@ucp-core/core'); console.log(Document.create().id)"
```

### Test Implementation Requirements

For each test item, implementations should be created in:
1. **Python** (`tests/python/`)
2. **JavaScript** (`tests/javascript/`)
3. **Rust** (`tests/rust/`)
4. **CLI** (`tests/cli/`) - shell scripts using `ucp` commands

Each implementation should:
- Produce consistent results across platforms
- Log clear success/failure indicators
- Capture timing and resource usage
- Report any discrepancies between platforms

## Success Criteria

| Metric | Target |
|--------|--------|
| API Coverage | 100% of documented APIs tested |
| Cross-Platform Parity | <5% behavioral differences |
| UCL Syntax Coverage | 100% of commands with all parameter combinations |
| Error Path Coverage | All documented error codes triggered |
| Performance Baseline | Document ops complete in <100ms for 1K blocks |
| Translation Fidelity | >95% structural preservation in round-trips |
| Documentation Accuracy | All examples verified working |

## Reporting Focus

Testers should document:

1. **Bugs** - Incorrect behavior, crashes, data corruption
2. **Doc Gaps** - Missing, incorrect, or unclear documentation
3. **DX Issues** - Confusing APIs, poor error messages, boilerplate
4. **SDK Parity Issues** - Behavioral differences between platforms
5. **Performance Concerns** - Slow operations, memory issues
6. **Enhancement Ideas** - Missing features, better abstractions
7. **Syntax Feedback** - UCL syntax power and elegance assessment

## Industry Research Context

As part of comprehensive testing, research these competing/related systems:

- **ProseMirror** - Collaborative rich-text editing
- **Notion API** - Block-based content management
- **Roam Research** - Bidirectional linking
- **Obsidian** - Graph-based note-taking
- **Slate.js** - Rich text framework
- **CRDT Systems** (Yjs, Automerge) - Conflict-free collaboration
- **Apache Arrow** - Columnar data representation

For each, document: How do they model content? What can UCP learn from them?

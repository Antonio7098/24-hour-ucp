# 24h Testers UCP Folder Structure

> **Purpose**: Standardized folder structure for UCP testing agent runs.

---

## Root Structure

```
24h-ucp-testers/
├── SUT-PACKET.md               # UCP mission brief and architecture
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
├── tests/                      # Shared test templates
│   ├── python/
│   ├── javascript/
│   ├── rust/
│   └── cli/
├── runs/                       # All agent runs organized by Tier
│   ├── tier_1_installation_setup/
│   │   ├── SET-001/
│   │   │   ├── FINAL_REPORT.md
│   │   │   ├── research/
│   │   │   ├── tests/
│   │   │   │   ├── python/
│   │   │   │   ├── javascript/
│   │   │   │   ├── rust/
│   │   │   │   └── cli/
│   │   │   └── results/
│   │   └── tier_1_installation_setup-FINAL-REPORT.md
│   └── ...
├── .processor/                 # Processor state
└── README.md
```

---

## Individual Run Structure

Each run folder (`runs/{TIER_NAME}/{ENTRY_ID}/`) follows this structure:

```
runs/{TIER_NAME}/{ENTRY_ID}/
│
├── FINAL_REPORT.md              # Human-readable final report (required)
│
├── research/                    # Phase 1: Understanding
│   └── understanding.md         # Notes on what is being tested
│
├── tests/                       # Phase 2: Multi-platform implementations
│   ├── python/
│   │   └── test_{entry_id}.py
│   ├── javascript/
│   │   └── test_{entry_id}.js
│   ├── rust/
│   │   └── test_{entry_id}.rs
│   └── cli/
│       └── test_{entry_id}.sh
│
├── results/                     # Phase 3: Execution results
│   ├── python_output.log
│   ├── javascript_output.log
│   ├── rust_output.log
│   ├── cli_output.log
│   └── comparison.md           # Cross-platform comparison
│
└── agent-log.txt               # Raw agent execution log
```

---

## Test File Templates

### Python (`test_{entry_id}.py`)

```python
#!/usr/bin/env python3
"""
Test: {ENTRY_ID} - {ENTRY_TITLE}
Platform: Python
"""
import sys
import time
from ucp_content import Document, Content, execute_ucl

def main():
    start = time.time()

    try:
        # Test implementation
        doc = Document.create()
        # ... test code ...

        print(f"PASS: {entry_title}")
        return 0
    except Exception as e:
        print(f"FAIL: {entry_title}")
        print(f"Error: {e}")
        return 1
    finally:
        elapsed = time.time() - start
        print(f"Duration: {elapsed:.3f}s")

if __name__ == "__main__":
    sys.exit(main())
```

### JavaScript (`test_{entry_id}.js`)

```javascript
#!/usr/bin/env node
/**
 * Test: {ENTRY_ID} - {ENTRY_TITLE}
 * Platform: JavaScript
 */
import { Document, Content, executeUcl } from 'ucp-content/dist/js';

async function main() {
    const start = Date.now();

    try {
        // Test implementation
        const doc = Document.create();
        // ... test code ...

        console.log(`PASS: ${entryTitle}`);
        return 0;
    } catch (e) {
        console.log(`FAIL: ${entryTitle}`);
        console.log(`Error: ${e.message}`);
        return 1;
    } finally {
        const elapsed = (Date.now() - start) / 1000;
        console.log(`Duration: ${elapsed.toFixed(3)}s`);
    }
}

main().then(process.exit);
```

### Rust (`test_{entry_id}.rs`)

```rust
//! Test: {ENTRY_ID} - {ENTRY_TITLE}
//! Platform: Rust

use std::time::Instant;
use ucp_api::UcpClient;
use ucm_core::{Document, Content, Block};

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let start = Instant::now();

    // Test implementation
    let client = UcpClient::new();
    let mut doc = client.create_document();
    // ... test code ...

    let elapsed = start.elapsed();
    println!("PASS: {entry_title}");
    println!("Duration: {:.3}s", elapsed.as_secs_f64());

    Ok(())
}
```

### CLI (`test_{entry_id}.sh`)

```bash
#!/bin/bash
# Test: {ENTRY_ID} - {ENTRY_TITLE}
# Platform: CLI

set -e
ENTRY_ID="{ENTRY_ID}"
ENTRY_TITLE="{ENTRY_TITLE}"

start_time=$(date +%s.%N)

# Test implementation
ucp create --title "Test Document" --output /tmp/test.json
# ... test commands ...

end_time=$(date +%s.%N)
duration=$(echo "$end_time - $start_time" | bc)

echo "PASS: $ENTRY_TITLE"
echo "Duration: ${duration}s"
```

---

## Tier Naming Conventions

| Checklist Header | Folder Name |
|------------------|-------------|
| Tier 1: Installation & Setup | `tier_1_installation_setup` |
| Tier 2: Document Lifecycle | `tier_2_document_lifecycle` |
| Tier 3: Block Content Types | `tier_3_block_content_types` |
| ... | ... |

---

## Required vs Optional Files

### Required (every run must have)
- `FINAL_REPORT.md`
- At least one test implementation

### Required if applicable
- `research/understanding.md` - For non-trivial tests
- `results/comparison.md` - If cross-platform differences found
- Platform-specific tests as appropriate

---

## Naming Conventions

- Test files: `test_{entry_id}.{ext}` (lowercase entry ID)
- Output logs: `{platform}_output.log`
- Entry IDs match checklist: `SET-001`, `DOC-001`, `BLK-001`, etc.

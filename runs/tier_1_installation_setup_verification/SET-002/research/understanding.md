# SET-002: Understanding Document

## Test Objective
Verify `ucp --version` returns a valid version string across all UCP interfaces (CLI, Python SDK, JavaScript SDK).

## Scope
- CLI version command behavior
- Version string format validation
- Exit code verification
- Cross-platform version parity

## UCP Interfaces Tested

### 1. CLI (ucp-cli)
- Location: `/home/antonio/.cargo/bin/ucp`
- Command: `ucp --version`
- Current output: `ucp 0.1.10`

### 2. Python SDK (ucp-content package)
- Import: `import ucp`
- Attribute: `ucp.__version__`
- Current version: `0.1.9` (from package metadata)

### 3. JavaScript SDK (ucp-content WASM)
- Import: `require('ucp-content')`
- Function: `ucp.version()`
- Current version: `0.1.10`

### 4. Rust (ucp-api if installed)
- Not tested separately (CLI is Rust-based)

## Version String Validation Criteria
A valid version string should:
1. Follow semantic versioning (MAJOR.MINOR.PATCH)
2. Not be empty
3. Not contain whitespace or special characters (except `-` for pre-release)

## Potential Findings
1. **Version Parity Issue**: Python SDK shows `0.1.9` while CLI and JS SDK show `0.1.10`
2. **Version Format Differences**:
   - CLI returns: `ucp 0.1.10` (with "ucp" prefix)
   - Python returns: `0.1.9` (just version number)
   - JS returns: `0.1.10` (just version number)

## Success Criteria
1. `ucp --version` returns exit code 0
2. Output contains version string matching semver format (e.g., "0.1.10")
3. Output is parseable and consistent
4. Python SDK returns valid semver
5. JavaScript SDK returns valid semver
6. Version parity across platforms (within minor version)

## Implementation Plan

### Python
```python
import ucp
version = ucp.__version__
# Validate semver format
```

### JavaScript
```javascript
const ucp = require('ucp-content');
const version = ucp.version();
// Validate semver format
```

### CLI
```bash
ucp --version | grep -E "ucp [0-9]+\.[0-9]+\.[0-9]+"
```

### Rust
```rust
use std::process::Command;
let output = Command::new("ucp").arg("--version").output()?;
```

# SET-006-FINAL-REPORT: Verify `npm install @ucp-core/core` completes successfully

## Executive Summary

**RESULT**: FAIL

The package `@ucp-core/core` does not exist in the npm registry. The installation test cannot be completed as specified because the target package is not available for installation.

## Test Results

| Platform | Status | Details |
|----------|--------|---------|
| npm registry | FAIL | Package `@ucp-core/core` returns 404 Not Found |
| Python | N/A | Test not applicable (npm package) |
| Rust | N/A | Test not applicable (npm package) |
| CLI | N/A | Test not applicable (npm package) |

## Findings

### BUG-006-001: Non-existent Package Reference

**Severity**: High
**Component**: Documentation
**Platform**: All

**Description**: The test specification references a non-existent npm package `@ucp-core/core`.

**Expected**: The package should exist in the npm registry and install successfully.

**Actual**: The package returns a 404 Not Found error.

**Reproduction**:
```bash
npm install @ucp-core/core
# Result: npm error 404 Not Found - GET https://registry.npmjs.org/@ucp-core%2fcore
```

**Evidence**:
```
npm error code E404
npm error 404 Not Found - GET https://registry.npmjs.org/@ucp-core%2fcore - Not found
npm error 404 '@ucp-core/core@*' is not in this registry.
```

### Documentation Inconsistency

The mission brief states:
> **JavaScript SDK** (`@ucp-core/core`) - ESM package for Node/browser - `npm install @ucp-core/core`

However, the same document also states:
> **Note**: The JavaScript/TypeScript SDK is included with `ucp-content` and is available at `node_modules/ucp-content/dist/js/` after installation. No separate npm package required.

These two statements are contradictory.

### Available Alternatives

The following UCP-related npm packages exist:

| Package Name | Description | Status |
|-------------|-------------|--------|
| `ucp-content` | WebAssembly bindings for UCP | Installed (v0.1.10) |
| `@ucp-js/sdk` | UCP SDK for JavaScript | Installed (v0.1.0) |
| `ucp` | Experimental Transport Protocol | Installed (v0.0.0) |

## Recommendations

1. **Update Documentation**: Either remove `@ucp-core/core` from the documentation or update it to reference the correct package name
2. **Publish Package**: If `@ucp-core/core` is intended to be the primary package, publish it to npm
3. **Use Alternative**: If `ucp-content` is the intended package, update the test to use that instead

## Evidence Links

- Research notes: [runs/tier_1_installation_setup_verification/SET-006/research/understanding.md](runs/tier_1_installation_setup_verification/SET-006/research/understanding.md)
- npm registry search results
- Local package installation status

## Conclusion

The test as specified cannot pass because the target package `@ucp-core/core` does not exist in the npm registry. This is a documentation/package naming issue that needs to be resolved before the test can be executed as intended.

---

**Report Generated**: 2026-02-03
**Tester**: 24h Testers UCP Reliability Agent
**Test Entry**: SET-006

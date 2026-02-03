# SET-007 Final Report: Verify JS `import { Document } from '@ucp-core/core'` works

**Entry ID:** SET-007
**Priority:** P0
**Risk Class:** High
**Date:** 2026-02-03
**Tester:** 24h Testers UCP Reliability Agent

---

## Executive Summary

**RESULT: FAIL** - The documented JavaScript import `import { Document } from '@ucp-core/core'` does not work. The package `@ucp-core/core` does not exist in the npm registry.

**Finding:** Documentation references a non-existent npm package. The actual working JavaScript SDK is `ucp-content` which provides WebAssembly bindings for UCP.

---

## Test Results Summary

| Platform | Import Statement | Status | Notes |
|----------|-----------------|--------|-------|
| JavaScript | `import { Document } from '@ucp-core/core'` | FAIL | Package does not exist in npm |
| JavaScript | `const { Document } = require('ucp-content')` | PASS | Working alternative |
| Python | `from ucp_content import Document` | PASS | Fully functional |
| Rust | N/A | PENDING | Not tested |
| CLI | N/A | PENDING | Not tested |

---

## Detailed Findings

### JS-001: Package Non-Existence

**Severity:** High
**Component:** Documentation / npm Publishing
**Platform:** JavaScript

**Description:** The documented package `@ucp-core/core` does not exist in the npm registry.

**Evidence:**
```
$ npm install @ucp-core/core
404 Not Found - @ucp-core/core@* is not in this registry
```

**Reproduction:**
```javascript
// This will fail
try {
  require('@ucp-core/core');
  console.log('SUCCESS');
} catch (e) {
  console.log('FAIL:', e.message);
  // Output: Cannot find module '@ucp-core/core'
}
```

**Impact:** Developers following the documentation will be unable to use the JavaScript SDK.

---

### JS-002: Alternative Package Available

**Finding:** The `ucp-content` package is installed and provides working UCP functionality.

**Package Details:**
- **Name:** `ucp-content`
- **Version:** `0.1.10`
- **Type:** WebAssembly bindings
- **Repository:** https://github.com/Antonio7098/unified-content-protocol

**Available Exports (38 total):**
- Core: `Content`, `ContentType`, `Document`, `EdgeType`
- LLM Utilities: `IdMapper`, `PromptBuilder`, `PromptPresets`
- Engine: `WasmEngine`, `WasmTraversalEngine`, `WasmValidationPipeline`
- Functions: `createDocument`, `executeUcl`, `parseMarkdown`, `renderMarkdown`, `parseHtml`

**Working Import:**
```javascript
const { Document, Content, createDocument, executeUcl } = require('ucp-content');

// Create a document
const doc = createDocument('Test Document');

// Execute UCL commands
executeUcl(doc, 'APPEND :: paragraph :: "Hello World"');
```

---

### JS-003: TypeScript SDK Incomplete

**Finding:** `@ucp-js/sdk` is installed but lacks built distribution files.

**Package Details:**
- **Name:** `@ucp-js/sdk`
- **Version:** `0.1.0`
- **Status:** Requires build step
- **Repository:** https://github.com/Universal-Commerce-Protocol/js-sdk

**Issue:**
- `dist/` directory not present
- `npm run build` required before use
- Only provides TypeScript types and Zod schemas

---

## Python SDK Test Results

**Status:** PASS

The Python SDK works correctly with the documented import:

```python
from ucp import Document, Content, execute_ucl

# Create document
doc = Document.create("Test Document")

# Create content
text_content = Content.text("Hello from Python")

# Execute UCL
execute_ucl(doc, 'APPEND :: paragraph :: "Hello World"')
```

**Findings:**
- ✓ Package imports successfully
- ✓ Document class available
- ✓ Content class available
- ✓ execute_ucl function available
- ✓ Document.create() functional
- ✓ Content.text() functional

---

## SDK Comparison Matrix

| Feature | JavaScript (@ucp-core/core) | JavaScript (ucp-content) | Python |
|---------|---------------------------|-------------------------|--------|
| Package Name | NOT FOUND | ucp-content | ucp |
| Document.create() | N/A | ✓ | ✓ |
| Content class | N/A | ✓ | ✓ |
| executeUcl/execute_ucl | N/A | ✓ | ✓ |
| parseMarkdown | N/A | ✓ | ✓ |
| renderMarkdown | N/A | ✓ | ✓ |
| TypeScript types | N/A | Partial (@ucp-js/sdk) | N/A |

---

## Recommendations

### Immediate Actions

1. **Publish `@ucp-core/core` to npm** - Either publish the missing package or redirect the name to `ucp-content`

2. **Update Documentation** - Change all references from `@ucp-core/core` to `ucp-content`:
   ```
   npm install ucp-content
   const { Document } = require('ucp-content');
   ```

3. **Build `@ucp-js/sdk`** - Run `npm run build` in the SDK package or remove if redundant

### Documentation Fixes Needed

| File | Current | Should Be |
|------|---------|-----------|
| ucp-docs/ucm-core/javascript.md | `import { Document } from '@ucp-core/core'` | `import { Document } from 'ucp-content'` |
| README.md | `npm install @ucp-core/core` | `npm install ucp-content` |
| Getting Started | Reference to non-existent package | Update to use ucp-content |

---

## Evidence Links

- Test results: `results/js_test_results.json`
- Correct API test: `results/js_correct_api_results.json`
- Alternatives analysis: `results/js_alternatives_results.json`
- Python test: `results/python_test_results.json`
- Research notes: `research/understanding.md`

---

## Conclusion

The documented JavaScript import for UCP is broken. The package `@ucp-core/core` does not exist in npm. Developers should use `ucp-content` as the working alternative until the documentation is updated or the missing package is published.

**Priority:** This is a P0 issue as it blocks JavaScript SDK adoption.

**Recommended Fix Timeframe:** Immediate - documentation update or package publication required before any JavaScript developers can use UCP.

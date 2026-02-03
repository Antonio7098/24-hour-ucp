# SET-007 Research: Verify JS `import { Document } from '@ucp-core/core'` works

## Objective
Verify that the JavaScript import `import { Document } from '@ucp-core/core'` works correctly.

## Understanding

### Expected Behavior
According to `ucp-docs/ucp-js/README.md`, the JavaScript SDK should be available as `@ucp-core/core`:
- Installation: `npm install @ucp-core/core@0.1.9`
- Import: `import { createDocument, addBlock, executeUcl } from '@ucp-core/core';`
- Package description: Pure ESM with TypeScript definitions, no WASM required

### Actual State

#### Installed Packages
The project has these UCP-related packages installed:
1. `ucp-content@0.1.10` - WebAssembly bindings for UCP
2. `@ucp-js/sdk@0.1.0` - TypeScript types and Zod schemas only
3. `ucp@0.0.0` - Experimental transport protocol (unrelated)

#### Package Analysis

**`@ucp-core/core` Package Status:**
- **NOT INSTALLED** - The package name referenced in documentation does not exist in npm registry
- Installation attempt failed: `npm install @ucp-core/core`
- Error: `404 Not Found - @ucp-core/core@* is not in this registry`

**Current Available JavaScript SDK:**
- `@ucp-js/sdk` provides TypeScript types and Zod schemas only
- No runtime implementation (no `dist/` directory built)
- Requires building with `npm run build` to generate runtime code

**Alternative Runtime:**
- `ucp-content` provides actual WebAssembly bindings
- Exports: `Content`, `Document`, `Block` classes (via `ucp_wasm.js`)
- Entry point: `require('ucp-content')` or `import from 'ucp-content'`

## Discrepancy Found

| Aspect | Documentation Says | Actual State |
|--------|-------------------|--------------|
| Package Name | `@ucp-core/core` | Not available in npm |
| Installation | `npm install @ucp-core/core@0.1.9` | 404 Not Found |
| SDK Type | Pure ESM, TypeScript | Only types, no runtime |
| Implementation | Native JS/TS | WASM only via ucp-content |

## Root Cause
Documentation references a package (`@ucp-core/core`) that either:
1. Was never published to npm
2. Was renamed/removed
3. Is only available in a private/organizational registry

## Available Alternatives
1. **For runtime**: Use `ucp-content` (WASM bindings)
   ```javascript
   const { Document, Content, Block } = require('ucp-content');
   ```
2. **For types**: Use `@ucp-js/sdk` (requires build)
   ```javascript
   // Must build @ucp-js/sdk first
   import { Document } from '@ucp-js/sdk/dist/esm';
   ```

## Success Criteria

### PASS Conditions
- `@ucp-core/core` package is installable from npm
- `import { Document } from '@ucp-core/core'` executes without errors
- `Document.create()` method is available and functional

### FAIL Conditions (Current State)
- Package not found in npm registry
- Alternative packages exist but don't match documented import path

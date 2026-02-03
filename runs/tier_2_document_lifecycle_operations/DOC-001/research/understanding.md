# DOC-001: Create Empty Document and Verify Root Block Exists

## Test Objective
Verify that creating a new UCP document automatically creates a root block and that this root block is accessible and has expected properties.

## Expected Behavior
1. `Document.create()` should create a document with exactly 1 block (the root)
2. The root block should be accessible via `doc.root_id` (Python/JS) or `doc.root` (Rust)
3. The root block should be of a special type (root block)
4. Block count should be exactly 1
5. The root block should have no parent (or parent is itself)
6. The document should be valid (no validation errors)

## Platform-Specific APIs

### Python
```python
from ucp_content import Document
doc = Document.create()
root = doc.root_id
block = doc.get_block(root)
assert block.is_root()
assert doc.block_count() == 1
```

### JavaScript
```javascript
import { Document } from 'ucp-content';
const doc = Document.create("Test Doc");
const root = doc.rootId;
const block = doc.getBlock(root);
assert(block.id === doc.rootId);
assert(doc.blockCount() === 1);
```

### CLI
```bash
ucp create --title "Test Doc" --output /tmp/doc.json
ucp info /tmp/doc.json --json | jq '.blockCount'
```

### Rust (if needed)
```rust
let doc = Document::create();
assert_eq!(doc.block_count(), 1);
let root = doc.root.clone();
assert!(root.is_root());
```

## Success Criteria
- All platforms create a document with exactly 1 block
- Root block is accessible and has expected properties
- No errors during creation
- Results are consistent across platforms

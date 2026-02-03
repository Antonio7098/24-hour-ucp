# SET-008: Understanding Document

## Test Objective
Verify that the Rust `ucp-api` crate compiles with basic usage. This is a fundamental installation and compilation test that ensures the Rust SDK is accessible and functional.

## Scope
- Test `ucp-api` crate installation via Cargo
- Verify basic API usage matches documentation
- Test document creation, content addition, UCL execution, and serialization
- Compare behavior with Python and JavaScript SDKs

## UCP API Overview
From the documentation, `ucp-api` provides:
- `UcpClient` - Main client for document manipulation
- Document operations: `create_document()`, `to_json()`
- Content addition: `add_text()`, `add_code()`
- UCL execution: `execute_ucl()`, `parse_ucl()`

## Expected API (from docs)
```rust
use ucp_api::UcpClient;

let client = UcpClient::new();
let mut doc = client.create_document();
let root = doc.root.clone();
client.add_text(&mut doc, &root, "Hello, UCP!", Some("intro")).unwrap();
client.execute_ucl(&mut doc, r#"APPEND blk_root text :: "More content"#).unwrap();
let json = client.to_json(&doc).unwrap();
```

## Success Criteria
1. `ucp-api` crate downloads and compiles successfully
2. Basic operations (create document, add content, execute UCL) work as documented
3. Output matches expected JSON format
4. Error handling works correctly for invalid inputs

## Cross-Platform Test Alignment
- Python: Test same operations via `ucp_content` SDK
- JavaScript: Test same operations via `ucp-content` npm package
- All platforms should produce consistent results for same operations

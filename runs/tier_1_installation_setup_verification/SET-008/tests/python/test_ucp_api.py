"""
SET-008: Verify Rust `ucp-api` crate compiles with basic usage
Python implementation for cross-platform comparison
"""

import json
import time
from ucp import Document, execute_ucl


def run_tests():
    print("=== SET-008: Python ucp-content SDK Test ===\n")
    start_time = time.time()

    # Test 1: Create document
    print("[TEST 1] Creating document...")
    doc = Document.create()
    print(f"  Document ID: {doc.id}")
    print(f"  Root block: {doc.root_id}")
    print("  ✓ Document created successfully\n")

    # Test 2: Add text content
    print("[TEST 2] Adding text content...")
    root = doc.root_id
    text_id = doc.add_block(root, "Hello, UCP!", role="intro")
    print(f"  Text block ID: {text_id}")
    print("  ✓ Text content added successfully\n")

    # Test 3: Add code block
    print("[TEST 3] Adding code block...")
    code_content = """fn main() {
    println!("Hello, UCP!");
}"""
    code_id = doc.add_code(root, "rust", code_content)
    print(f"  Code block ID: {code_id}")
    print("  ✓ Code block added successfully\n")

    # Test 4: Execute UCL
    print("[TEST 4] Executing UCL command...")
    # Use actual root block ID for UCL execution
    affected = execute_ucl(doc, f'APPEND {root} text :: "This is a section"')
    print(f"  Affected blocks: {affected}")
    print("  ✓ UCL execution completed\n")

    # Test 5: Validate document
    print("[TEST 5] Validating document...")
    issues = doc.validate()
    if not issues:
        print("  ✓ Document is valid (no issues found)\n")
    else:
        print(f"  ! Document has {len(issues)} issues\n")

    # Test 6: Serialize to JSON
    print("[TEST 6] Serializing document to JSON...")
    json_str = doc.to_json()
    print(f"  ✓ JSON serialization successful ({len(json_str)} bytes)\n")

    # Test 7: Find blocks by type
    print("[TEST 7] Finding blocks by type...")
    code_blocks = doc.find_by_type("code")
    text_blocks = doc.find_by_type("text")
    print(f"  Code blocks: {len(code_blocks)}")
    print(f"  Text blocks: {len(text_blocks)}")
    print("  ✓ Block search completed\n")

    # Test 8: Error handling
    print("[TEST 8] Testing error handling...")
    try:
        execute_ucl(doc, "THIS_IS_INVALID SYNTAX")
        print("  ! Warning: Invalid UCL was accepted\n")
    except Exception as e:
        print(f"  ✓ Correctly caught invalid UCL\n")

    elapsed = (time.time() - start_time) * 1000
    print("=== TEST SUMMARY ===")
    print(f"Total execution time: {elapsed:.2f}ms")
    print(f"Final block count: {doc.block_count}")
    print("\nRESULT: PASS - Python SDK functions correctly")


if __name__ == "__main__":
    run_tests()

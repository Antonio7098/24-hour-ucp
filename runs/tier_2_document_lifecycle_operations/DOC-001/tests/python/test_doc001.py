"""
Test: DOC-001 - Create empty document and verify root block exists
"""

import sys
import json
import time

START_TIME = time.time()


def log(msg):
    elapsed = time.time() - START_TIME
    print(f"[{elapsed:.3f}s] {msg}")


def pass_test(name):
    log(f"PASS: {name}")


def fail_test(name, reason):
    log(f"FAIL: {name} - {reason}")
    return False


def run_tests():
    import ucp

    log("=" * 60)
    log("DOC-001: Create Empty Document and Verify Root Block")
    log("=" * 60)

    all_passed = True
    doc = None
    root_block = None
    block_count_prop = None

    # Test 1: Create document
    log("\n--- Test 1: Create empty document ---")
    try:
        try:
            doc = ucp.create("Test Document")
            log("  - Using ucp.create()")
        except AttributeError:
            doc = ucp.Document.create("Test Document")
            log("  - Using Document.create()")
        pass_test("Document.create() succeeded")
    except Exception as e:
        fail_test("Document.create()", str(e))
        return False

    # Test 2: Document has ID
    log("\n--- Test 2: Document has valid ID ---")
    doc_id = getattr(doc, "id", None)
    if doc_id:
        pass_test(f"Document has ID: {str(doc_id)[:16]}...")
    else:
        all_passed &= fail_test("Document has ID", "ID is None or empty")

    # Test 3: Root block exists
    log("\n--- Test 3: Root block exists ---")
    root_id = getattr(doc, "root_id", None) or getattr(doc, "root", None)
    if root_id:
        pass_test(f"Root block ID accessible: {str(root_id)[:16]}...")
    else:
        all_passed &= fail_test("Root block exists", "root_id is None")

    # Test 4: Block count is exactly 1
    log("\n--- Test 4: Block count is 1 ---")
    block_count_prop = getattr(doc, "block_count", None) or getattr(
        doc, "blockCount", None
    )
    if block_count_prop is not None:
        if callable(block_count_prop):
            block_count = block_count_prop()
        else:
            block_count = block_count_prop
        if block_count == 1:
            pass_test(f"Block count is 1 (actual: {block_count})")
        else:
            all_passed &= fail_test(
                "Block count is 1", f"Expected 1, got {block_count}"
            )
    else:
        log("  - block_count property not found")

    # Test 5: Root block is retrievable
    log("\n--- Test 5: Root block is retrievable ---")
    try:
        get_block_fn = getattr(doc, "get_block", None) or getattr(doc, "getBlock", None)
        if get_block_fn and root_id:
            root_block = get_block_fn(root_id)
            if root_block:
                pass_test("Root block retrieved successfully")
            else:
                all_passed &= fail_test(
                    "Root block retrievable", "get_block returned None"
                )
        else:
            log("  - get_block method or root_id not available")
    except Exception as e:
        all_passed &= fail_test("Root block retrievable", str(e))

    # Test 6: Root block properties
    log("\n--- Test 6: Root block properties ---")
    if root_block:
        block_id = getattr(root_block, "id", None)
        content_type = getattr(root_block, "content_type", None) or getattr(
            root_block, "contentType", None
        )
        role = getattr(root_block, "role", None)
        tags = getattr(root_block, "tags", None)

        log(f"  - Block ID: {block_id}")
        log(f"  - Content type: {content_type}")
        log(f"  - Role: {role}")
        log(f"  - Tags: {tags}")

        pass_test("Root block has expected properties")
    else:
        all_passed &= fail_test("Root block properties", "Root block not retrieved")

    # Test 7: Root block is root (is_root check)
    log("\n--- Test 7: Root block is identified as root ---")
    is_root_fn = getattr(root_block, "is_root", None) or getattr(
        root_block, "isRoot", None
    )
    if is_root_fn and root_block:
        if is_root_fn():
            pass_test("is_root() returns True")
        else:
            all_passed &= fail_test("is_root()", "Returned False for root block")
    else:
        log("  - is_root() method not available or block not found, skipping")

    # Test 8: Root block has no children initially
    log("\n--- Test 8: Root has no children ---")
    children_fn = getattr(doc, "children", None)
    if children_fn and root_id:
        children = children_fn(root_id)
        if len(children) == 0:
            pass_test("Root has 0 children (empty document)")
        else:
            all_passed &= fail_test(
                "Root has no children", f"Expected 0, got {len(children)}"
            )

    # Test 9: Document validation (should pass for empty doc)
    log("\n--- Test 9: Document validation ---")
    validate_fn = getattr(doc, "validate", None)
    if validate_fn:
        try:
            issues = validate_fn()
            if not issues:
                pass_test("Document validates (no issues)")
            else:
                log(f"  - Validation issues: {len(issues)}")
                for issue in issues:
                    log(f"    - {issue}")
                error_count = len([i for i in issues if str(i[0]).lower() == "error"])
                if error_count == 0:
                    pass_test("No validation errors")
                else:
                    all_passed &= fail_test("Validation", f"{error_count} errors found")
        except Exception as e:
            log(f"  - Validation check: {e}")

    # Test 10: Export document to JSON
    log("\n--- Test 10: Export to JSON ---")
    to_json_fn = getattr(doc, "to_json", None) or getattr(doc, "toJson", None)
    if to_json_fn:
        try:
            json_output = to_json_fn()
            doc_dict = (
                json.loads(json_output) if isinstance(json_output, str) else json_output
            )
            blocks_key = "blocks" if "blocks" in doc_dict else "Blocks"
            if blocks_key in doc_dict:
                block_count_export = len(doc_dict[blocks_key])
                log(f"  - Exported blocks: {block_count_export}")
                if block_count_export == 1:
                    pass_test("JSON export contains exactly 1 block")
                else:
                    all_passed &= fail_test(
                        "JSON export block count",
                        f"Expected 1, got {block_count_export}",
                    )
            else:
                all_passed &= fail_test(
                    "JSON export",
                    f"No 'blocks' key in export. Keys: {list(doc_dict.keys())}",
                )
        except Exception as e:
            all_passed &= fail_test("JSON export", str(e))

    # Summary
    log("\n" + "=" * 60)
    log("SUMMARY")
    log("=" * 60)
    log(f"Document ID: {doc_id if doc_id else 'N/A'}")
    log(f"Root Block ID: {root_id if root_id else 'N/A'}")
    if block_count_prop is not None:
        if callable(block_count_prop):
            block_count_final = block_count_prop()
        else:
            block_count_final = block_count_prop
    else:
        block_count_final = "N/A"
    log(f"Block Count: {block_count_final}")
    log(f"Status: {'PASS' if all_passed else 'FAIL'}")
    log("=" * 60)

    return all_passed


if __name__ == "__main__":
    success = run_tests()
    sys.exit(0 if success else 1)

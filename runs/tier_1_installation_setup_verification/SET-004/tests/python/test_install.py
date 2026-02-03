"""
Test: SET-004 - Verify `pip install ucp-content` completes successfully

This test verifies that:
1. The ucp-content package can be imported
2. Core classes are accessible
3. Basic operations work (document creation, block manipulation)
4. UCL execution works
"""

import sys
import time


def run_test():
    results = {
        "import_test": {"passed": False, "time_ms": 0, "message": ""},
        "document_create_test": {"passed": False, "time_ms": 0, "message": ""},
        "block_operations_test": {"passed": False, "time_ms": 0, "message": ""},
        "ucl_execution_test": {"passed": False, "time_ms": 0, "message": ""},
        "version_check_test": {"passed": False, "time_ms": 0, "message": ""},
    }

    # Test 1: Import Test
    start = time.perf_counter()
    try:
        import ucp

        results["import_test"]["passed"] = True
        results["import_test"]["message"] = (
            f"Successfully imported ucp package with {len(dir(ucp))} exports"
        )
    except Exception as e:
        results["import_test"]["message"] = f"Import failed: {e}"
    results["import_test"]["time_ms"] = (time.perf_counter() - start) * 1000

    # Test 2: Version Check
    start = time.perf_counter()
    try:
        version = ucp.__version__
        results["version_check_test"]["passed"] = True
        results["version_check_test"]["message"] = f"Package version: {version}"
    except Exception as e:
        results["version_check_test"]["message"] = f"Version check failed: {e}"
    results["version_check_test"]["time_ms"] = (time.perf_counter() - start) * 1000

    # Test 3: Document Creation
    start = time.perf_counter()
    try:
        doc = ucp.Document.create()
        results["document_create_test"]["passed"] = True
        results["document_create_test"]["message"] = (
            f"Created document with ID: {doc.id}, Root: {doc.root_id}"
        )
    except Exception as e:
        results["document_create_test"]["message"] = f"Document creation failed: {e}"
    results["document_create_test"]["time_ms"] = (time.perf_counter() - start) * 1000

    # Test 4: Block Operations
    start = time.perf_counter()
    try:
        doc = ucp.Document.create()
        content = ucp.Content.text("Hello, UCP!")
        # Add to root block (documents start with a root block)
        block_id = doc.add_block_with_content(doc.root_id, content, role="paragraph")

        # Verify block was added
        block_count = doc.block_count
        block = doc.get_block(block_id)
        results["block_operations_test"]["passed"] = (
            block_count == 2
        )  # root + new block
        results["block_operations_test"]["message"] = (
            f"Added block to document (total blocks: {block_count})"
        )
    except Exception as e:
        results["block_operations_test"]["message"] = f"Block operations failed: {e}"
    results["block_operations_test"]["time_ms"] = (time.perf_counter() - start) * 1000

    # Test 5: UCL Execution
    start = time.perf_counter()
    try:
        doc = ucp.Document.create()
        content = ucp.Content.text("Original content")
        block_id = doc.add_block_with_content(doc.root_id, content, role="paragraph")

        # Execute UCL command using block ID
        ucp.execute_ucl(doc, f'EDIT {block_id} SET content.text = "Modified content"')

        # Verify modification
        modified_block = doc.get_block(block_id)
        modified_text = modified_block.get_text()
        results["ucl_execution_test"]["passed"] = "Modified content" in modified_text
        results["ucl_execution_test"]["message"] = (
            f"UCL EDIT executed: '{modified_text[:30]}...'"
        )
    except Exception as e:
        results["ucl_execution_test"]["message"] = f"UCL execution failed: {e}"
    results["ucl_execution_test"]["time_ms"] = (time.perf_counter() - start) * 1000

    return results


if __name__ == "__main__":
    print("=" * 60)
    print("SET-004: Verify `pip install ucp-content` Installation Test")
    print("=" * 60)
    print()

    results = run_test()

    all_passed = True
    for test_name, result in results.items():
        status = "✅ PASS" if result["passed"] else "❌ FAIL"
        all_passed = all_passed and result["passed"]
        print(f"{test_name}: {status}")
        print(f"  Time: {result['time_ms']:.3f}ms")
        print(f"  Message: {result['message']}")
        print()

    print("=" * 60)
    overall = "✅ ALL TESTS PASSED" if all_passed else "❌ SOME TESTS FAILED"
    print(f"Overall Result: {overall}")
    print("=" * 60)

    sys.exit(0 if all_passed else 1)

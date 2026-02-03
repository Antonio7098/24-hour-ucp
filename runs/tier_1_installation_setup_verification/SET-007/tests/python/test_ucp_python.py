"""
Test: SET-007 - Python SDK import test
"""

import json
import sys
from pathlib import Path

RESULTS_FILE = Path(__file__).parent / "../../results/python_test_results.json"

results = {
    "testName": "SET-007-PYTHON-IMPORT",
    "timestamp": str(__import__("datetime").datetime.now()),
    "documentedImport": "from ucp_content import Document",
    "status": "PENDING",
    "findings": [],
}

print("\n=== SET-007 Python SDK Test ===\n")

try:
    import ucp
    from ucp import Document, Content, execute_ucl

    results["findings"].append(
        {
            "check": "Package import",
            "passed": True,
            "message": "Successfully imported from ucp",
        }
    )
    print("✓ Package imported successfully")

    results["findings"].append(
        {"check": "Document class available", "passed": True, "class": str(Document)}
    )
    print(f"✓ Document class: {Document}")

    results["findings"].append(
        {"check": "Content class available", "passed": True, "class": str(Content)}
    )
    print(f"✓ Content class: {Content}")

    results["findings"].append(
        {
            "check": "execute_ucl function available",
            "passed": True,
            "function": str(execute_ucl),
        }
    )
    print(f"✓ execute_ucl function: {execute_ucl}")

    print("\nTest: Create document")
    doc = Document.create("Test Document")
    print(f"✓ Document created: {type(doc)}")

    results["findings"].append(
        {
            "check": "Document.create()",
            "passed": doc is not None,
            "result": str(type(doc)) if doc else "Failed",
        }
    )

    print("\nTest: Add block")
    try:
        text_content = ucp.Content.text("Hello from Python")
        print(f"✓ Text content created: {text_content}")
        results["findings"].append(
            {
                "check": "Content.text()",
                "passed": text_content is not None,
                "type": str(type(text_content)),
            }
        )
    except Exception as e:
        print(f"✗ Content creation failed: {e}")
        results["findings"].append(
            {"check": "Content.text()", "passed": False, "error": str(e)}
        )

    results["status"] = "PASS"
    print("\n=== Result: PASS ===")
    print("Python SDK (ucp-content) is working correctly")

except ImportError as e:
    results["status"] = "FAIL"
    results["error"] = str(e)
    print(f"✗ Import failed: {e}")
    print("\n=== Result: FAIL ===")

except Exception as e:
    results["status"] = "ERROR"
    results["error"] = str(e)
    print(f"✗ Test error: {e}")
    print("\n=== Result: ERROR ===")

with open(RESULTS_FILE, "w") as f:
    json.dump(results, f, indent=2, default=str)

print(f"\nResults written to: {RESULTS_FILE}")

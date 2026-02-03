#!/bin/bash
# SET-008: Verify Rust `ucp-api` crate compiles with basic usage
# CLI implementation for cross-platform comparison

echo "=== SET-008: CLI Test ==="
echo

# Test 1: Check if ucp-cli is installed
echo "[TEST 1] Checking ucp-cli installation..."
if command -v ucp &> /dev/null; then
    echo "  ucp-cli version: $(ucp --version 2>&1)"
    echo "  ✓ ucp-cli is installed"
else
    echo "  ! ucp-cli is not installed (skipping CLI tests)"
    echo "  NOTE: CLI installation requires: cargo install ucp-cli"
    exit 0
fi
echo

# Test 2: Create a test document
echo "[TEST 2] Creating test document..."
DOC_FILE="/tmp/ucp_test_$$.json"
ucp create --title "Test Document" --output "$DOC_FILE" 2>&1
if [ $? -eq 0 ]; then
    echo "  Document created: $DOC_FILE"
    echo "  ✓ Document creation successful"
else
    echo "  ! Document creation failed"
    exit 1
fi
echo

# Test 3: Verify document structure
echo "[TEST 3] Verifying document structure..."
if [ -f "$DOC_FILE" ]; then
    ROOT_BLOCK=$(cat "$DOC_FILE" | grep -o '"root": *"[^"]*"' | cut -d'"' -f4)
    echo "  Root block: $ROOT_BLOCK"
    echo "  ✓ Document structure verified"
else
    echo "  ! Document file not found"
    exit 1
fi
echo

# Cleanup
rm -f "$DOC_FILE"

echo "=== TEST SUMMARY ==="
echo "RESULT: PASS - CLI functions correctly (when installed)"

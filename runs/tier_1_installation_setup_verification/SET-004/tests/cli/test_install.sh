#!/bin/bash
# Test: SET-004 - Verify `pip install ucp-content` (CLI) completes successfully

echo "============================================================"
echo "SET-004: Verify `pip install ucp-content` (CLI) Test"
echo "============================================================"
echo ""

PASS=0
FAIL=0

# Test 1: CLI version check
echo "Test 1: CLI version check"
if ucp --version > /dev/null 2>&1; then
    VERSION=$(ucp --version)
    echo "  ✅ PASS - Version: $VERSION"
    ((PASS++))
else
    echo "  ❌ FAIL - CLI not available"
    ((FAIL++))
fi
echo ""

# Test 2: Create document
echo "Test 2: Create document"
DOC_FILE=$(mktemp /tmp/ucp_test_XXXXXX.json)
if ucp create --title "Test Document" --output "$DOC_FILE" 2>&1; then
    if [ -f "$DOC_FILE" ]; then
        echo "  ✅ PASS - Document created successfully"
        ((PASS++))
    else
        echo "  ❌ FAIL - Output file not created"
        ((FAIL++))
    fi
else
    echo "  ❌ FAIL - Create command failed"
    ((FAIL++))
fi
echo ""

# Test 3: Document info
echo "Test 3: Document info"
if [ -f "$DOC_FILE" ]; then
    if ucp info --file "$DOC_FILE" > /dev/null 2>&1; then
        echo "  ✅ PASS - Document info retrieved"
        ((PASS++))
    else
        echo "  ❌ FAIL - Info command failed"
        ((FAIL++))
    fi
else
    echo "  ❌ SKIP - No document file"
fi
echo ""

# Test 4: Add block via UCL
echo "Test 4: Add block via UCL"
if [ -f "$DOC_FILE" ]; then
    ROOT_ID=$(grep -o '"root_id":"[^"]*"' "$DOC_FILE" | cut -d'"' -f4)
    if ucp ucl exec -i "$DOC_FILE" -o "$DOC_FILE" -c "APPEND $ROOT_ID text :: 'Hello, UCP!'" 2>&1; then
        echo "  ✅ PASS - Block added via UCL"
        ((PASS++))
    else
        echo "  ❌ FAIL - UCL command failed"
        ((FAIL++))
    fi
else
    echo "  ❌ SKIP - No document file"
fi
echo ""

# Test 5: List blocks
echo "Test 5: List blocks"
if [ -f "$DOC_FILE" ]; then
    BLOCK_COUNT=$(ucp block list -f "$DOC_FILE" 2>&1 | grep -c "blk_" || echo "0")
    if [ "$BLOCK_COUNT" -ge 1 ]; then
        echo "  ✅ PASS - Blocks listed successfully"
        ((PASS++))
    else
        echo "  ❌ FAIL - Block list failed"
        ((FAIL++))
    fi
else
    echo "  ❌ SKIP - No document file"
fi
echo ""

# Cleanup
rm -f "$DOC_FILE"

# Summary
echo "============================================================"
TOTAL=$((PASS + FAIL))
if [ $FAIL -eq 0 ]; then
    echo "Overall Result: ✅ ALL TESTS PASSED ($PASS/$TOTAL)"
    exit 0
else
    echo "Overall Result: ❌ SOME TESTS FAILED ($PASS/$TOTAL)"
    exit 1
fi
echo "============================================================"

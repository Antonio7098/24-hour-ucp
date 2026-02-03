#!/bin/bash
# Test: SET-005 - CLI Document Creation

echo "=== SET-005: CLI Document Creation Test ==="
echo ""

# Test 1: Check ucp version
echo "Test 1: Check ucp CLI availability"
if command -v ucp &> /dev/null; then
    VERSION=$(ucp --version)
    echo "✓ PASS: ucp version $VERSION"
else
    echo "✗ FAIL: ucp command not found"
    exit 1
fi

# Test 2: Create a document via CLI
echo ""
echo "Test 2: Create document via CLI"
OUTPUT=$(ucp create --title "Test Document" --format json 2>&1)
echo "$OUTPUT"

if echo "$OUTPUT" | grep -q '"id": "doc_'; then
    echo "✓ PASS: Document created successfully"
else
    echo "✗ FAIL: Could not parse document creation output"
fi

# Test 3: Document creation timing
echo ""
echo "Test 3: Measure document creation time"
START=$(date +%s%N)
ucp create --title "Timing Test" > /dev/null 2>&1
END=$(date +%s%N)
DURATION=$(( (END - START) / 1000000 ))
echo "✓ Document created in ${DURATION}ms"

echo ""
echo "=== CLI Tests Complete ==="

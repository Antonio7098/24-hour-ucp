#!/bin/bash
# Test: SET-002 - Verify `ucp --version` returns valid version string

set -e

START_TIME=$(date +%s%3N)

echo "Testing ucp --version..."

# Run version command
OUTPUT=$(ucp --version 2>&1)
EXIT_CODE=$?

END_TIME=$(date +%s%3N)
ELAPSED=$((END_TIME - START_TIME))

echo "Exit code: $EXIT_CODE"
echo "Stdout: $OUTPUT"
echo "Execution time: ${ELAPSED}ms"

# Validation checks
PASS=true

# Check exit code
if [ $EXIT_CODE -ne 0 ]; then
    echo "FAIL: Non-zero exit code"
    PASS=false
fi

# Check output is not empty
if [ -z "$OUTPUT" ]; then
    echo "FAIL: Empty version output"
    PASS=false
fi

# Check format matches "ucp X.Y.Z"
if ! echo "$OUTPUT" | grep -qE '^ucp [0-9]+\.[0-9]+\.[0-9]+$'; then
    echo "FAIL: Version string format invalid: $OUTPUT"
    PASS=false
fi

if [ "$PASS" = true ]; then
    echo "PASS: Version string is valid"
    exit 0
else
    exit 1
fi

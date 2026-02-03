#!/bin/bash
# Test: SET-001 - Verify `cargo install ucp-cli` completes successfully
# Platform: CLI (Bash)

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RESULTS_DIR="$(cd "$(dirname "$(dirname "$(dirname "${SCRIPT_DIR}")")")" && pwd)/results"
LOG_FILE="$RESULTS_DIR/cli_test_$(date +%Y%m%d_%H%M%S).log"

mkdir -p "$RESULTS_DIR"

echo "=== SET-001: CLI Installation Verification ===" | tee "$LOG_FILE"
echo "Timestamp: $(date -Iseconds)" | tee -a "$LOG_FILE"
echo "" | tee -a "$LOG_FILE"

PASS=0
FAIL=0

log_result() {
    local test_name="$1"
    local status="$2"
    local message="$3"

    if [ "$status" = "PASS" ]; then
        ((PASS++))
        echo "[PASS] $test_name: $message" | tee -a "$LOG_FILE"
    else
        ((FAIL++))
        echo "[FAIL] $test_name: $message" | tee -a "$LOG_FILE"
    fi
}

echo "--- Test 1: Check ucp-cli installation ---" | tee -a "$LOG_FILE"

if command -v ucp &> /dev/null; then
    UCP_PATH=$(which ucp)
    log_result "ucp-cli installed" "PASS" "Found at $UCP_PATH"
else
    log_result "ucp-cli installed" "FAIL" "ucp command not found"
    echo "ERROR: ucp-cli is not installed. Run: cargo install ucp-cli" | tee -a "$LOG_FILE"
    exit 1
fi

echo "" | tee -a "$LOG_FILE"
echo "--- Test 2: Version check ---" | tee -a "$LOG_FILE"

UCP_VERSION=$(ucp --version 2>&1) || true
if [ -n "$UCP_VERSION" ]; then
    log_result "ucp --version" "PASS" "Version: $UCP_VERSION"
else
    log_result "ucp --version" "FAIL" "Could not get version"
fi

echo "" | tee -a "$LOG_FILE"
echo "--- Test 3: Help command ---" | tee -a "$LOG_FILE"

UCP_HELP=$(ucp --help 2>&1) || true
if echo "$UCP_HELP" | grep -q "Usage:"; then
    log_result "ucp --help" "PASS" "Help displayed successfully"
else
    log_result "ucp --help" "FAIL" "Help output malformed"
fi

echo "" | tee -a "$LOG_FILE"
echo "--- Test 4: Create document ---" | tee -a "$LOG_FILE"

TEMP_DOC="$RESULTS_DIR/test_doc_$$.json"
CREATE_OUTPUT=$(ucp create --title "Test Document" --format json --output "$TEMP_DOC" 2>&1) || true

if [ -f "$TEMP_DOC" ]; then
    log_result "ucp create" "PASS" "Document created successfully"

    if echo "$CREATE_OUTPUT" | grep -q '"id"'; then
        log_result "create output (JSON)" "PASS" "JSON output contains document ID"
    else
        log_result "create output (JSON)" "FAIL" "JSON output missing document ID"
    fi
else
    log_result "ucp create" "FAIL" "Document file not created: $CREATE_OUTPUT"
fi

echo "" | tee -a "$LOG_FILE"
echo "--- Test 5: Document info ---" | tee -a "$LOG_FILE"

if [ -f "$TEMP_DOC" ]; then
    INFO_OUTPUT=$(ucp info --input "$TEMP_DOC" --format json 2>&1) || true

    if echo "$INFO_OUTPUT" | grep -q '"block_count"'; then
        log_result "ucp info" "PASS" "Info command returned block count"
    else
        log_result "ucp info" "FAIL" "Info output malformed: $INFO_OUTPUT"
    fi
else
    log_result "ucp info" "FAIL" "Skipped - document not created"
fi

echo "" | tee -a "$LOG_FILE"
echo "--- Test 6: Add block ---" | tee -a "$LOG_FILE"

if [ -f "$TEMP_DOC" ]; then
    ROOT_ID=$(grep -o '"id":"blk_[^"]*"' "$TEMP_DOC" | head -1 | grep -o 'blk_[^"]*' || echo "")

    if [ -n "$ROOT_ID" ]; then
        ucp block add --input "$TEMP_DOC" --output "$TEMP_DOC" \
            --parent "$ROOT_ID" \
            --content-type text \
            --content "Hello from CLI test" \
            --role paragraph 2>&1 | tee -a "$LOG_FILE" || true

        INFO_OUTPUT=$(ucp info --input "$TEMP_DOC" --format json 2>&1) || true
        BLOCK_COUNT=$(echo "$INFO_OUTPUT" | grep -o '"block_count":[0-9]*' | grep -o '[0-9]*' || echo "0")

        if [ "$BLOCK_COUNT" -gt 1 ]; then
            log_result "ucp block add" "PASS" "Block added (total blocks: $BLOCK_COUNT)"
        else
            log_result "ucp block add" "FAIL" "Block count not increased: $BLOCK_COUNT"
        fi
    else
        log_result "ucp block add" "FAIL" "Could not find root block ID"
    fi
else
    log_result "ucp block add" "FAIL" "Skipped - document not created"
fi

echo "" | tee -a "$LOG_FILE"
echo "--- Test 7: Tree view ---" | tee -a "$LOG_FILE"

if [ -f "$TEMP_DOC" ]; then
    TREE_OUTPUT=$(ucp tree --input "$TEMP_DOC" --format text 2>&1) || true

    if echo "$TREE_OUTPUT" | grep -q "blk_root"; then
        log_result "ucp tree" "PASS" "Tree displays document hierarchy"
    else
        log_result "ucp tree" "FAIL" "Tree output malformed"
    fi
else
    log_result "ucp tree" "FAIL" "Skipped - document not created"
fi

echo "" | tee -a "$LOG_FILE"
echo "--- Test 8: Find command ---" | tee -a "$LOG_FILE"

if [ -f "$TEMP_DOC" ]; then
    FIND_OUTPUT=$(ucp find --input "$TEMP_DOC" --role paragraph --format json 2>&1) || true

    if echo "$FIND_OUTPUT" | grep -q '\['; then
        log_result "ucp find" "PASS" "Find command works"
    else
        log_result "ucp find" "FAIL" "Find output malformed: $FIND_OUTPUT"
    fi
else
    log_result "ucp find" "FAIL" "Skipped - document not created"
fi

echo "" | tee -a "$LOG_FILE"
echo "--- Test 9: Validate command ---" | tee -a "$LOG_FILE"

if [ -f "$TEMP_DOC" ]; then
    VALIDATE_OUTPUT=$(ucp validate --input "$TEMP_DOC" --format json 2>&1) || true

    if echo "$VALIDATE_OUTPUT" | grep -q '"valid":true'; then
        log_result "ucp validate" "PASS" "Document validated successfully"
    else
        log_result "ucp validate" "FAIL" "Validation output: $VALIDATE_OUTPUT"
    fi
else
    log_result "ucp validate" "FAIL" "Skipped - document not created"
fi

echo "" | tee -a "$LOG_FILE"
echo "--- Test 10: UCL execute ---" | tee -a "$LOG_FILE"

if [ -f "$TEMP_DOC" ]; then
    ROOT_ID=$(grep -o '"id":"blk_[^"]*"' "$TEMP_DOC" | head -1 | grep -o 'blk_[^"]*' || echo "")

    if [ -n "$ROOT_ID" ]; then
        UCL_OUTPUT=$(ucp ucl exec --input "$TEMP_DOC" --output "$TEMP_DOC" \
            --commands "APPEND $ROOT_ID text :: \"Added via UCL\" --role note" 2>&1) || true

        INFO_OUTPUT=$(ucp info --input "$TEMP_DOC" --format json 2>&1) || true
        BLOCK_COUNT=$(echo "$INFO_OUTPUT" | grep -o '"block_count":[0-9]*' | grep -o '[0-9]*' || echo "0")

        if [ "$BLOCK_COUNT" -gt 2 ]; then
            log_result "ucp ucl exec" "PASS" "UCL command executed (total blocks: $BLOCK_COUNT)"
        else
            log_result "ucp ucl exec" "FAIL" "Block count not increased: $BLOCK_COUNT"
        fi
    else
        log_result "ucp ucl exec" "FAIL" "Could not find root block ID"
    fi
else
    log_result "ucp ucl exec" "FAIL" "Skipped - document not created"
fi

echo "" | tee -a "$LOG_FILE"
echo "--- Cleanup ---" | tee -a "$LOG_FILE"
rm -f "$TEMP_DOC"

echo "" | tee -a "$LOG_FILE"
echo "=== Summary ===" | tee -a "$LOG_FILE"
echo "PASS: $PASS" | tee -a "$LOG_FILE"
echo "FAIL: $FAIL" | tee -a "$LOG_FILE"

if [ $FAIL -eq 0 ]; then
    echo "STATUS: ALL TESTS PASSED" | tee -a "$LOG_FILE"
    exit 0
else
    echo "STATUS: SOME TESTS FAILED" | tee -a "$LOG_FILE"
    exit 1
fi

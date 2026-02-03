#!/bin/bash
# Test: SET-003 - Verify `ucp --help` displays all documented commands
# This script compares documented commands with actual CLI output

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RESULTS_DIR="/home/antonio/programming/24-hour-testers/24-hour-ucp-testers/runs/tier_1_installation_setup_verification/SET-003/results"

mkdir -p "$RESULTS_DIR"
DOCS_FILE="$SCRIPT_DIR/../../../../ucp-docs/ucp-cli/README.md"

echo "=== SET-003: Verify ucp --help displays all documented commands ==="
echo ""

# Capture main help output
echo "[1/12] Capturing main help output..."
ucp --help > "$RESULTS_DIR/main_help.txt" 2>&1

# Capture subcommand outputs
echo "[2/12] Capturing block subcommands..."
ucp block --help > "$RESULTS_DIR/block_help.txt" 2>&1

echo "[3/12] Capturing edge subcommands..."
ucp edge --help > "$RESULTS_DIR/edge_help.txt" 2>&1

echo "[4/12] Capturing nav subcommands..."
ucp nav --help > "$RESULTS_DIR/nav_help.txt" 2>&1

echo "[5/12] Capturing tx subcommands..."
ucp tx --help > "$RESULTS_DIR/tx_help.txt" 2>&1

echo "[6/12] Capturing snapshot subcommands..."
ucp snapshot --help > "$RESULTS_DIR/snapshot_help.txt" 2>&1

echo "[7/12] Capturing import subcommands..."
ucp import --help > "$RESULTS_DIR/import_help.txt" 2>&1

echo "[8/12] Capturing export subcommands..."
ucp export --help > "$RESULTS_DIR/export_help.txt" 2>&1

echo "[9/12] Capturing ucl subcommands..."
ucp ucl --help > "$RESULTS_DIR/ucl_help.txt" 2>&1

echo "[10/12] Capturing agent subcommands..."
ucp agent --help > "$RESULTS_DIR/agent_help.txt" 2>&1

echo "[11/12] Capturing agent session subcommands..."
ucp agent session --help > "$RESULTS_DIR/agent_session_help.txt" 2>&1

echo "[12/12] Capturing llm subcommands..."
ucp llm --help > "$RESULTS_DIR/llm_help.txt" 2>&1

# Extract documented commands from README
echo ""
echo "=== Extracting documented commands from README ==="

# Documented top-level commands
DOCUMENTED_TOPLEVEL=$(grep -E "^\| (Document|Block|Edge|Navigation|Search|Structure|Transactions|Snapshots|Import|UCL|Agent|LLM) \|" "$DOCS_FILE" | sed 's/.*| `\([^`]*\)`.*/\1/' | tr '\n' ' ')

echo "Documented top-level commands found in README"

# Compare and report
echo ""
echo "=== Comparison Results ==="

PASS=0
FAIL=0

# Check main commands
echo ""
echo "Top-level commands check:"
for cmd in create info validate block edge nav find orphans tree prune tx snapshot import export ucl agent llm; do
    if grep -q "$cmd" "$RESULTS_DIR/main_help.txt"; then
        echo "  [PASS] $cmd found in main help"
        ((PASS++))
    else
        echo "  [FAIL] $cmd NOT found in main help"
        ((FAIL++))
    fi
done

# Check block subcommands
echo ""
echo "Block subcommands check:"
for cmd in add get delete move list update; do
    if grep -q "$cmd" "$RESULTS_DIR/block_help.txt"; then
        echo "  [PASS] block $cmd found"
        ((PASS++))
    else
        echo "  [FAIL] block $cmd NOT found"
        ((FAIL++))
    fi
done

# Check edge subcommands
echo ""
echo "Edge subcommands check:"
for cmd in add remove list; do
    if grep -q "$cmd" "$RESULTS_DIR/edge_help.txt"; then
        echo "  [PASS] edge $cmd found"
        ((PASS++))
    else
        echo "  [FAIL] edge $cmd NOT found"
        ((FAIL++))
    fi
done

# Check nav subcommands
echo ""
echo "Navigation subcommands check:"
for cmd in children parent siblings descendants; do
    if grep -q "$cmd" "$RESULTS_DIR/nav_help.txt"; then
        echo "  [PASS] nav $cmd found"
        ((PASS++))
    else
        echo "  [FAIL] nav $cmd NOT found"
        ((FAIL++))
    fi
done

# Check tx subcommands
echo ""
echo "Transaction subcommands check:"
for cmd in begin commit rollback savepoint; do
    if grep -q "$cmd" "$RESULTS_DIR/tx_help.txt"; then
        echo "  [PASS] tx $cmd found"
        ((PASS++))
    else
        echo "  [FAIL] tx $cmd NOT found"
        ((FAIL++))
    fi
done

# Check snapshot subcommands
echo ""
echo "Snapshot subcommands check:"
for cmd in create restore list delete diff; do
    if grep -q "$cmd" "$RESULTS_DIR/snapshot_help.txt"; then
        echo "  [PASS] snapshot $cmd found"
        ((PASS++))
    else
        echo "  [FAIL] snapshot $cmd NOT found"
        ((FAIL++))
    fi
done

# Check import subcommands
echo ""
echo "Import subcommands check:"
for cmd in markdown html; do
    if grep -q "$cmd" "$RESULTS_DIR/import_help.txt"; then
        echo "  [PASS] import $cmd found"
        ((PASS++))
    else
        echo "  [FAIL] import $cmd NOT found"
        ((FAIL++))
    fi
done

# Check export subcommands
echo ""
echo "Export subcommands check:"
for cmd in markdown json; do
    if grep -q "$cmd" "$RESULTS_DIR/export_help.txt"; then
        echo "  [PASS] export $cmd found"
        ((PASS++))
    else
        echo "  [FAIL] export $cmd NOT found"
        ((FAIL++))
    fi
done

# Check ucl subcommands
echo ""
echo "UCL subcommands check:"
for cmd in exec parse; do
    if grep -q "$cmd" "$RESULTS_DIR/ucl_help.txt"; then
        echo "  [PASS] ucl $cmd found"
        ((PASS++))
    else
        echo "  [FAIL] ucl $cmd NOT found"
        ((FAIL++))
    fi
done

# Check agent subcommands
echo ""
echo "Agent subcommands check:"
for cmd in session goto back expand follow search find context view; do
    if grep -q "$cmd" "$RESULTS_DIR/agent_help.txt"; then
        echo "  [PASS] agent $cmd found"
        ((PASS++))
    else
        echo "  [FAIL] agent $cmd NOT found"
        ((FAIL++))
    fi
done

# Check agent session subcommands
echo ""
echo "Agent session subcommands check:"
for cmd in create list close; do
    if grep -q "$cmd" "$RESULTS_DIR/agent_session_help.txt"; then
        echo "  [PASS] agent session $cmd found"
        ((PASS++))
    else
        echo "  [FAIL] agent session $cmd NOT found"
        ((FAIL++))
    fi
done

# Check llm subcommands
echo ""
echo "LLM subcommands check:"
for cmd in id-map shorten-ucl expand-ucl prompt context; do
    if grep -q "$cmd" "$RESULTS_DIR/llm_help.txt"; then
        echo "  [PASS] llm $cmd found"
        ((PASS++))
    else
        echo "  [FAIL] llm $cmd NOT found"
        ((FAIL++))
    fi
done

# Summary
echo ""
echo "=== Summary ==="
echo "Passed: $PASS"
echo "Failed: $FAIL"
echo ""

if [ $FAIL -eq 0 ]; then
    echo "STATUS: PASS - All documented commands are present in help output"
    exit 0
else
    echo "STATUS: FAIL - Some documented commands are missing from help output"
    exit 1
fi

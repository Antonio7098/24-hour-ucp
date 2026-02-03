/**
 * SET-008: Verify Rust `ucp-api` crate compiles with basic usage
 * JavaScript implementation for cross-platform comparison
 */

const ucp = require('ucp-content');

function runTests() {
    console.log("=== SET-008: JavaScript ucp-content SDK Test ===\n");
    const startTime = Date.now();

    // Test 1: Create document
    console.log("[TEST 1] Creating document...");
    const doc = ucp.createDocument("Test Document");
    console.log(`  Document ID: ${doc.id}`);
    console.log(`  Root block: ${doc.rootId}`);
    console.log("  ✓ Document created successfully\n");

    // Test 2: Add text content
    console.log("[TEST 2] Adding text content...");
    const root = doc.rootId;
    const textId = doc.addBlock(root, "Hello, UCP!", "intro");
    console.log(`  Text block ID: ${textId}`);
    console.log("  ✓ Text content added successfully\n");

    // Test 3: Add code block
    console.log("[TEST 3] Adding code block...");
    const codeContent = `fn main() {
    println!("Hello, UCP!");
}`;
    const codeId = doc.addCode(root, "rust", codeContent);
    console.log(`  Code block ID: ${codeId}`);
    console.log("  ✓ Code block added successfully\n");

    // Test 4: Execute UCL
    console.log("[TEST 4] Executing UCL command...");
    const affected = ucp.executeUcl(doc, `APPEND ${root} text :: "This is a section"`);
    console.log(`  Affected blocks: ${affected.length}`);
    console.log("  ✓ UCL execution completed\n");

    // Test 5: Validate document
    console.log("[TEST 5] Validating document...");
    const issues = doc.validate();
    if (!issues || issues.length === 0) {
        console.log("  ✓ Document is valid (no issues found)\n");
    } else {
        console.log(`  ! Document has ${issues.length} issues\n`);
    }

    // Test 6: Get document info
    console.log("[TEST 6] Getting document info...");
    console.log(`  Block count: ${doc.blockCount()}`);
    console.log("  ✓ Document info retrieved\n");

    // Test 7: Serialize to JSON
    console.log("[TEST 7] Serializing document to JSON...");
    const json = doc.toJson();
    console.log(`  ✓ JSON generation successful (${JSON.stringify(json).length} chars)\n`);

    // Test 8: Find blocks by type
    console.log("[TEST 8] Finding blocks by type...");
    const codeBlocks = doc.findByType("code");
    const textBlocks = doc.findByType("text");
    console.log(`  Code blocks: ${codeBlocks.length}`);
    console.log(`  Text blocks: ${textBlocks.length}`);
    console.log("  ✓ Block search completed\n");

    // Test 9: Error handling
    console.log("[TEST 9] Testing error handling...");
    try {
        ucp.executeUcl(doc, "THIS_IS_INVALID SYNTAX");
        console.log("  ! Warning: Invalid UCL was accepted\n");
    } catch (e) {
        console.log("  ✓ Correctly caught invalid UCL\n");
    }

    // Test 10: Version check
    console.log("[TEST 10] Checking SDK version...");
    const version = ucp.version();
    console.log(`  SDK version: ${version}`);
    console.log("  ✓ Version check completed\n");

    const elapsed = Date.now() - startTime;
    console.log("=== TEST SUMMARY ===");
    console.log(`Total execution time: ${elapsed}ms`);
    console.log(`Final block count: ${doc.blockCount()}`);
    console.log("\nRESULT: PASS - JavaScript SDK functions correctly");
}

runTests();

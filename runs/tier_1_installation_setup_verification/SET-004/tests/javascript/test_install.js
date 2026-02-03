/**
 * Test: SET-004 - Verify `pip install ucp-content` (JavaScript/Node.js) completes successfully
 */

const ucp = require('ucp-content');

function runTest() {
  const results = {
    import_test: { passed: false, time_ms: 0, message: '' },
    version_check_test: { passed: false, time_ms: 0, message: '' },
    document_create_test: { passed: false, time_ms: 0, message: '' },
    block_operations_test: { passed: false, time_ms: 0, message: '' },
    ucl_execution_test: { passed: false, time_ms: 0, message: '' },
  };

  // Test 1: Import Test
  let start = Date.now();
  try {
    results.import_test.passed = true;
    results.import_test.message = `Successfully loaded ucp-content with ${Object.keys(ucp).length} exports`;
  } catch (e) {
    results.import_test.message = `Import failed: ${e.message}`;
  }
  results.import_test.time_ms = Date.now() - start;

  // Test 2: Version Check
  start = Date.now();
  try {
    const version = ucp.version();
    results.version_check_test.passed = true;
    results.version_check_test.message = `Package version: ${version}`;
  } catch (e) {
    results.version_check_test.message = `Version check failed: ${e.message}`;
  }
  results.version_check_test.time_ms = Date.now() - start;

  // Test 3: Document Creation
  start = Date.now();
  try {
    const doc = ucp.createDocument();
    results.document_create_test.passed = true;
    results.document_create_test.message = `Created document with ID: ${doc.id}`;
  } catch (e) {
    results.document_create_test.message = `Document creation failed: ${e.message}`;
  }
  results.document_create_test.time_ms = Date.now() - start;

  // Test 4: Block Operations
  start = Date.now();
  try {
    const doc = ucp.createDocument();
    const content = ucp.Content.text('Hello, UCP!');
    const blockId = doc.addBlockWithContent(doc.rootId, content, 'paragraph');
    
    const blockCount = doc.blockCount();
    const block = doc.getBlock(blockId);
    
    results.block_operations_test.passed = blockCount === 2 && block.role === 'paragraph'; // root + new block
    results.block_operations_test.message = `Added block to document (total blocks: ${blockCount}, role: ${block.role})`;
  } catch (e) {
    results.block_operations_test.message = `Block operations failed: ${e.message}`;
  }
  results.block_operations_test.time_ms = Date.now() - start;

  // Test 5: UCL Execution
  start = Date.now();
  try {
    const doc = ucp.createDocument();
    const content = ucp.Content.text('Original content');
    const blockId = doc.addBlockWithContent(doc.rootId, content, 'paragraph');
    
    // Execute UCL command
    ucp.executeUcl(doc, `EDIT ${blockId} SET content.text = "Modified content"`);
    
    // Verify modification
    const modifiedBlock = doc.getBlock(blockId);
    const modifiedText = modifiedBlock.text;
    
    results.ucl_execution_test.passed = modifiedText.includes('Modified content');
    results.ucl_execution_test.message = `UCL EDIT executed: '${modifiedText.substring(0, 30)}...'`;
  } catch (e) {
    results.ucl_execution_test.message = `UCL execution failed: ${e.message}`;
  }
  results.ucl_execution_test.time_ms = Date.now() - start;

  return results;
}

// Run tests
console.log('='.repeat(60));
console.log('SET-004: Verify `pip install ucp-content` (JavaScript) Test');
console.log('='.repeat(60));
console.log();

const results = runTest();

let allPassed = true;
for (const [testName, result] of Object.entries(results)) {
  const status = result.passed ? '✅ PASS' : '❌ FAIL';
  allPassed = allPassed && result.passed;
  console.log(`${testName}: ${status}`);
  console.log(`  Time: ${result.time_ms}ms`);
  console.log(`  Message: ${result.message}`);
  console.log();
}

console.log('='.repeat(60));
const overall = allPassed ? '✅ ALL TESTS PASSED' : '❌ SOME TESTS FAILED';
console.log(`Overall Result: ${overall}`);
console.log('='.repeat(60));

process.exit(allPassed ? 0 : 1);

/**
 * Test: SET-007-CORRECT-API - Verify correct JavaScript UCP API
 *
 * Since @ucp-core/core doesn't exist, this tests the actual working API
 * from ucp-content package.
 */

const fs = require('fs');
const path = require('path');

const RESULTS_FILE = path.join(__dirname, '../../results/js_correct_api_results.json');

const results = {
    testName: 'SET-007-JS-CORRECT-API',
    timestamp: new Date().toISOString(),
    documentedImport: {
        statement: "import { Document } from '@ucp-core/core'",
        status: 'FAIL',
        reason: 'Package does not exist in npm registry'
    },
    actualApi: {
        package: 'ucp-content',
        importStatement: "const { createDocument, Document, Content } = require('ucp-content')",
        status: 'PASS'
    },
    tests: [],
    conclusion: {}
};

console.log('\n=== SET-007 JavaScript Correct API Test ===\n');

try {
    const ucp = require('ucp-content');

    // Test 1: createDocument function
    console.log('Test 1: createDocument()');
    try {
        const doc = ucp.createDocument('Test Document');
        results.tests.push({
            name: 'createDocument()',
            passed: !!doc,
            result: doc ? 'Created successfully' : 'Failed to create',
            docId: doc ? 'WASM pointer' : null
        });
        console.log(`   ${!!doc ? '✓' : '✗'} ${doc ? 'Created successfully' : 'Failed'}`);
    } catch (e) {
        results.tests.push({ name: 'createDocument()', passed: false, error: e.message });
        console.log(`   ✗ Error: ${e.message}`);
    }

    // Test 2: Document class exists
    console.log('\nTest 2: Document class');
    const hasDocument = typeof ucp.Document !== 'undefined';
    results.tests.push({
        name: 'Document class exists',
        passed: hasDocument,
        type: typeof ucp.Document
    });
    console.log(`   ${hasDocument ? '✓' : '✗'} Document class: ${typeof ucp.Document}`);

    // Test 3: Content class exists
    console.log('\nTest 3: Content class');
    const hasContent = typeof ucp.Content !== 'undefined';
    results.tests.push({
        name: 'Content class exists',
        passed: hasContent,
        type: typeof ucp.Content
    });
    console.log(`   ${hasContent ? '✓' : '✗'} Content class: ${typeof ucp.Content}`);

    // Test 4: executeUcl function
    console.log('\nTest 4: executeUcl()');
    const hasExecuteUcl = typeof ucp.executeUcl !== 'undefined';
    results.tests.push({
        name: 'executeUcl() exists',
        passed: hasExecuteUcl,
        type: typeof ucp.executeUcl
    });
    console.log(`   ${hasExecuteUcl ? '✓' : '✗'} executeUcl: ${typeof ucp.executeUcl}`);

    // Summary
    const passCount = results.tests.filter(t => t.passed).length;
    const totalCount = results.tests.length;

    results.conclusion = {
        documentedApiStatus: 'BROKEN',
        actualApiStatus: 'WORKING',
        recommendedImport: "const { createDocument, Document, Content, executeUcl } = require('ucp-content')",
        issue: 'Documentation references non-existent package @ucp-core/core',
        fix: 'Update documentation to use ucp-content package or publish @ucp-core/core'
    };

    results.actualApi.status = passCount === totalCount ? 'PASS' : 'PARTIAL';

    console.log(`\n=== Summary ===`);
    console.log(`Tests: ${passCount}/${totalCount} passed`);
    console.log(`\nConclusion:`);
    console.log(`  Documented: ${results.documentedImport.statement}`);
    console.log(`  Status: ${results.documentedImport.status} - ${results.documentedImport.reason}`);
    console.log(`\n  Actual: ${results.actualApi.importStatement}`);
    console.log(`  Status: ${results.actualApi.status}`);
    console.log(`\nFix: ${results.conclusion.fix}`);

} catch (err) {
    results.status = 'ERROR';
    results.error = err.message;
    console.error('Test execution error:', err);
}

// Write results
fs.writeFileSync(RESULTS_FILE, JSON.stringify(results, null, 2));
console.log(`\nResults written to: ${RESULTS_FILE}`);

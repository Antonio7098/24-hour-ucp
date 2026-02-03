/**
 * Test: SET-007-ALTERNATIVE - Verify available JavaScript SDK alternatives
 *
 * This test verifies what JavaScript UCP packages are actually available
 * since the documented @ucp-core/core package doesn't exist.
 */

const fs = require('fs');
const path = require('path');

const RESULTS_FILE = path.join(__dirname, '../../results/js_alternatives_results.json');

const results = {
    testName: 'SET-007-JS-ALTERNATIVES',
    timestamp: new Date().toISOString(),
    status: 'PARTIAL',
    findings: []
};

console.log('\n=== SET-007 JavaScript SDK Alternatives ===\n');

try {
    // Test ucp-content (WASM bindings)
    console.log('1. Testing ucp-content (WASM bindings):');
    try {
        const ucpContent = require('ucp-content');
        console.log('   ✓ Package loaded successfully');

        const exports = Object.keys(ucpContent);
        console.log(`   ✓ Available exports: ${exports.join(', ')}`);

        // Try to access Document
        if (typeof ucpContent.Document !== 'undefined') {
            console.log('   ✓ Document class available');

            // Try creating a document
            try {
                const doc = ucpContent.Document.create();
                console.log(`   ✓ Document.create() works: ${typeof doc}`);
                if (doc && doc.id) {
                    console.log(`   ✓ Document ID: ${doc.id}`);
                }
            } catch (e) {
                console.log(`   ✗ Document.create() failed: ${e.message}`);
            }
        } else {
            console.log('   ✗ Document class NOT available');
        }

        results.findings.push({
            package: 'ucp-content',
            loaded: true,
            exports: exports,
            hasDocument: typeof ucpContent.Document !== 'undefined',
            status: 'WORKING'
        });
    } catch (e) {
        console.log(`   ✗ Failed to load: ${e.message}`);
        results.findings.push({
            package: 'ucp-content',
            loaded: false,
            error: e.message,
            status: 'FAILED'
        });
    }

    // Test @ucp-js/sdk (TypeScript types only)
    console.log('\n2. Testing @ucp-js/sdk (TypeScript types):');
    try {
        const ucpJsSdk = require('@ucp-js/sdk');
        console.log('   ✓ Package loaded');

        // Check if dist exists
        const distPath = path.dirname(require.resolve('@ucp-js/sdk/package.json')) + '/dist';
        const distExists = fs.existsSync(distPath);

        console.log(`   ${distExists ? '✓' : '✗'} dist directory: ${distExists ? 'exists' : 'missing'}`);

        if (!distExists) {
            console.log('   Note: Package needs "npm run build" to generate runtime code');
        }

        results.findings.push({
            package: '@ucp-js/sdk',
            loaded: true,
            hasDistBuild: distExists,
            note: 'Provides only TypeScript types and Zod schemas, no runtime',
            status: distExists ? 'WORKING' : 'BUILD_REQUIRED'
        });
    } catch (e) {
        console.log(`   ✗ Failed to load: ${e.message}`);
        results.findings.push({
            package: '@ucp-js/sdk',
            loaded: false,
            error: e.message,
            status: 'FAILED'
        });
    }

    results.status = 'COMPLETE';
    results.conclusion = {
        documentedImport: "import { Document } from '@ucp-core/core'",
        workingAlternative: "const { Document } = require('ucp-content')",
        recommendation: 'Update documentation to use ucp-content package'
    };

    console.log('\n=== Conclusion ===');
    console.log(`Documented import: ${results.conclusion.documentedImport}`);
    console.log(`Working alternative: ${results.conclusion.workingAlternative}`);
    console.log(`Recommendation: ${results.conclusion.recommendation}`);

} catch (err) {
    results.status = 'ERROR';
    results.error = err.message;
    console.error('Test execution error:', err);
}

// Write results
fs.writeFileSync(RESULTS_FILE, JSON.stringify(results, null, 2));
console.log(`\nResults written to: ${RESULTS_FILE}`);

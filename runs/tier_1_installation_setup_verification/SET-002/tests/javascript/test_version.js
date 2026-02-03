/**
 * Test: SET-002 - Verify `ucp --version` returns valid version string
 */
const { execSync } = require('child_process');
const versionPattern = /^ucp \d+\.\d+\.\d+$/;

function testUcpVersion() {
    const startTime = Date.now();

    try {
        const output = execSync('ucp --version', { encoding: 'utf-8' }).trim();
        const elapsed = Date.now() - startTime;

        console.log(`Exit code: 0`);
        console.log(`Stdout: ${output}`);
        console.log(`Execution time: ${elapsed}ms`);

        // Validation
        if (!output) {
            console.log('FAIL: Empty version output');
            return false;
        }

        if (!versionPattern.test(output)) {
            console.log(`FAIL: Version string format invalid: ${output}`);
            return false;
        }

        console.log('PASS: Version string is valid');
        return true;

    } catch (error) {
        console.log(`FAIL: Exception occurred: ${error.message}`);
        return false;
    }
}

const success = testUcpVersion();
process.exit(success ? 0 : 1);

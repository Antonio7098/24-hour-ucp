#!/usr/bin/env python3
"""
Test: SET-002 - Verify `ucp --version` returns valid version string
"""

import subprocess
import sys
import re
import time


def test_ucp_version():
    """Test that ucp --version returns valid version string."""
    start_time = time.time()

    try:
        result = subprocess.run(
            ["ucp", "--version"], capture_output=True, text=True, timeout=10
        )

        elapsed = (time.time() - start_time) * 1000

        print(f"Exit code: {result.returncode}")
        print(f"Stdout: {result.stdout.strip()}")
        print(f"Stderr: {result.stderr.strip()}")
        print(f"Execution time: {elapsed:.2f}ms")

        # Validation
        output = result.stdout.strip()

        # Check exit code
        if result.returncode != 0:
            print("FAIL: Non-zero exit code")
            return False

        # Check output is not empty
        if not output:
            print("FAIL: Empty version output")
            return False

        # Check format matches "ucp X.Y.Z"
        version_pattern = r"^ucp \d+\.\d+\.\d+$"
        if not re.match(version_pattern, output):
            print(f"FAIL: Version string format invalid: {output}")
            return False

        print("PASS: Version string is valid")
        return True

    except subprocess.TimeoutExpired:
        print("FAIL: Command timed out")
        return False
    except Exception as e:
        print(f"FAIL: Exception occurred: {e}")
        return False


if __name__ == "__main__":
    success = test_ucp_version()
    sys.exit(0 if success else 1)

//! Test: SET-002 - Verify `ucp --version` returns valid version string

use std::io::{self, Read};
use std::process::{Command, Stdio};

fn test_ucp_version() -> bool {
    let start = std::time::Instant::now();

    let output = Command::new("ucp")
        .arg("--version")
        .stdout(Stdio::piped())
        .stderr(Stdio::piped())
        .output();

    let elapsed_ms = start.elapsed().as_secs_f64() * 1000.0;

    match output {
        Ok(output) => {
            println!("Exit code: {}", output.status.code().unwrap_or(-1));
            println!("Stdout: {}", String::from_utf8_lossy(&output.stdout).trim());
            println!("Stderr: {}", String::from_utf8_lossy(&output.stderr).trim());
            println!("Execution time: {:.2}ms", elapsed_ms);

            // Check exit code
            if !output.status.success() {
                println!("FAIL: Non-zero exit code");
                return false;
            }

            let version_output = String::from_utf8_lossy(&output.stdout).trim().to_string();

            // Check output is not empty
            if version_output.is_empty() {
                println!("FAIL: Empty version output");
                return false;
            }

            // Check format matches "ucp X.Y.Z"
            let version_pattern = regex::Regex::new(r"^ucp \d+\.\d+\.\d+$").unwrap();
            if !version_pattern.is_match(&version_output) {
                println!("FAIL: Version string format invalid: {}", version_output);
                return false;
            }

            println!("PASS: Version string is valid");
            true
        }
        Err(e) => {
            println!("FAIL: Exception occurred: {}", e);
            false
        }
    }
}

fn main() {
    let success = test_ucp_version();
    std::process::exit(if success { 0 } else { 1 });
}

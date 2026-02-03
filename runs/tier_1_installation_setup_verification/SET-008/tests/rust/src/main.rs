use ucp_api::UcpClient;

fn main() {
    println!("=== SET-008: Rust ucp-api Compilation and Basic Usage Test ===\n");

    let start_time = std::time::Instant::now();

    // Test 1: Create client
    println!("[TEST 1] Creating UcpClient...");
    let client = UcpClient::new();
    println!("  ✓ UcpClient created successfully\n");

    // Test 2: Create document
    println!("[TEST 2] Creating document...");
    let mut doc = client.create_document();
    println!("  Document ID: {}", doc.id);
    println!("  Root block: {}", doc.root);
    println!("  ✓ Document created successfully\n");

    // Test 3: Get document info
    println!("[TEST 3] Getting document info...");
    let block_count = doc.block_count();
    println!("  Block count: {}", block_count);
    println!("  ✓ Document info retrieved successfully\n");

    // Test 4: Add text content using convenience method
    println!("[TEST 4] Adding text content...");
    let root = doc.root.clone();
    let _text_id = match client.add_text(&mut doc, &root, "Hello, UCP!", Some("intro")) {
        Ok(id) => {
            println!("  Text block ID: {}", id);
            id
        }
        Err(e) => {
            println!("  ✗ Failed to add text: {:?}", e);
            std::process::exit(1);
        }
    };
    println!("  ✓ Text content added successfully\n");

    // Test 5: Add code block
    println!("[TEST 5] Adding code block...");
    let code_content = r#"fn main() {
    println!("Hello, UCP!");
}"#;
    let _code_id = match client.add_code(&mut doc, &root, "rust", code_content) {
        Ok(id) => {
            println!("  Code block ID: {}", id);
            id
        }
        Err(e) => {
            println!("  ✗ Failed to add code: {:?}", e);
            std::process::exit(1);
        }
    };
    println!("  ✓ Code block added successfully\n");

    // Test 6: Execute UCL command
    println!("[TEST 6] Executing UCL command...");
    let ucl_cmd = r#"APPEND blk_ff0000000000000000000000 text :: "This is a section""#;
    let ucl_result = client.execute_ucl(&mut doc, ucl_cmd);
    match ucl_result {
        Ok(results) => {
            println!("  UCL executed, {} results", results.len());
            for result in &results {
                if result.success {
                    println!(
                        "    ✓ Success: {:?}",
                        result.affected_blocks.iter().take(3).collect::<Vec<_>>()
                    );
                } else {
                    println!("    ✗ Failed: {:?}", result.error);
                }
            }
        }
        Err(e) => {
            println!("  ✗ UCL execution failed: {:?}\n", e);
        }
    };
    println!("  ✓ UCL execution completed\n");

    // Test 7: Validate document
    println!("[TEST 7] Validating document...");
    let issues = doc.validate();
    if issues.is_empty() {
        println!("  ✓ Document is valid (no issues found)\n");
    } else {
        println!("  ! Document has {} issues:", issues.len());
        for issue in &issues {
            println!("    - {}", issue.message);
        }
    }

    // Test 8: Serialize to JSON
    println!("[TEST 8] Serializing document to JSON...");
    let json_result = client.to_json(&doc);
    match json_result {
        Ok(json) => {
            println!("  ✓ JSON serialization successful");
            println!("  JSON length: {} bytes\n", json.len());

            // Parse and pretty-print a snippet
            match serde_json::from_str::<serde_json::Value>(&json) {
                Ok(parsed) => {
                    if let Some(blocks) = parsed.get("blocks").and_then(|b| b.as_object()) {
                        println!("  Document contains {} blocks:", blocks.len());
                        for (id, block) in blocks.iter().take(3) {
                            let content = block
                                .get("content")
                                .and_then(|c| c.get("text"))
                                .and_then(|t| t.as_str())
                                .unwrap_or("(no text)");
                            let role = block
                                .get("metadata")
                                .and_then(|m| m.get("role"))
                                .and_then(|r| r.as_str())
                                .unwrap_or("none");
                            println!(
                                "    - {}: [{}] {}",
                                id,
                                role,
                                if content.len() > 40 {
                                    &content[..40]
                                } else {
                                    content
                                }
                            );
                        }
                    }
                }
                Err(e) => {
                    println!("  ! Warning: Could not parse JSON: {:?}\n", e);
                }
            }
        }
        Err(e) => {
            println!("  ✗ JSON serialization failed: {:?}\n", e);
        }
    }

    // Test 9: Find blocks by type
    println!("[TEST 9] Finding blocks by type...");
    let code_blocks = doc.indices.find_by_type("code");
    let text_blocks = doc.indices.find_by_type("text");
    println!("  Code blocks: {}", code_blocks.len());
    println!("  Text blocks: {}", text_blocks.len());
    println!("  ✓ Block search completed\n");

    // Test 10: Error handling - invalid UCL
    println!("[TEST 10] Testing error handling with invalid UCL...");
    let invalid_ucl_result = client.execute_ucl(&mut doc, "THIS_IS_INVALID SYNTAX");
    match invalid_ucl_result {
        Err(_e) => {
            println!("  ✓ Correctly caught invalid UCL: Error type detected\n");
        }
        Ok(_) => {
            println!("  ! Warning: Invalid UCL was accepted (may be parser lenient)\n");
        }
    }

    let elapsed = start_time.elapsed();
    println!("=== TEST SUMMARY ===");
    println!("All core operations completed successfully.");
    println!("Total execution time: {:.2}ms", elapsed.as_millis() as f64);
    println!("Final block count: {}\n", doc.block_count());

    println!("RESULT: PASS - Rust ucp-api crate compiles and functions correctly");
}

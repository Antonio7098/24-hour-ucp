# Mission Checklist: Unified Content Protocol (UCP)

> **Instructions**: Each test should be implemented in Python, JavaScript, Rust, and CLI where applicable. The agent runner will execute tests in order, marking status as complete. Focus is on UCP testing - report StageFlow bugs separately but do not let them block UCP testing.

---

## Tier 1: Installation & Setup Verification

| ID | Target | Priority | Risk | Status |
|----|--------|----------|------|--------|
| SET-001 | Verify `cargo install ucp-cli` completes successfully | P0 | High | ✅ Completed |
| SET-002 | Verify `ucp --version` returns valid version string | P0 | High | ✅ Completed |
| SET-003 | Verify `ucp --help` displays all documented commands | P0 | Medium | ✅ Completed |
| SET-004 | Verify `pip install ucp-content` completes successfully | P0 | High | ✅ Completed |
| SET-005 | Verify Python `from ucp_content import Document` works | P0 | High | ✅ Completed |
| SET-006 | Verify `npm install @ucp-core/core` completes successfully | P0 | High | ✅ Completed |
| SET-007 | Verify JS `import { Document } from '@ucp-core/core'` works | P0 | High | ✅ Completed |
| SET-008 | Verify Rust `ucp-api` crate compiles with basic usage | P0 | High | ✅ Completed |

---

## Tier 2: Document Lifecycle Operations

| ID | Target | Priority | Risk | Status |
|----|--------|----------|------|--------|
| DOC-001 | Create empty document and verify root block exists | P0 | High | ☐ Not Started |
| DOC-002 | Create document with title and verify metadata | P0 | Medium | ☐ Not Started |
| DOC-003 | Verify document ID is deterministic for same inputs | P0 | High | ☐ Not Started |
| DOC-004 | Verify `block_count()` returns correct count after operations | P0 | Medium | ☐ Not Started |
| DOC-005 | Serialize document to JSON and verify structure | P0 | High | ☐ Not Started |
| DOC-006 | Deserialize document from JSON and verify integrity | P0 | High | ☐ Not Started |
| DOC-007 | Verify document validation detects orphaned blocks | P1 | High | ☐ Not Started |
| DOC-008 | Verify document validation detects cycle attempts | P0 | Critical | ☐ Not Started |
| DOC-009 | Verify `prune_unreachable()` removes orphaned blocks | P1 | Medium | ☐ Not Started |
| DOC-010 | Test document metadata (title, description, authors) CRUD | P1 | Low | ☐ Not Started |

---

## Tier 3: Block Creation & Content Types

| ID | Target | Priority | Risk | Status |
|----|--------|----------|------|--------|
| BLK-001 | Create Text block with plain text content | P0 | High | ☐ Not Started |
| BLK-002 | Create Text block with Markdown content | P0 | High | ☐ Not Started |
| BLK-003 | Create Code block with language hint | P0 | High | ☐ Not Started |
| BLK-004 | Verify Code block preserves whitespace and indentation | P0 | High | ☐ Not Started |
| BLK-005 | Create Code block with line highlights | P1 | Low | ☐ Not Started |
| BLK-006 | Create Table block with column definitions | P0 | Medium | ☐ Not Started |
| BLK-007 | Create Table block with typed cells (Text, Number, Boolean) | P1 | Medium | ☐ Not Started |
| BLK-008 | Create Math block with LaTeX expression | P1 | Medium | ☐ Not Started |
| BLK-009 | Create Math block with MathML expression | P2 | Low | ☐ Not Started |
| BLK-010 | Create Media block with URL source | P1 | Medium | ☐ Not Started |
| BLK-011 | Create Media block with base64 data | P1 | Medium | ☐ Not Started |
| BLK-012 | Create JSON block with simple object | P0 | Medium | ☐ Not Started |
| BLK-013 | Create JSON block with schema validation | P2 | Low | ☐ Not Started |
| BLK-014 | Create Binary block with MIME type | P2 | Low | ☐ Not Started |
| BLK-015 | Create Composite block with vertical layout | P1 | Medium | ☐ Not Started |
| BLK-016 | Verify block ID is deterministic for same content+role | P0 | High | ☐ Not Started |
| BLK-017 | Verify different roles produce different IDs | P0 | High | ☐ Not Started |
| BLK-018 | Verify content change produces new ID | P0 | High | ☐ Not Started |

---

## Tier 4: Block Metadata & Organization

| ID | Target | Priority | Risk | Status |
|----|--------|----------|------|--------|
| META-001 | Add semantic role to block and verify | P0 | High | ☐ Not Started |
| META-002 | Test all documented semantic role categories | P1 | Medium | ☐ Not Started |
| META-003 | Add label to block and find by label | P0 | High | ☐ Not Started |
| META-004 | Verify label uniqueness constraint | P1 | Medium | ☐ Not Started |
| META-005 | Add tags to block and find by tag | P0 | High | ☐ Not Started |
| META-006 | Add multiple tags and verify all indexed | P1 | Medium | ☐ Not Started |
| META-007 | Remove tag from block | P1 | Medium | ☐ Not Started |
| META-008 | Add summary to block (for folding) | P1 | Low | ☐ Not Started |
| META-009 | Verify token estimate is computed | P1 | Medium | ☐ Not Started |
| META-010 | Verify token estimates differ by model (GPT-4, Claude) | P2 | Low | ☐ Not Started |
| META-011 | Query blocks by content type index | P0 | Medium | ☐ Not Started |
| META-012 | Query blocks by role index | P0 | Medium | ☐ Not Started |

---

## Tier 5: Document Structure Operations

| ID | Target | Priority | Risk | Status |
|----|--------|----------|------|--------|
| STR-001 | Add block as child of root | P0 | High | ☐ Not Started |
| STR-002 | Add block as child of non-root block | P0 | High | ☐ Not Started |
| STR-003 | Add block at specific index position | P0 | High | ☐ Not Started |
| STR-004 | Get children of block | P0 | High | ☐ Not Started |
| STR-005 | Get parent of block | P0 | High | ☐ Not Started |
| STR-006 | Get descendants of block (recursive) | P0 | Medium | ☐ Not Started |
| STR-007 | Check if block is ancestor of another | P1 | Medium | ☐ Not Started |
| STR-008 | Move block to new parent | P0 | High | ☐ Not Started |
| STR-009 | Move block to specific position under parent | P0 | Medium | ☐ Not Started |
| STR-010 | Verify move prevents cycle creation | P0 | Critical | ☐ Not Started |
| STR-011 | Delete block (children become orphaned) | P0 | High | ☐ Not Started |
| STR-012 | Delete block with CASCADE (removes descendants) | P0 | High | ☐ Not Started |
| STR-013 | Delete block with PRESERVE_CHILDREN (reparent) | P1 | Medium | ☐ Not Started |
| STR-014 | Remove block from structure (orphan it) | P1 | Medium | ☐ Not Started |
| STR-015 | Check block reachability from root | P0 | Medium | ☐ Not Started |
| STR-016 | Find all orphaned blocks | P1 | Medium | ☐ Not Started |
| STR-017 | Build deep hierarchy (10+ levels) | P1 | Medium | ☐ Not Started |
| STR-018 | Build wide hierarchy (100+ siblings) | P1 | Medium | ☐ Not Started |

---

## Tier 6: Edge & Relationship Management

| ID | Target | Priority | Risk | Status |
|----|--------|----------|------|--------|
| EDG-001 | Add References edge between blocks | P0 | High | ☐ Not Started |
| EDG-002 | Verify CitedBy inverse is auto-maintained | P0 | High | ☐ Not Started |
| EDG-003 | Add DerivedFrom edge | P1 | Medium | ☐ Not Started |
| EDG-004 | Add Supersedes edge | P1 | Medium | ☐ Not Started |
| EDG-005 | Add Supports edge with confidence score | P1 | Medium | ☐ Not Started |
| EDG-006 | Add Contradicts edge (verify symmetric) | P1 | Medium | ☐ Not Started |
| EDG-007 | Add Elaborates edge | P1 | Low | ☐ Not Started |
| EDG-008 | Add Summarizes edge | P1 | Low | ☐ Not Started |
| EDG-009 | Add VersionOf edge | P1 | Low | ☐ Not Started |
| EDG-010 | Add TranslationOf edge with language metadata | P2 | Low | ☐ Not Started |
| EDG-011 | Add Custom edge type | P1 | Medium | ☐ Not Started |
| EDG-012 | Query outgoing edges from block | P0 | High | ☐ Not Started |
| EDG-013 | Query incoming edges to block | P0 | High | ☐ Not Started |
| EDG-014 | Query edges by type | P0 | Medium | ☐ Not Started |
| EDG-015 | Remove edge between blocks | P0 | High | ☐ Not Started |
| EDG-016 | Add edge with description metadata | P1 | Low | ☐ Not Started |
| EDG-017 | Remove all edges when block deleted | P0 | High | ☐ Not Started |

---

## Tier 7: UCL Basic Commands

| ID | Target | Priority | Risk | Status |
|----|--------|----------|------|--------|
| UCL-001 | Execute EDIT command to change text content | P0 | High | ☐ Not Started |
| UCL-002 | Execute EDIT with += operator (append text) | P0 | High | ☐ Not Started |
| UCL-003 | Execute EDIT with -= operator (remove text) | P1 | Medium | ☐ Not Started |
| UCL-004 | Execute EDIT to change metadata.label | P0 | Medium | ☐ Not Started |
| UCL-005 | Execute EDIT to add tags | P0 | Medium | ☐ Not Started |
| UCL-006 | Execute EDIT to remove tags | P1 | Medium | ☐ Not Started |
| UCL-007 | Execute EDIT with WHERE condition | P1 | Medium | ☐ Not Started |
| UCL-008 | Execute APPEND to add text block | P0 | High | ☐ Not Started |
| UCL-009 | Execute APPEND with label and tags | P0 | High | ☐ Not Started |
| UCL-010 | Execute APPEND at specific index | P0 | High | ☐ Not Started |
| UCL-011 | Execute APPEND code block | P0 | High | ☐ Not Started |
| UCL-012 | Execute APPEND with semantic role | P0 | High | ☐ Not Started |
| UCL-013 | Execute MOVE to new parent | P0 | High | ☐ Not Started |
| UCL-014 | Execute MOVE with AT position | P1 | Medium | ☐ Not Started |
| UCL-015 | Execute MOVE BEFORE sibling | P1 | Medium | ☐ Not Started |
| UCL-016 | Execute MOVE AFTER sibling | P1 | Medium | ☐ Not Started |
| UCL-017 | Execute DELETE single block | P0 | High | ☐ Not Started |
| UCL-018 | Execute DELETE CASCADE | P0 | High | ☐ Not Started |
| UCL-019 | Execute DELETE PRESERVE_CHILDREN | P1 | Medium | ☐ Not Started |
| UCL-020 | Execute DELETE WHERE condition | P1 | Medium | ☐ Not Started |
| UCL-021 | Execute PRUNE UNREACHABLE | P1 | Medium | ☐ Not Started |
| UCL-022 | Execute PRUNE UNREACHABLE DRY_RUN | P2 | Low | ☐ Not Started |
| UCL-023 | Execute PRUNE WHERE condition | P2 | Low | ☐ Not Started |

---

## Tier 8: UCL Advanced Commands

| ID | Target | Priority | Risk | Status |
|----|--------|----------|------|--------|
| UCL-024 | Execute FOLD with DEPTH limit | P1 | Medium | ☐ Not Started |
| UCL-025 | Execute FOLD with MAX_TOKENS limit | P1 | Medium | ☐ Not Started |
| UCL-026 | Execute FOLD with PRESERVE_TAGS | P2 | Low | ☐ Not Started |
| UCL-027 | Execute LINK to create edge | P0 | High | ☐ Not Started |
| UCL-028 | Execute LINK with metadata (confidence, description) | P1 | Medium | ☐ Not Started |
| UCL-029 | Execute UNLINK to remove edge | P0 | High | ☐ Not Started |
| UCL-030 | Execute SNAPSHOT CREATE | P1 | High | ☐ Not Started |
| UCL-031 | Execute SNAPSHOT RESTORE | P1 | High | ☐ Not Started |
| UCL-032 | Execute SNAPSHOT LIST | P1 | Medium | ☐ Not Started |
| UCL-033 | Execute SNAPSHOT DELETE | P1 | Medium | ☐ Not Started |
| UCL-034 | Execute SNAPSHOT DIFF between two snapshots | P2 | Low | ☐ Not Started |
| UCL-035 | Execute BEGIN TRANSACTION | P1 | High | ☐ Not Started |
| UCL-036 | Execute COMMIT transaction | P1 | High | ☐ Not Started |
| UCL-037 | Execute ROLLBACK transaction | P1 | High | ☐ Not Started |
| UCL-038 | Execute ATOMIC block with multiple commands | P0 | High | ☐ Not Started |
| UCL-039 | Verify ATOMIC rolls back on any failure | P0 | High | ☐ Not Started |
| UCL-040 | Chain multiple UCL commands in sequence | P0 | High | ☐ Not Started |

---

## Tier 9: UCL Syntax Edge Cases

| ID | Target | Priority | Risk | Status |
|----|--------|----------|------|--------|
| SYN-001 | Verify UCL parser rejects invalid command names | P0 | High | ☐ Not Started |
| SYN-002 | Verify UCL parser rejects malformed block IDs | P0 | High | ☐ Not Started |
| SYN-003 | Test UCL with special characters in strings | P0 | High | ☐ Not Started |
| SYN-004 | Test UCL with multiline string content | P0 | High | ☐ Not Started |
| SYN-005 | Test UCL with escaped quotes in strings | P0 | Medium | ☐ Not Started |
| SYN-006 | Test UCL with Unicode content | P0 | Medium | ☐ Not Started |
| SYN-007 | Test UCL with very long strings (10KB+) | P1 | Medium | ☐ Not Started |
| SYN-008 | Verify meaningful error on wrong parameter order | P0 | High | ☐ Not Started |
| SYN-009 | Verify meaningful error on missing required params | P0 | High | ☐ Not Started |
| SYN-010 | Verify case-insensitive command names | P1 | Low | ☐ Not Started |
| SYN-011 | Test STRUCTURE section parsing | P1 | Medium | ☐ Not Started |
| SYN-012 | Test BLOCKS section parsing | P1 | Medium | ☐ Not Started |

---

## Tier 10: Agent Traversal - Session Management

| ID | Target | Priority | Risk | Status |
|----|--------|----------|------|--------|
| AGT-001 | Create agent traversal session | P0 | High | ☐ Not Started |
| AGT-002 | Verify session isolation (multiple sessions) | P0 | High | ☐ Not Started |
| AGT-003 | Close session and verify cleanup | P0 | High | ☐ Not Started |
| AGT-004 | Verify session timeout behavior | P1 | Medium | ☐ Not Started |
| AGT-005 | Configure session with custom limits | P1 | Medium | ☐ Not Started |
| AGT-006 | Verify session metrics are tracked | P1 | Low | ☐ Not Started |

---

## Tier 11: Agent Traversal - Navigation

| ID | Target | Priority | Risk | Status |
|----|--------|----------|------|--------|
| NAV-001 | Execute GOTO to navigate to block | P0 | High | ☐ Not Started |
| NAV-002 | Verify cursor position after GOTO | P0 | High | ☐ Not Started |
| NAV-003 | Execute BACK to return in history | P0 | High | ☐ Not Started |
| NAV-004 | Execute BACK with step count | P1 | Medium | ☐ Not Started |
| NAV-005 | Execute EXPAND DOWN with depth | P0 | High | ☐ Not Started |
| NAV-006 | Execute EXPAND UP with depth | P0 | High | ☐ Not Started |
| NAV-007 | Execute EXPAND BOTH directions | P1 | Medium | ☐ Not Started |
| NAV-008 | Execute EXPAND SEMANTIC | P1 | Medium | ☐ Not Started |
| NAV-009 | Execute EXPAND with MODE (FULL/PREVIEW/METADATA/IDS) | P1 | Medium | ☐ Not Started |
| NAV-010 | Execute EXPAND with ROLES filter | P1 | Low | ☐ Not Started |
| NAV-011 | Execute EXPAND with TAGS filter | P1 | Low | ☐ Not Started |
| NAV-012 | Execute FOLLOW edge type | P0 | Medium | ☐ Not Started |
| NAV-013 | Execute PATH between two blocks | P1 | Medium | ☐ Not Started |
| NAV-014 | Execute PATH with MAX length | P1 | Low | ☐ Not Started |
| NAV-015 | Execute VIEW on block | P0 | Medium | ☐ Not Started |
| NAV-016 | Execute VIEW NEIGHBORHOOD | P1 | Medium | ☐ Not Started |

---

## Tier 12: Agent Traversal - Search & Context

| ID | Target | Priority | Risk | Status |
|----|--------|----------|------|--------|
| SRC-001 | Execute FIND with ROLE filter | P0 | High | ☐ Not Started |
| SRC-002 | Execute FIND with TAG filter | P0 | High | ☐ Not Started |
| SRC-003 | Execute FIND with LABEL filter | P0 | High | ☐ Not Started |
| SRC-004 | Execute FIND with PATTERN regex | P0 | High | ☐ Not Started |
| SRC-005 | Execute FIND with combined filters | P1 | Medium | ☐ Not Started |
| SRC-006 | Execute SEARCH semantic query (if RAG available) | P2 | Medium | ☐ Not Started |
| CTX-001 | Execute CTX ADD for single block | P0 | High | ☐ Not Started |
| CTX-002 | Execute CTX ADD with RELEVANCE score | P1 | Medium | ☐ Not Started |
| CTX-003 | Execute CTX ADD with REASON | P1 | Medium | ☐ Not Started |
| CTX-004 | Execute CTX ADD RESULTS (from last search) | P1 | Medium | ☐ Not Started |
| CTX-005 | Execute CTX ADD CHILDREN | P1 | Medium | ☐ Not Started |
| CTX-006 | Execute CTX ADD PATH | P1 | Medium | ☐ Not Started |
| CTX-007 | Execute CTX REMOVE block | P0 | High | ☐ Not Started |
| CTX-008 | Execute CTX CLEAR | P0 | High | ☐ Not Started |
| CTX-009 | Execute CTX EXPAND DOWN | P1 | Medium | ☐ Not Started |
| CTX-010 | Execute CTX EXPAND with TOKENS limit | P1 | Medium | ☐ Not Started |
| CTX-011 | Execute CTX COMPRESS METHOD=TRUNCATE | P2 | Low | ☐ Not Started |
| CTX-012 | Execute CTX PRUNE MIN_RELEVANCE | P2 | Low | ☐ Not Started |
| CTX-013 | Execute CTX RENDER | P1 | Medium | ☐ Not Started |
| CTX-014 | Execute CTX RENDER FORMAT=MARKDOWN | P1 | Medium | ☐ Not Started |
| CTX-015 | Execute CTX RENDER FORMAT=SHORT_IDS | P1 | Medium | ☐ Not Started |
| CTX-016 | Execute CTX STATS | P1 | Medium | ☐ Not Started |
| CTX-017 | Execute CTX FOCUS to protect block from pruning | P2 | Low | ☐ Not Started |
| CTX-018 | Execute CTX FOCUS CLEAR | P2 | Low | ☐ Not Started |

---

## Tier 13: LLM Integration Utilities

| ID | Target | Priority | Risk | Status |
|----|--------|----------|------|--------|
| LLM-001 | Create IdMapper from document | P0 | High | ☐ Not Started |
| LLM-002 | Convert full block ID to short ID | P0 | High | ☐ Not Started |
| LLM-003 | Convert short ID back to full block ID | P0 | High | ☐ Not Started |
| LLM-004 | Shorten UCL commands using IdMapper | P0 | High | ☐ Not Started |
| LLM-005 | Expand shortened UCL back to full IDs | P0 | High | ☐ Not Started |
| LLM-006 | Verify round-trip: shorten then expand | P0 | High | ☐ Not Started |
| LLM-007 | Generate document structure for prompt | P0 | High | ☐ Not Started |
| LLM-008 | Build PromptBuilder with capabilities | P0 | High | ☐ Not Started |
| LLM-009 | Add custom rules to PromptBuilder | P1 | Medium | ☐ Not Started |
| LLM-010 | Enable short IDs mode in PromptBuilder | P0 | High | ☐ Not Started |
| LLM-011 | Build system prompt from PromptBuilder | P0 | High | ☐ Not Started |
| LLM-012 | Use preset: basic_editing | P1 | Medium | ☐ Not Started |
| LLM-013 | Use preset: structure_manipulation | P1 | Medium | ☐ Not Started |
| LLM-014 | Use preset: token_efficient | P1 | Medium | ☐ Not Started |
| LLM-015 | Estimate token savings from short IDs | P1 | Low | ☐ Not Started |

---

## Tier 14: Markdown Translation

| ID | Target | Priority | Risk | Status |
|----|--------|----------|------|--------|
| MD-001 | Parse simple Markdown to UCM document | P0 | High | ☐ Not Started |
| MD-002 | Parse Markdown headings (h1-h6) | P0 | High | ☐ Not Started |
| MD-003 | Parse Markdown paragraphs | P0 | High | ☐ Not Started |
| MD-004 | Parse Markdown code blocks with language | P0 | High | ☐ Not Started |
| MD-005 | Parse Markdown inline code | P1 | Medium | ☐ Not Started |
| MD-006 | Parse Markdown lists (ordered and unordered) | P0 | High | ☐ Not Started |
| MD-007 | Parse Markdown nested lists | P1 | Medium | ☐ Not Started |
| MD-008 | Parse Markdown tables | P0 | High | ☐ Not Started |
| MD-009 | Parse Markdown links | P1 | Medium | ☐ Not Started |
| MD-010 | Parse Markdown images | P1 | Medium | ☐ Not Started |
| MD-011 | Parse Markdown blockquotes | P1 | Medium | ☐ Not Started |
| MD-012 | Parse Markdown horizontal rules | P2 | Low | ☐ Not Started |
| MD-013 | Render UCM document to Markdown | P0 | High | ☐ Not Started |
| MD-014 | Verify Markdown round-trip preserves structure | P0 | High | ☐ Not Started |
| MD-015 | Verify Markdown round-trip preserves content | P0 | High | ☐ Not Started |

---

## Tier 15: HTML Translation

| ID | Target | Priority | Risk | Status |
|----|--------|----------|------|--------|
| HTM-001 | Parse simple HTML to UCM document | P1 | Medium | ☐ Not Started |
| HTM-002 | Parse HTML headings and paragraphs | P1 | Medium | ☐ Not Started |
| HTM-003 | Parse HTML code/pre blocks | P1 | Medium | ☐ Not Started |
| HTM-004 | Parse HTML tables | P1 | Medium | ☐ Not Started |
| HTM-005 | Parse HTML lists | P1 | Medium | ☐ Not Started |
| HTM-006 | Extract images from HTML | P2 | Low | ☐ Not Started |
| HTM-007 | Extract links from HTML | P2 | Low | ☐ Not Started |
| HTM-008 | Handle nested HTML structures | P2 | Medium | ☐ Not Started |

---

## Tier 16: CLI Operations

| ID | Target | Priority | Risk | Status |
|----|--------|----------|------|--------|
| CLI-001 | `ucp create` with title and output file | P0 | High | ☐ Not Started |
| CLI-002 | `ucp info` displays document metadata | P0 | Medium | ☐ Not Started |
| CLI-003 | `ucp validate` reports issues | P0 | High | ☐ Not Started |
| CLI-004 | `ucp block add` creates block | P0 | High | ☐ Not Started |
| CLI-005 | `ucp block get` retrieves block | P0 | High | ☐ Not Started |
| CLI-006 | `ucp block delete` removes block | P0 | High | ☐ Not Started |
| CLI-007 | `ucp block move` relocates block | P1 | Medium | ☐ Not Started |
| CLI-008 | `ucp block list` shows all blocks | P1 | Medium | ☐ Not Started |
| CLI-009 | `ucp edge add` creates edge | P1 | Medium | ☐ Not Started |
| CLI-010 | `ucp edge remove` deletes edge | P1 | Medium | ☐ Not Started |
| CLI-011 | `ucp edge list` shows edges | P1 | Medium | ☐ Not Started |
| CLI-012 | `ucp nav children` shows children | P1 | Medium | ☐ Not Started |
| CLI-013 | `ucp nav parent` shows parent | P1 | Medium | ☐ Not Started |
| CLI-014 | `ucp tree` displays hierarchy | P0 | Medium | ☐ Not Started |
| CLI-015 | `ucp find` searches blocks | P1 | Medium | ☐ Not Started |
| CLI-016 | `ucp import markdown` imports file | P0 | High | ☐ Not Started |
| CLI-017 | `ucp export markdown` exports to file | P0 | High | ☐ Not Started |
| CLI-018 | `ucp ucl exec` runs UCL commands | P0 | High | ☐ Not Started |
| CLI-019 | `ucp ucl parse` validates UCL syntax | P1 | Medium | ☐ Not Started |
| CLI-020 | `ucp llm id-map` creates ID mapping | P1 | Medium | ☐ Not Started |
| CLI-021 | Verify `--format json` output is valid JSON | P0 | High | ☐ Not Started |
| CLI-022 | Verify `--format text` output is readable | P1 | Low | ☐ Not Started |

---

## Tier 17: Cross-Platform SDK Parity

| ID | Target | Priority | Risk | Status |
|----|--------|----------|------|--------|
| PAR-001 | Document.create() produces same ID across platforms | P0 | High | ☐ Not Started |
| PAR-002 | add_block returns same block ID across platforms | P0 | High | ☐ Not Started |
| PAR-003 | Block content serializes identically | P0 | High | ☐ Not Started |
| PAR-004 | UCL execution produces same results | P0 | High | ☐ Not Started |
| PAR-005 | Edge operations behave identically | P0 | High | ☐ Not Started |
| PAR-006 | Validation returns same issues | P0 | High | ☐ Not Started |
| PAR-007 | Error types map to equivalent across platforms | P1 | Medium | ☐ Not Started |
| PAR-008 | Document JSON serialization is identical | P0 | High | ☐ Not Started |
| PAR-009 | IdMapper produces same short IDs | P0 | High | ☐ Not Started |
| PAR-010 | Token estimation is consistent | P1 | Medium | ☐ Not Started |

---

## Tier 18: Error Handling & Edge Cases

| ID | Target | Priority | Risk | Status |
|----|--------|----------|------|--------|
| ERR-001 | Handle non-existent block ID gracefully | P0 | High | ☐ Not Started |
| ERR-002 | Handle invalid block ID format | P0 | High | ☐ Not Started |
| ERR-003 | Handle duplicate label assignment | P1 | Medium | ☐ Not Started |
| ERR-004 | Handle cycle creation attempt | P0 | Critical | ☐ Not Started |
| ERR-005 | Handle delete of root block | P0 | High | ☐ Not Started |
| ERR-006 | Handle edge to non-existent target | P0 | High | ☐ Not Started |
| ERR-007 | Handle empty content in block | P1 | Medium | ☐ Not Started |
| ERR-008 | Handle very large content (1MB+) | P1 | Medium | ☐ Not Started |
| ERR-009 | Handle deeply nested structure (100+ levels) | P1 | Medium | ☐ Not Started |
| ERR-010 | Handle concurrent modifications | P2 | Medium | ☐ Not Started |
| ERR-011 | Verify error codes match documentation | P0 | High | ☐ Not Started |
| ERR-012 | Verify error messages include actionable suggestions | P1 | Medium | ☐ Not Started |

---

## Tier 19: Performance & Scale

| ID | Target | Priority | Risk | Status |
|----|--------|----------|------|--------|
| PRF-001 | Create document with 1,000 blocks (<1s) | P1 | Medium | ☐ Not Started |
| PRF-002 | Create document with 10,000 blocks (<10s) | P1 | Medium | ☐ Not Started |
| PRF-003 | Query by tag in 10K block document (<100ms) | P1 | Medium | ☐ Not Started |
| PRF-004 | Serialize 10K block document (<1s) | P1 | Medium | ☐ Not Started |
| PRF-005 | Deserialize 10K block document (<1s) | P1 | Medium | ☐ Not Started |
| PRF-006 | UCL execute 100 commands in sequence (<1s) | P1 | Medium | ☐ Not Started |
| PRF-007 | Agent traversal through 1K blocks (<500ms) | P1 | Medium | ☐ Not Started |
| PRF-008 | Memory usage scales linearly with blocks | P2 | Medium | ☐ Not Started |
| PRF-009 | Markdown parse of 100KB document (<1s) | P1 | Medium | ☐ Not Started |
| PRF-010 | Validate 10K block document (<500ms) | P2 | Low | ☐ Not Started |

---

## Tier 20: Developer Experience Assessment

| ID | Target | Priority | Risk | Status |
|----|--------|----------|------|--------|
| DX-001 | Evaluate time-to-first-document experience | P1 | Medium | ☐ Not Started |
| DX-002 | Evaluate API discoverability | P1 | Medium | ☐ Not Started |
| DX-003 | Evaluate error message quality | P0 | High | ☐ Not Started |
| DX-004 | Evaluate documentation completeness | P0 | High | ☐ Not Started |
| DX-005 | Evaluate example code quality | P1 | Medium | ☐ Not Started |
| DX-006 | Identify boilerplate reduction opportunities | P1 | Medium | ☐ Not Started |
| DX-007 | Assess UCL syntax learnability | P1 | Medium | ☐ Not Started |
| DX-008 | Assess debugging/troubleshooting experience | P1 | Medium | ☐ Not Started |
| DX-009 | Compare DX across Rust/Python/JS SDKs | P1 | Medium | ☐ Not Started |
| DX-010 | Identify missing convenience methods | P1 | Medium | ☐ Not Started |

---

## Tier 21: Industry Research & Comparison

| ID | Target | Priority | Risk | Status |
|----|--------|----------|------|--------|
| RES-001 | Research ProseMirror content model | P2 | Low | ☐ Not Started |
| RES-002 | Research Notion API block types | P2 | Low | ☐ Not Started |
| RES-003 | Research Roam Research bidirectional links | P2 | Low | ☐ Not Started |
| RES-004 | Research Slate.js data model | P2 | Low | ☐ Not Started |
| RES-005 | Research CRDT approaches (Yjs, Automerge) | P2 | Low | ☐ Not Started |
| RES-006 | Compare UCP block types to alternatives | P2 | Low | ☐ Not Started |
| RES-007 | Identify missing content types | P1 | Medium | ☐ Not Started |
| RES-008 | Identify missing edge types | P1 | Medium | ☐ Not Started |
| RES-009 | Evaluate UCL vs alternative DSLs | P2 | Low | ☐ Not Started |
| RES-010 | Document recommendations for UCP enhancements | P1 | Medium | ☐ Not Started |

---

## Summary

| Tier | Items | Focus Area |
|------|-------|------------|
| 1 | 8 | Installation & Setup |
| 2 | 10 | Document Lifecycle |
| 3 | 18 | Block Content Types |
| 4 | 12 | Block Metadata |
| 5 | 18 | Document Structure |
| 6 | 17 | Edges & Relationships |
| 7 | 23 | UCL Basic Commands |
| 8 | 17 | UCL Advanced Commands |
| 9 | 12 | UCL Syntax Edge Cases |
| 10 | 6 | Agent Session Management |
| 11 | 16 | Agent Navigation |
| 12 | 18 | Agent Search & Context |
| 13 | 15 | LLM Integration |
| 14 | 15 | Markdown Translation |
| 15 | 8 | HTML Translation |
| 16 | 22 | CLI Operations |
| 17 | 10 | SDK Parity |
| 18 | 12 | Error Handling |
| 19 | 10 | Performance |
| 20 | 10 | Developer Experience |
| 21 | 10 | Industry Research |
| **Total** | **277** | |

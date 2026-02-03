# SET-003 Understanding: Verify `ucp --help` displays all documented commands

## Objective
Verify that the `ucp --help` command displays all commands that are documented in `ucp-docs/ucp-cli/README.md`.

## Documentation Analysis

The CLI documentation (`ucp-docs/ucp-cli/README.md`) lists the following command surface:

| Category | Documented Commands |
|----------|---------------------|
| Document | `create`, `info`, `validate` |
| Block | `add`, `get`, `delete`, `move`, `list`, `update` |
| Edge | `add`, `remove`, `list` |
| Navigation | `nav children`, `nav parent`, `nav siblings`, `nav descendants` |
| Search | `find`, `orphans` |
| Structure | `tree`, `prune` |
| Transactions | `tx begin`, `tx commit`, `tx rollback`, `tx savepoint` |
| Snapshots | `snapshot create`, `snapshot restore`, `snapshot list`, `snapshot delete`, `snapshot diff` |
| Import/Export | `import markdown\|html`, `export markdown\|json` |
| UCL | `ucl exec`, `ucl parse` |
| Agent | `agent session create\|list\|close`, `goto`, `back`, `expand`, `follow`, `search`, `find`, `context add\|remove\|clear\|show`, `view` |
| LLM | `llm id-map`, `shorten-ucl`, `expand-ucl`, `prompt`, `context` |

## Success Criteria
- All documented top-level commands appear in `ucp --help`
- All documented subcommands appear in respective `ucp <command> --help`
- No missing or extra undocumented commands

## Test Approach
1. Capture `ucp --help` output
2. Capture all subcommand help outputs
3. Compare each category against documentation
4. Document any discrepancies

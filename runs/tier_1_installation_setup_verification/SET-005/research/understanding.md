# SET-005: Understanding Document

## Scope
Verify that Python `from ucp_content import Document` works as documented in the UCP mission brief.

## Expected Behavior
Per mission brief documentation:
```python
from ucp_content import Document
doc = Document.create()
print(doc.id)
```

## Actual Findings

### Finding #1: Package Name Discrepancy (DOC-001)
- **Pip package name**: `ucp-content` (hyphen)
- **Python module name**: `ucp` (underscore, no hyphen)
- **Documented import**: `from ucp_content import Document` (INCORRECT)
- **Actual working import**: `from ucp import Document`

The PyPI package `ucp-content` installs a module named `ucp`. Python module names cannot contain hyphens, so the package name and module name differ.

### Finding #2: Package Version Inconsistency
- **dist-info shows version**: 0.1.10
- **__init__.py shows version**: 0.1.9
- Minor version mismatch between metadata and code

## Success Criteria
1. Import `Document` class from the installed package
2. Call `Document.create()` successfully
3. Verify returned object has expected properties (`.id`)

## Test Implementation Plan
1. Test corrected import: `from ucp import Document`
2. Call `Document.create()` 
3. Verify object has `.id` attribute
4. Document the naming discrepancy as a documentation bug

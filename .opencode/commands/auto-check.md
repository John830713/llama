---
description: Verify INDEX chain integrity
---

## Chain structure

Every INDEX.md must have:

- **`## Forward links`** — links to child INDEX.md files (with paths)
- **`## Referenced by`** — links to parent files that reference this page

## Verification rules

1. **Forward link check** — for each `## Forward links` entry, the target path must exist on disk
2. **Backward link check** — for each `## Referenced by` entry, the parent file must exist and contain a matching `## Forward links` entry pointing back to this file
3. **Orphan check** — every INDEX.md in the chain must have at least one `## Referenced by` entry (except root INDEX.md)

## Entry point

Start from `D:\llama\INDEX.md` and follow all Forward links recursively. Every reachable INDEX.md must pass all three checks.

## Report format

```
✅ resources/reference/INDEX.md — forward OK, backward OK
❌ resources/tools/INDEX.md — Forward link target `foo/` missing
❌ resources/skills/INDEX.md — Referenced by `resources/INDEX.md` found, but no back-link
```

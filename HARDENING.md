<!-- markdownlint-disable -->

# Hardening Report: djdefi--cloc-action/4

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **djdefi--cloc-action/4** was hardened automatically. 2 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### permissions (severity: medium)

The workflow file '.github/workflows/cloc.yml' has no top-level 'permissions:' key and no job-level 'permissions:' key on any job. Without explicit permissions, the workflow inherits the repository's default token permissions, which may be broader than necessary. A minimal permissions block (e.g. 'permissions: read-all' or specific scopes) should be added.

Locations:

- `.github/workflows/cloc.yml:1`

### unpinned-uses (severity: high)

Two 'uses:' references in '.github/workflows/cloc.yml' are pinned to mutable tags or branch names rather than immutable 40-character commit SHAs, making the workflow vulnerable to supply-chain attacks if those refs are moved or compromised:
  1. 'uses: actions/checkout@v3' (line ~22) — pinned to tag 'v3'
  2. 'uses: djdefi/cloc-action@main' (line ~26) — pinned to branch 'main'
Each should be replaced with the full SHA of the intended commit, e.g. 'actions/checkout@<40-char-sha> # v3'.

Locations:

- `.github/workflows/cloc.yml:22`
- `.github/workflows/cloc.yml:26`

## Iteration Notes

### Iteration 1

**Fixes applied:** permissions, unpinned-uses

**Notes:**

Fixed .github/workflows/cloc.yml: (1) Added 'permissions: {}' at the top level to restrict the workflow token to no permissions. (2) Pinned 'actions/checkout@v3' to full SHA 'a37ce9120846195fa4ece8f58b268e6043cb2f26 # v3'. (3) Pinned 'djdefi/cloc-action@main' to full SHA '4f31c3e25371ff21880fa77aeb0925ce6fc0891b # main'.


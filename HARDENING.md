<!-- markdownlint-disable -->

# Hardening Report: djdefi--cloc-action/6

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **djdefi--cloc-action/6** was hardened automatically. 2 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

The workflow file .github/workflows/cloc.yml references actions by mutable tags/branches instead of full 40-character commit SHAs. Unpinned references are vulnerable to supply-chain attacks if the tag or branch is moved to a malicious commit. Failing references: 'actions/checkout@v4' (tag), 'djdefi/cloc-action@main' (branch, used twice). Each should be pinned to a full SHA, e.g. actions/checkout@<40-char-sha> # v4.

Locations:

- `.github/workflows/cloc.yml:22`
- `.github/workflows/cloc.yml:26`
- `.github/workflows/cloc.yml:30`

### missing-permissions (severity: medium)

The workflow file .github/workflows/cloc.yml has no top-level 'permissions:' key and the single job 'cloc' also has no job-level 'permissions:' key. Without explicit permissions, the workflow inherits the repository's default token permissions, which may be overly broad (e.g. write access to contents). A minimal permissions block such as 'permissions: read-all' or specific scopes (e.g. 'contents: read') should be added.

Locations:

- `.github/workflows/cloc.yml:1`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses, missing-permissions

**Notes:**

Fixed .github/workflows/cloc.yml: (1) Pinned all three action references to full 40-char commit SHAs — actions/checkout@v4 → @11d5960a326750d5838078e36cf38b85af677262, djdefi/cloc-action@main (both occurrences) → @4f31c3e25371ff21880fa77aeb0925ce6fc0891b — with inline tag/branch comments for readability. (2) Added a top-level 'permissions: contents: read' block, which is the minimum required for a workflow that only checks out code and counts lines.


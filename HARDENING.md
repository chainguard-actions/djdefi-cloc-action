<!-- markdownlint-disable -->

# Hardening Report: djdefi--cloc-action/7

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **djdefi--cloc-action/7** was hardened automatically. 2 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

The workflow file uses action references pinned to mutable tags/branches instead of immutable 40-character SHA digests. This exposes the workflow to supply-chain attacks if the referenced tag or branch is overwritten with malicious code. Failing references: `actions/checkout@v4` (line 22), `djdefi/cloc-action@main` (line 26), `djdefi/cloc-action@main` (line 30). Each should be pinned to a full commit SHA, e.g. `actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683 # v4`.

Locations:

- `.github/workflows/cloc.yml:22`
- `.github/workflows/cloc.yml:26`
- `.github/workflows/cloc.yml:30`

### missing-permissions (severity: medium)

The workflow file `.github/workflows/cloc.yml` has no top-level `permissions:` key and the only job (`cloc`) also has no job-level `permissions:` key. Without explicit permissions, the workflow runs with the default token permissions, which may be overly broad (e.g. write access to repository contents). A minimal `permissions:` block such as `contents: read` should be added at the top level or on the job.

Locations:

- `.github/workflows/cloc.yml:1`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses, missing-permissions

**Notes:**

Fixed both findings in .github/workflows/cloc.yml: (1) Pinned all three action references to full 40-character commit SHAs — actions/checkout@v4 → @11d5960a326750d5838078e36cf38b85af677262, and both djdefi/cloc-action@main → @4f31c3e25371ff21880fa77aeb0925ce6fc0891b — with inline tag comments for readability. (2) Added a top-level `permissions: contents: read` block to restrict the GITHUB_TOKEN to the minimum required permissions.


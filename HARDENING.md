<!-- markdownlint-disable -->

# Hardening Report: djdefi--cloc-action/5

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **djdefi--cloc-action/5** was hardened automatically. 2 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

The workflow file uses mutable tag/branch references instead of pinned full-length SHA commit hashes, making the workflow vulnerable to supply-chain attacks if those tags or branches are moved or compromised. Failing references:
- `uses: actions/checkout@v3` (line 21) — `@v3` is a mutable tag
- `uses: djdefi/cloc-action@main` (line 25) — `@main` is a mutable branch

Each should be replaced with a full 40-character hex SHA, e.g. `uses: actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683 # v3`.

Locations:

- `.github/workflows/cloc.yml:21`
- `.github/workflows/cloc.yml:25`

### missing-permissions (severity: medium)

The workflow file has no top-level `permissions:` key and the single job `cloc` also has no job-level `permissions:` key. Without explicit permissions, the workflow inherits the repository's default token permissions (which may be `write-all` for older repositories), granting broader access than necessary. A minimal explicit permissions block (e.g. `permissions: read-all` or specific scopes like `contents: read`) should be added at the top level or on the job.

Locations:

- `.github/workflows/cloc.yml:1`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses, missing-permissions

**Notes:**

Fixed hardened/action/.github/workflows/cloc.yml: (1) Pinned `actions/checkout@v3` to full SHA `f43a0e5ff2bd294095638e18286ca9a3d1956744` with `# v3` comment; (2) Pinned `djdefi/cloc-action@main` to full SHA `4f31c3e25371ff21880fa77aeb0925ce6fc0891b` with `# main` comment; (3) Added top-level `permissions: contents: read` block to restrict the GITHUB_TOKEN to the minimum required access.


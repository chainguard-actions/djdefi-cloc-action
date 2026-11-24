<!-- markdownlint-disable -->

# Hardening Report: djdefi--cloc-action/8

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **djdefi--cloc-action/8** was hardened automatically. 1 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### script-injection (severity: high)

The Docker action passes `${{ inputs.options }}` as runs.args, and the Dockerfile's ENTRYPOINT (`/usr/bin/dumb-init -- /entrypoint.sh`) hands it to entrypoint.sh as $1. The script then runs it through eval: `eval "cloc $(git rev-parse HEAD) $1" | tee -a cloc.txt`. eval re-parses the input as shell code, so metacharacters such as `;`, `|`, `&`, backticks and `$(...)` in the `options` input run arbitrary commands inside the container. Fix: drop eval and pass the options as separate words, e.g. `cloc "$(git rev-parse HEAD)" $1` with a shellcheck SC2086 directive, or parse them into a list with `set -f` (turns off glob expansion) and `set -- $1`.

Locations:

- `entrypoint.sh:4`

## Iteration Notes

### Iteration 1

**Fixes applied:** script-injection

**Notes:**

entrypoint.sh no longer uses eval. The options input ($1) is now split into separate arguments with xargs (POSIX sh, since the Alpine image has no bash). Like upstream's eval, this split respects quotes, but it never runs anything: ';', '|', '&', backticks and $(...) reach cloc as plain text. An xargs -r true check runs first, so an unmatched quote fails with an error instead of dropping arguments without notice. When options is empty, cloc runs with just the HEAD SHA. Output still goes to cloc.txt via tee, and runs.args in action.yml is unchanged. Not part of the finding: I also pinned the Dockerfile base image to alpine:3.23@sha256:469c9ea4... Known gap: eval used to expand '*' and $VAR in the options; these now reach cloc as plain text.


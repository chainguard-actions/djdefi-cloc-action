#!/usr/bin/env sh
# Trust workspace
git config --global --add safe.directory "$GITHUB_WORKSPACE"
HEAD_SHA="$(git rev-parse HEAD)"
export HEAD_SHA
if [ -n "$1" ]; then
  # Fail on an unmatched quote instead of silently dropping arguments.
  printf '%s' "$1" | xargs -r true >/dev/null || { echo "Invalid options: unmatched quote" >&2; exit 1; }
  # Quote-aware split of the options into separate arguments without eval:
  # shell metacharacters (; | & ` $(...)) are passed to cloc as literal text.
  printf '%s' "$1" | xargs -r sh -c 'cloc "$HEAD_SHA" "$@"' sh | tee -a cloc.txt
else
  cloc "$HEAD_SHA" | tee -a cloc.txt
fi

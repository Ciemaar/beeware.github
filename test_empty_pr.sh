#!/bin/bash
set -e

PR_BODY=""
REPO="foo/bar"
PR_NUMBER="1"

ERRORS=()

require() {
    if ! grep -qE -- "$1" <<< "$PR_BODY"; then
        ERRORS+=("$2")
    fi
}

require "^[[:space:]]*## PR Checklist:" "PR checklist absent."
require "^[[:space:]]*- \[\s*[xX]\s*\] I will abide by the BeeWare Code of Conduct" "The 'Code of Conduct' checkbox must be checked."

if [ ${#ERRORS[@]} -gt 0 ]; then
    echo "Failing due to ${#ERRORS[@]} errors:"
    for ERR in "${ERRORS[@]}"; do
        echo "- $ERR"
    done
    # exit 1
fi

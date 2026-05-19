#!/bin/bash
PR_BODY="Just a simple PR without checklist"

ERRORS=()

require() {
    if ! grep -qE -- "$1" <<< "$PR_BODY"; then
        echo "::error::$2"
        ERRORS+=("$2")
    fi
}

require "^[[:space:]]*## PR Checklist:" "PR checklist absent."

if [ ${#ERRORS[@]} -gt 0 ]; then
    echo "There are errors."
    # exit 1
fi

echo "Passed."

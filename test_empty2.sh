#!/bin/bash
PR_BODY="Some completely different PR body with no checklist"
grep -qE "^[[:space:]]*## PR Checklist:" <<< "$PR_BODY"
echo $?

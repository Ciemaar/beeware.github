#!/bin/bash
PR_BODY="Some other text
## PR Checklist:
- [x] Code of Conduct
"

grep -qE "^[[:space:]]*## PR Checklist:" <<< "$PR_BODY"
echo "Result: $?"

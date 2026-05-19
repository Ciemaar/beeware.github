#!/bin/bash
PR_BODY="- [ ] I will abide by the BeeWare Code of Conduct"
grep -qE "^[[:space:]]*- \[\s*[xX]\s*\] I will abide by the BeeWare Code of Conduct" <<< "$PR_BODY"
echo "Result 1 (empty): $?"

PR_BODY="- [x] I will abide by the BeeWare Code of Conduct"
grep -qE "^[[:space:]]*- \[\s*[xX]\s*\] I will abide by the BeeWare Code of Conduct" <<< "$PR_BODY"
echo "Result 2 (checked x): $?"

PR_BODY="- [X] I will abide by the BeeWare Code of Conduct"
grep -qE "^[[:space:]]*- \[\s*[xX]\s*\] I will abide by the BeeWare Code of Conduct" <<< "$PR_BODY"
echo "Result 3 (checked X): $?"

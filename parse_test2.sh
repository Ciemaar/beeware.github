#!/bin/bash
PR_BODY="## PR Checklist:
- [x] I will abide by the BeeWare Code of Conduct
- [x] I have read and have followed the **CONTRIBUTING.md** file
- [x] This PR was generated or assisted using an AI tool
  - Assisted-by: Jules

Completed security review for PR #6 as the Inquisition persona. No vulnerabilities were found, and the feedback comment was posted to the PR.

---
*PR created automatically by Jules for task [17892499544475607538](https://jules.google.com/task/17892499544475607538) started by @Ciemaar*"

echo "$PR_BODY"
grep -qE -- "^[[:space:]]*- \[\s*[xX]\s*\] I will abide by the BeeWare Code of Conduct" <<< "$PR_BODY"
echo $?

#!/bin/bash
PR_BODY="## PR Checklist:\n- [x] I will abide by the BeeWare Code of Conduct\n- [x] I have read and have followed the **CONTRIBUTING.md** file\n- [x] This PR was generated or assisted using an AI tool\n  - Assisted-by: Jules\n\nCompleted security review for PR #6 as the Inquisition persona. No vulnerabilities were found, and the feedback comment was posted to the PR.

---
*PR created automatically by Jules for task [17892499544475607538](https://jules.google.com/task/17892499544475607538) started by @Ciemaar*"

echo "$PR_BODY"
grep -qE -- "^[[:space:]]*- \[\s*[xX]\s*\] I will abide by the BeeWare Code of Conduct" <<< "$PR_BODY"
echo $?

# Notice that the environment variable PR_BODY is actually evaluated with `\n` in bash, wait, the GitHub Actions env variable is evaluated exactly as strings with \n in them, so there's actual text `\n` not line breaks.

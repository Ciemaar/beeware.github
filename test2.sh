PR_BODY="Update automated PR comment messages in \`pr-checklist.yml\` and \`towncrier-run.yml\` to match the BeeWare project's standard \"polite but direct\" tone, replacing informal greetings with more standard phrasing.

---
*PR created automatically by Jules for task [3468692564284994814](https://jules.google.com/task/3468692564284994814) started by @Ciemaar*
"
ERRORS=()
require() {
    if ! grep -qE -- "$1" <<< "$PR_BODY"; then
        echo "::error::$2"
        ERRORS+=("$2")
    fi
}
require "^[[:space:]]*## PR Checklist:" "PR checklist absent."
require "^[[:space:]]*- \[\s*[xX]\s*\] I will abide by the BeeWare Code of Conduct" "The 'Code of Conduct' checkbox must be checked."
require "^[[:space:]]*- \[\s*[xX]\s*\] I have read and have followed the \*\*CONTRIBUTING.md\*\* file" "The 'CONTRIBUTING.md' checkbox must be checked."
require "^[[:space:]]*- \[\s*[xX]?\s*\] This PR was generated or assisted using an AI tool" "The AI tool checkbox is missing."

if grep -qE -- "^[[:space:]]*- \[\s*[xX]\s*\] This PR was generated or assisted using an AI tool" <<< "$PR_BODY"; then
    require "^[[:space:]]*(-\s+)?Assisted-by:" "'Assisted-by:' line is missing."
fi

echo "Errors: ${ERRORS[@]}"

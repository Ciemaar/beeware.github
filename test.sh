PR_BODY="
## PR Checklist:
- [x] I will abide by the BeeWare Code of Conduct
- [x] I have read and have followed the **CONTRIBUTING.md** file
- [x] This PR was generated or assisted using an AI tool
  - Assisted-by: Jules
"
ERRORS=()
require() {
    if ! grep -qE -- "$1" <<< "$PR_BODY"; then
        echo "::error::$2"
        ERRORS+=("$2")
    fi
}
require "^[[:space:]]*## PR Checklist:" "Absent"
require "^[[:space:]]*- \[\s*[xX]\s*\] I will abide by the BeeWare Code of Conduct" "CoC"
require "^[[:space:]]*- \[\s*[xX]\s*\] I have read and have followed the \*\*CONTRIBUTING.md\*\* file" "CONTRIBUTING.md"
require "^[[:space:]]*- \[\s*[xX]?\s*\] This PR was generated or assisted using an AI tool" "AI tool"

if grep -qE -- "^[[:space:]]*- \[\s*[xX]\s*\] This PR was generated or assisted using an AI tool" <<< "$PR_BODY"; then
    require "^[[:space:]]*(-\s+)?Assisted-by:" "'Assisted-by:' line is missing."
fi

echo "Errors: ${ERRORS[@]}"

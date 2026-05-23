PR_BODY="## PR Checklist:
- [x] I will abide by the BeeWare Code of Conduct
- [x] I have read and have followed the **CONTRIBUTING.md** file
- [x] This PR was generated or assisted using an AI tool
  - Assisted-by: Jules"

if ! grep -qE -- "^[[:space:]]*- \[\s*[xX]\s*\] I will abide by the BeeWare Code of Conduct" <<< "$PR_BODY"; then
    echo "FAILED"
else
    echo "PASSED"
fi

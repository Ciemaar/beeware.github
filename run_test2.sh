PR_BODY="## PR Checklist:\n- [x] I will abide by the BeeWare Code of Conduct\n- [x] I have read and have followed the **CONTRIBUTING.md** file\n- [x] This PR was generated or assisted using an AI tool\n  - Assisted-by: Jules"

if ! grep -qE -- "^[[:space:]]*- \[\s*[xX]\s*\] I will abide by the BeeWare Code of Conduct" <<< "$PR_BODY"; then
    echo "FAILED"
else
    echo "PASSED"
fi

#!/bin/bash

ERRORS=0

echo "Testing YAML configurations..."

if ! grep -q "google-labs-jules" .github/workflows/run-agents.yml; then
    echo "ERROR: Missing bot actor exclusion in run-agents.yml"
    ERRORS=1
fi

if ! grep -q 'grep -q "PR created automatically by Jules"' .github/workflows/run-agents.yml; then
    echo "ERROR: Missing PR body bot exclusion in run-agents.yml"
    ERRORS=1
fi

if grep -q "include_commit_log: true" .github/workflows/fleet-review.yml; then
    echo "ERROR: include_commit_log is true in fleet-review.yml"
    ERRORS=1
fi

if ! grep -q "uses: ./.github/workflows/run-agents.yml" .github/workflows/fleet-review.yml; then
    echo "ERROR: run-agents workflow not used in fleet-review.yml"
    ERRORS=1
fi

if ! grep -q "uses: ./.github/actions/check-commits" .github/workflows/bedevere.yml; then
    echo "ERROR: check-commits action not used in bedevere.yml"
    ERRORS=1
fi

if [ $ERRORS -eq 0 ]; then
    echo "All tests passed!"
else
    echo "Tests failed!"
    false # exits with 1
fi

#!/bin/bash

ERRORS=0

echo "Testing YAML configurations..."

if ! grep -q "github.actor.*google-labs-jules" .github/workflows/check-secret.yml; then
    echo "ERROR: Missing bot exclusion in check-secret.yml"
    ERRORS=1
fi

if grep -q "include_commit_log: true" .github/workflows/fleet-review.yml; then
    echo "ERROR: include_commit_log is true in fleet-review.yml"
    ERRORS=1
fi

if ! grep -q "uses: ./.github/workflows/check-secret.yml" .github/workflows/fleet-review.yml; then
    echo "ERROR: check-secret workflow not used in fleet-review.yml"
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

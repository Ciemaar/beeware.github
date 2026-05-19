#!/bin/bash
set -e
COMMENT_ID=$(gh api repos/foo/bar/issues/1/comments --jq '.[] | select(.body | contains("<!-- pr-checklist-comment -->")) | .id' | head -n 1)
echo "COMMENT_ID: $COMMENT_ID"

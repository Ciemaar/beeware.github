#!/bin/bash
PR_BODY=""
grep -qE "something" <<< "$PR_BODY"
echo $?

#!/bin/bash
set -eo pipefail

function do_pipe() {
    yes | head -n 1 > /dev/null
}

do_pipe
echo "Done"

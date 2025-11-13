#!/usr/bin/bash
# example: auto_rerun nvim
if [ $# -eq 0 ]; then
    echo "Usage: rerun <command> [args...]"
    return 1
fi

while true; do
    # Run the command
    "$@"
done

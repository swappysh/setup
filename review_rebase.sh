#!/bin/bash

# Check if the user provided exactly one argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <rebase-head>"
    exit 1
fi

# Get the rebase head from the command-line argument
REBASE_HEAD=$1

# Start an interactive rebase from the specified commit
git rebase -i $REBASE_HEAD

# Walk through each commit
while true; do
    # Show the current commit details
    git show

    # Ask the user to accept or reject the commit
    read -p "Accept this commit? (y/n): " choice
    case "$choice" in
        y|Y )
            # If accepted, continue the rebase
            git rebase --continue
            ;;
        n|N )
            # If rejected, reset to the previous commit and continue the rebase
            git reset --hard HEAD^
            git rebase --continue
            ;;
        * )
            # If the user input is invalid, show an error message
            echo "Invalid choice"
            ;;
    esac

    # Check if there are more commits to review
    if git rebase --continue 2>/dev/null; then
        # If no more commits to rebase, break the loop
        break
    fi
done


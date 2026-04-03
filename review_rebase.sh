#!/bin/bash
set -euo pipefail

if [ $# -ne 1 ]; then
  echo "Usage: $0 <base-commit-or-ref>"
  exit 1
fi

base="$1"

echo "Deprecated helper: this script no longer rewrites history automatically."
echo "Review commits first with: git log --oneline --reverse \"${base}..HEAD\""
echo "If you still want to edit history, run: git rebase -i \"$base\""

read -r -p "Open the interactive rebase now? (y/N): " choice
case "$choice" in
  y|Y)
    git rebase -i "$base"
    ;;
  *)
    echo "Aborted."
    exit 1
    ;;
esac

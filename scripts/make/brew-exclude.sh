#!/bin/bash
# Removes packages listed in a Brewfile from the main Brewfile
set -euo pipefail

brewfile="${1:?Usage: brew-exclude.sh <Brewfile>}"

while IFS='"' read -r type name _; do
  type="${type%% *}"
  [ "$type" = "brew" ] && type="formula"
  [ -n "$type" ] && [ -n "$name" ] && brew bundle remove -g --"$type" "$name"
done < "$brewfile"

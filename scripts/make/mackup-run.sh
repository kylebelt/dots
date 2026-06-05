#!/bin/bash
# Usage: mackup-run.sh <action> [flags] [config_file]
# Checks if mackup storage dir exists before running
set -euo pipefail

action="${1:?Usage: mackup-run.sh <backup|restore> [flags] [config_file]}"
shift

flags=""
config=""
for arg in "$@"; do
  if [[ "$arg" == -* ]]; then
    flags="$flags $arg"
  else
    config="$arg"
  fi
done

cfg_path="${config:-$HOME/.dotfiles/private/mackup/mackup.cfg}"
[ -n "$config" ] && cfg_flag="-c $config" || cfg_flag=""

dir=$(awk -F= '/^path/{print $2}' "$cfg_path" | xargs)

if [ -d "$dir" ]; then
  mackup --force $action $cfg_flag $flags
else
  echo "${RED} Skipping mackup $action ($dir not found)${RESET}"
fi

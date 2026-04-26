#!/usr/bin/env bash

target="${1%% ->*}"

if [ -d "$target" ]; then
  eza --icons=always --tree --color=always --level=2 \
    -I '.DS_Store|.env|.venv|env|venv|node_modules' --git-ignore "$target"
elif file --mime-type "$target" | grep -qF image/; then
  chafa -f symbols -s "${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}" "$target"
elif file --mime-encoding "$target" | grep -qF binary; then
  LESSOPEN="|lesspipe.sh %s" less -f "$target" 2>/dev/null || file -b "$target"
else
  bat -n --color=always --line-range :500 "$target"
fi

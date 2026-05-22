#!/bin/bash
# Syncs mackup config with dotbot-managed files
# 1. Reads dotbot.yaml to find all linked paths
# 2. Generates dotbot_managed.cfg (custom mackup app listing those paths)
# 3. Finds built-in mackup apps that manage the same paths
# 4. Updates [applications_to_ignore] in mackup.cfg with conflicts
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
DOTBOT_CONFIG="$DOTFILES_DIR/dotbot.yaml"
MACKUP_DIR="$DOTFILES_DIR/private/mackup"
MACKUP_CFG="$MACKUP_DIR/mackup.cfg"
MANAGED_CFG="$MACKUP_DIR/applications/dotbot_managed.cfg"
MACKUP_APPS=$(echo "$(brew --prefix mackup)"/libexec/lib/python*/site-packages/mackup/applications)

# Step 1: Extract linked paths from dotbot.yaml
paths=$(sed -n 's|^[[:space:]]*~/\([^:]*\):.*|\1|p' "$DOTBOT_CONFIG" | sort -u)

# Step 2: Generate dotbot_managed.cfg
{
  echo "[application]"
  echo "name = dotbot_managed"
  echo ""
  echo "[configuration_files]"
  echo "$paths"
} >"$MANAGED_CFG"

# Step 3: Build search patterns
# Mackup uses [configuration_files] (relative to ~) and [xdg_configuration_files] (relative to ~/.config/)
# Strip .config/ prefix to match xdg_configuration_files entries, keep home-relative paths as-is
xdg_paths=$(echo "$paths" | sed -n 's|^\.config/\(.*\)|\1|p' | sed 's|/$||')
home_paths=$(echo "$paths" | grep -v '^\.config/' | sed 's|/$||' || true)

# Match at start of line to avoid substring false positives (each .cfg lists one path per line)
all_patterns=$(printf "%s\n" "$xdg_paths" "$home_paths" | grep -v '^$' | sort -u | sed 's|^|^|' | paste -sd'|' -)

# Find conflicting built-in apps (rg with fallback to grep)
if command -v rg &>/dev/null; then
  pattern_file=$(mktemp)
  printf "%s\n" "$xdg_paths" "$home_paths" | grep -v '^$' | sort -u | sed 's|^|^|' >"$pattern_file"
  conflicts=$(rg --no-ignore -l -f "$pattern_file" "$MACKUP_APPS"/ 2>/dev/null | xargs -I{} basename {} .cfg | sort -u || true)
  rm -f "$pattern_file"
else
  conflicts=$(grep -rl -E "$all_patterns" "$MACKUP_APPS"/ 2>/dev/null | xargs -I{} basename {} .cfg | sort -u || true)
fi

# Step 4: Update [applications_to_ignore] in mackup.cfg
# Also ignore apps managed by mackup-work.cfg to avoid duplicates
work_apps=$(awk '/\[applications_to_sync\]/{found=1;next} /^\[/{found=0} found && NF' "$MACKUP_DIR/mackup-work.cfg" 2>/dev/null || true)
ignore_list=$(printf "%s\n" "dotbot_managed" "$conflicts" $work_apps | sort -u)

sed -i '' '/\[applications_to_ignore\]/,$d' "$MACKUP_CFG"
{
  echo "[applications_to_ignore]"
  echo "$ignore_list"
} >>"$MACKUP_CFG"

echo "✓ Updated: $MANAGED_CFG"
echo "✓ Updated: $MACKUP_CFG"

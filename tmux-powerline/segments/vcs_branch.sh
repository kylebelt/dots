# shellcheck shell=bash
# VCS branch name and sync status indicator.

source "${TMUX_POWERLINE_DIR_LIB}/tmux_adapter.sh"

TMUX_POWERLINE_SEG_VCS_BRANCH_MAX_LEN="${TMUX_POWERLINE_SEG_VCS_BRANCH_MAX_LEN:-25}"
TMUX_POWERLINE_SEG_VCS_BRANCH_TRUNC="${TMUX_POWERLINE_SEG_VCS_BRANCH_TRUNC:-…}"

generate_segmentrc() {
  read -r -d '' rccontents <<EORC
export TMUX_POWERLINE_SEG_VCS_BRANCH_MAX_LEN="${TMUX_POWERLINE_SEG_VCS_BRANCH_MAX_LEN}"
export TMUX_POWERLINE_SEG_VCS_BRANCH_TRUNC="${TMUX_POWERLINE_SEG_VCS_BRANCH_TRUNC}"
EORC
  echo "$rccontents"
}

run_segment() {
  cd "$(tp_get_tmux_cwd)" || return 1
  git rev-parse --is-inside-work-tree &>/dev/null || return 0

  local branch
  branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
  [ -z "$branch" ] && return 0

  local max="$TMUX_POWERLINE_SEG_VCS_BRANCH_MAX_LEN"
  if [ "${#branch}" -gt "$max" ] && [[ "$branch" == */* ]]; then
    branch="${TMUX_POWERLINE_SEG_VCS_BRANCH_TRUNC}${branch##*/}"
  fi

  # Collect stats and write cache for vcs_stats segment
  local cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/tmux-powerline"
  local cache="${cache_dir}/vcs-$(tp_get_tmux_cwd | md5 -q)"
  [ -d "$cache_dir" ] || mkdir -p "$cache_dir"

  local changed=0 insertions=0 deletions=0 untracked=0 dirty=0
  local porcelain
  porcelain=$(git status --porcelain 2>/dev/null)

  if [ -n "$porcelain" ]; then
    local numstat
    numstat=$(git diff --numstat 2>/dev/null)
    if [ -n "$numstat" ]; then
      read -r changed insertions deletions <<<"$(echo "$numstat" | awk 'NF==3{c++;i+=$1;d+=$2}END{printf "%d %d %d",c,i,d}')"
    fi
    untracked=$(echo "$porcelain" | grep -c "^??")
    dirty=1
  fi
  echo "$changed $insertions $deletions $untracked" >"$cache"

  # Sync status
  local sync_icon sync_color
  if [ "$dirty" -eq 1 ]; then
    sync_icon="󱓎" sync_color="#[fg=${TMUX_POWERLINE_SEG_VCS_BRANCH_DIRTY_COLOR:-$TMUX_POWERLINE_CUR_SEGMENT_FG}]"
  elif [ "$(git log @{push}.. 2>/dev/null | wc -l)" -gt 0 ]; then
    sync_icon="󰛃" sync_color="#[fg=${TMUX_POWERLINE_SEG_VCS_BRANCH_PUSH_COLOR:-$TMUX_POWERLINE_CUR_SEGMENT_FG}]"
  elif [ -n "$(git diff --numstat HEAD "origin/${branch}" 2>/dev/null)" ]; then
    sync_icon="󰛀" sync_color="#[fg=${TMUX_POWERLINE_SEG_VCS_BRANCH_PULL_COLOR:-$TMUX_POWERLINE_CUR_SEGMENT_FG}]"
  else
    sync_icon="" sync_color="#[fg=${TMUX_POWERLINE_SEG_VCS_BRANCH_CLEAN_COLOR:-$TMUX_POWERLINE_CUR_SEGMENT_FG}]"
  fi

  local fg="${TMUX_POWERLINE_SEG_VCS_BRANCH_NAME_COLOR:+#[fg=${TMUX_POWERLINE_SEG_VCS_BRANCH_NAME_COLOR}]}"
  echo "${sync_color}${sync_icon} ${fg:-${sync_color}}${branch}"
}

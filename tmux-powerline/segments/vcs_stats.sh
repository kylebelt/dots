# shellcheck shell=bash
# VCS change counters: modified, insertions, deletions, untracked.
# Reads cached data written by vcs_branch segment.

source "${TMUX_POWERLINE_DIR_LIB}/tmux_adapter.sh"

run_segment() {
  cd "$(tp_get_tmux_cwd)" || return 1
  git rev-parse --is-inside-work-tree &>/dev/null || return 0

  local cache="${XDG_CACHE_HOME:-$HOME/.cache}/tmux-powerline/vcs-$(tp_get_tmux_cwd | md5 -q)"
  local changed=0 insertions=0 deletions=0 untracked=0

  if [ -f "$cache" ]; then
    read -r changed insertions deletions untracked <"$cache"
  else
    local porcelain
    porcelain=$(git status --porcelain 2>/dev/null)
    if [ -n "$porcelain" ]; then
      local numstat
      numstat=$(git diff --numstat 2>/dev/null)
      if [ -n "$numstat" ]; then
        read -r changed insertions deletions <<<"$(echo "$numstat" | awk 'NF==3{c++;i+=$1;d+=$2}END{printf "%d %d %d",c,i,d}')"
      fi
      untracked=$(echo "$porcelain" | grep -c "^??")
    fi
  fi

  [ "$changed" -eq 0 ] && [ "$insertions" -eq 0 ] && [ "$deletions" -eq 0 ] && [ "$untracked" -eq 0 ] && return 0

  local out=""
  [ "$changed" -gt 0 ] && out+="#[fg=${TMUX_POWERLINE_SEG_VCS_STATS_CHANGED_COLOR:-$TMUX_POWERLINE_CUR_SEGMENT_FG}] ${changed} "
  [ "$insertions" -gt 0 ] && out+="#[fg=${TMUX_POWERLINE_SEG_VCS_STATS_INS_COLOR:-$TMUX_POWERLINE_CUR_SEGMENT_FG}] ${insertions} "
  [ "$deletions" -gt 0 ] && out+="#[fg=${TMUX_POWERLINE_SEG_VCS_STATS_DEL_COLOR:-$TMUX_POWERLINE_CUR_SEGMENT_FG}] ${deletions} "
  [ "$untracked" -gt 0 ] && out+="#[fg=${TMUX_POWERLINE_SEG_VCS_STATS_UNTRACKED_COLOR:-$TMUX_POWERLINE_CUR_SEGMENT_FG}] ${untracked} "

  echo "${out% }"
}

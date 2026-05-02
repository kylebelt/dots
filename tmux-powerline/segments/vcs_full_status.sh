# shellcheck shell=bash
# All-in-one VCS status segment: branch, sync state, and change counters.

source "${TMUX_POWERLINE_DIR_LIB}/tmux_adapter.sh"

TMUX_POWERLINE_SEG_VCS_STATUS_MAX_LEN="${TMUX_POWERLINE_SEG_VCS_STATUS_MAX_LEN:-25}"
TMUX_POWERLINE_SEG_VCS_STATUS_TRUNC="${TMUX_POWERLINE_SEG_VCS_STATUS_TRUNC:-…}"

generate_segmentrc() {
  read -r -d '' rccontents <<EORC
export TMUX_POWERLINE_SEG_VCS_STATUS_MAX_LEN="${TMUX_POWERLINE_SEG_VCS_STATUS_MAX_LEN}"
export TMUX_POWERLINE_SEG_VCS_STATUS_TRUNC="${TMUX_POWERLINE_SEG_VCS_STATUS_TRUNC}"
EORC
  echo "$rccontents"
}

run_segment() {
  cd "$(tp_get_tmux_cwd)" || return 1
  git rev-parse --is-inside-work-tree &>/dev/null || return 0

  local branch
  branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
  [ -z "$branch" ] && return 0

  local max="$TMUX_POWERLINE_SEG_VCS_STATUS_MAX_LEN"
  if [ "${#branch}" -gt "$max" ]; then
    branch="${branch:0:$((max - 1))}${TMUX_POWERLINE_SEG_VCS_STATUS_TRUNC}"
  fi

  local changed=0 insertions=0 deletions=0 untracked=0
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

  local sync_icon sync_color
  if [ "$changed" -gt 0 ] || [ "$untracked" -gt 0 ]; then
    sync_icon="󱓎" sync_color="#[fg=${TMUX_POWERLINE_SEG_VCS_STATUS_DIRTY_COLOR:-$TMUX_POWERLINE_CUR_SEGMENT_FG}]"
  elif [ "$(git log @{push}.. 2>/dev/null | wc -l)" -gt 0 ]; then
    sync_icon="󰛃" sync_color="#[fg=${TMUX_POWERLINE_SEG_VCS_STATUS_PUSH_COLOR:-$TMUX_POWERLINE_CUR_SEGMENT_FG}]"
  elif [ -n "$(git diff --numstat HEAD "origin/${branch}" 2>/dev/null)" ]; then
    sync_icon="󰛀" sync_color="#[fg=${TMUX_POWERLINE_SEG_VCS_STATUS_PULL_COLOR:-$TMUX_POWERLINE_CUR_SEGMENT_FG}]"
  else
    sync_icon="" sync_color="#[fg=${TMUX_POWERLINE_SEG_VCS_STATUS_CLEAN_COLOR:-$TMUX_POWERLINE_CUR_SEGMENT_FG}]"
  fi

  local fg="#[fg=${TMUX_POWERLINE_SEG_VCS_STATUS_BRANCH_COLOR:-$TMUX_POWERLINE_CUR_SEGMENT_FG}]"
  local out="${sync_color}${sync_icon} ${fg}${branch}"

  [ "$changed" -gt 0 ] && out+=" #[fg=${TMUX_POWERLINE_SEG_VCS_STATUS_CHANGED_COLOR:-$TMUX_POWERLINE_CUR_SEGMENT_FG}] ${changed}"
  [ "$insertions" -gt 0 ] && out+=" #[fg=${TMUX_POWERLINE_SEG_VCS_STATUS_INS_COLOR:-$TMUX_POWERLINE_CUR_SEGMENT_FG}] ${insertions}"
  [ "$deletions" -gt 0 ] && out+=" #[fg=${TMUX_POWERLINE_SEG_VCS_STATUS_DEL_COLOR:-$TMUX_POWERLINE_CUR_SEGMENT_FG}] ${deletions}"
  [ "$untracked" -gt 0 ] && out+=" #[fg=${TMUX_POWERLINE_SEG_VCS_STATUS_UNTRACKED_COLOR:-$TMUX_POWERLINE_CUR_SEGMENT_FG}] ${untracked}"

  echo "$out"
}

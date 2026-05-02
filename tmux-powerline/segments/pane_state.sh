# shellcheck shell=bash
# Segment that shows zoom & copy mode state of the current pane.
# Both indicators are independent and can appear side by side.
# Uses tmux conditionals (#{?}) so state updates in real time.

ZOOM_MODE_TEXT_DEFAULT=" "
ZOOM_MODE_TEXT_COLOR_DEFAULT="$TMUX_POWERLINE_CUR_SEGMENT_FG"

COPY_MODE_TEXT_DEFAULT=" "
COPY_MODE_TEXT_COLOR_DEFAULT="$TMUX_POWERLINE_CUR_SEGMENT_FG"

SEPARATOR_TEXT_DEFAULT=" "

generate_segmentrc() {
  read -r -d '' rccontents <<EORC
# Zoom mode text & color overrides.
export TMUX_POWERLINE_SEG_PANE_STATE_ZOOM_MODE_TEXT="${ZOOM_MODE_TEXT_DEFAULT}"
export TMUX_POWERLINE_SEG_PANE_STATE_ZOOM_MODE_TEXT_COLOR=""
# Copy mode text & color overrides.
export TMUX_POWERLINE_SEG_PANE_STATE_COPY_MODE_TEXT="${COPY_MODE_TEXT_DEFAULT}"
export TMUX_POWERLINE_SEG_PANE_STATE_COPY_MODE_TEXT_COLOR=""
# Separator text override.
export TMUX_POWERLINE_SEG_PANE_STATE_SEPARATOR_TEXT="${SEPARATOR_TEXT_DEFAULT}"
EORC
  echo "$rccontents"
}

run_segment() {
  __process_settings

  local zoom_color="#[fg=${TMUX_POWERLINE_SEG_PANE_STATE_ZOOM_MODE_TEXT_COLOR}]"
  local copy_color="#[fg=${TMUX_POWERLINE_SEG_PANE_STATE_COPY_MODE_TEXT_COLOR}]"
  local sep="$TMUX_POWERLINE_SEG_PANE_STATE_SEPARATOR_TEXT"

  local zoom="${zoom_color}${TMUX_POWERLINE_SEG_PANE_STATE_ZOOM_MODE_TEXT}"
  local copy="${copy_color}${TMUX_POWERLINE_SEG_PANE_STATE_COPY_MODE_TEXT}"

  # Both use #{?} so tmux evaluates at render time.
  # When both active: "zoom sep copy". When one: just that one. When none: empty (segment hidden).
  local segment=""
  segment+="#{?window_zoomed_flag,"
  segment+="${zoom}#{?pane_in_mode,${sep}${copy},}"
  segment+=","
  segment+="#{?pane_in_mode,${copy},}"
  segment+="}"

  echo "$segment"
  return 0
}

__process_settings() {
  if [ -z "$TMUX_POWERLINE_SEG_PANE_STATE_ZOOM_MODE_TEXT" ]; then
    export TMUX_POWERLINE_SEG_PANE_STATE_ZOOM_MODE_TEXT="${ZOOM_MODE_TEXT_DEFAULT}"
  fi
  if [ -z "$TMUX_POWERLINE_SEG_PANE_STATE_ZOOM_MODE_TEXT_COLOR" ]; then
    export TMUX_POWERLINE_SEG_PANE_STATE_ZOOM_MODE_TEXT_COLOR="${ZOOM_MODE_TEXT_COLOR_DEFAULT}"
  fi
  if [ -z "$TMUX_POWERLINE_SEG_PANE_STATE_COPY_MODE_TEXT" ]; then
    export TMUX_POWERLINE_SEG_PANE_STATE_COPY_MODE_TEXT="${COPY_MODE_TEXT_DEFAULT}"
  fi
  if [ -z "$TMUX_POWERLINE_SEG_PANE_STATE_COPY_MODE_TEXT_COLOR" ]; then
    export TMUX_POWERLINE_SEG_PANE_STATE_COPY_MODE_TEXT_COLOR="${COPY_MODE_TEXT_COLOR_DEFAULT}"
  fi
  if [ -z "$TMUX_POWERLINE_SEG_PANE_STATE_SEPARATOR_TEXT" ]; then
    export TMUX_POWERLINE_SEG_PANE_STATE_SEPARATOR_TEXT="${SEPARATOR_TEXT_DEFAULT}"
  fi
}

# shellcheck shell=bash disable=SC2034

# COLORS
source "${TMUX_POWERLINE_DIR_USER_THEMES}/colors.sh"

CUSTOM_NUMBER="${XDG_CONFIG_HOME}/tmux-powerline/segments"

TMUX_POWERLINE_SEPARATOR_LEFT_BOLD=""
TMUX_POWERLINE_SEPARATOR_LEFT_THIN=""
TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD=""
TMUX_POWERLINE_SEPARATOR_RIGHT_THIN=""
TMUX_POWERLINE_SEPARATOR_THIN="|"

TMUX_POWERLINE_WINDOW_SEPARATOR_LEFT_BOLD=""
TMUX_POWERLINE_WINDOW_SEPARATOR_RIGHT_BOLD=""

# See Color formatting section below for details on what colors can be used here.
TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR=${TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR:-$thm_bg}
TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR=${TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR:-$thm_fg}
TMUX_POWERLINE_SEG_AIR_COLOR=$(tp_air_color)

TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR=${TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR:-$TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD}
TMUX_POWERLINE_DEFAULT_RIGHTSIDE_SEPARATOR=${TMUX_POWERLINE_DEFAULT_RIGHTSIDE_SEPARATOR:-$TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}

# Custom number function
_nerd_lookup() {
  local var="$1" icons="$2" result="$1"
  for i in {9..1}; do
    [ -z "$result" ] && result="${icons:i:1}" || result="#{?#{==:${var},${i}},${icons:i:1},${result}}"
  done
  echo "#{?#{==:${var},0},${icons:0:1},${result}}"
}

# Custom number declarations
_wnum=$(_nerd_lookup "#I" "0󰬺󰬻󰬼󰬽󰬾󰬿󰭀󰭁󰭂󰿩")
_pnum=$(_nerd_lookup "#{window_panes}" "󰎣󰎦󰎩󰎬󰎮󰎰󰎵󰎸󰎻󰎾")
_znum=$(_nerd_lookup "#{window_panes}" "󰎢󰎥󰎨󰎫󰎲󰎯󰎴󰎷󰎺󰎽")

# See `man tmux` for additional formatting options for the status line.
# The `format regular` and `format inverse` functions are provided as conveinences

# Window tab declarations

# Active tab
if [ -z "$TMUX_POWERLINE_WINDOW_STATUS_CURRENT" ]; then
  TMUX_POWERLINE_WINDOW_STATUS_CURRENT=(
    "#[$(tp_format regular)]"
    "#[fg=$teal]$TMUX_POWERLINE_WINDOW_SEPARATOR_LEFT_BOLD"
    "#[fg=$thm_bg bg=$teal bold]"
    " #{?window_bell_flag,󰂞 ,}${_wnum} #{?pane_in_mode, #{pane_current_command},#W}#[fg=$surface0]#{?window_zoomed_flag, ${_znum},#{?#{>:#{window_panes},1}, ${_pnum},}} "
    "#[$(tp_format regular)]"
    "#[fg=$teal bg=$thm_bg]"
    "$TMUX_POWERLINE_WINDOW_SEPARATOR_RIGHT_BOLD"
  )
fi

# shellcheck disable=SC2128
if [ -z "$TMUX_POWERLINE_WINDOW_STATUS_STYLE" ]; then
  TMUX_POWERLINE_WINDOW_STATUS_STYLE=(
    "$(tp_format regular)"
  )
fi

# Inactive tab
if [ -z "$TMUX_POWERLINE_WINDOW_STATUS_FORMAT" ]; then
  TMUX_POWERLINE_WINDOW_STATUS_FORMAT=(
    "#[$(tp_format regular)]"
    " #{?window_bell_flag,#[fg=$yellow]󰂞 ,}${_wnum} #{?pane_in_mode, #{pane_current_command},#W}#[fg=$overlay2]#{?window_zoomed_flag, ${_znum},#{?#{>:#{window_panes},1}, ${_pnum},}}#{?window_last_flag,#[fg=$thm_pink] 󰁯,} "
  )
fi

# Format: segment_name [background_color|default_bg_color] [foreground_color|default_fg_color] [non_default_separator|default_separator] [separator_background_color|no_sep_bg_color]
#                      [separator_foreground_color|no_sep_fg_color] [spacing_disable|no_spacing_disable] [separator_disable|no_separator_disable]
#
# * background_color and foreground_color. Color formatting (see `man tmux` for complete list):
#   * Named colors, e.g. black, red, green, yellow, blue, magenta, cyan, white
#   * Hexadecimal RGB string e.g. #ffffff
#   * 'default_fg_color|default_bg_color' for the default theme bg and fg color
#   * 'default' for the default tmux color.
#   * 'terminal' for the terminal's default background/foreground color
#   * The numbers 0-255 for the 256-color palette. Run `tmux-powerline/color-palette.sh` to see the colors.
# * non_default_separator - specify an alternative character for this segment's separator
#   * 'default_separator' for the theme default separator
# * separator_background_color - specify a unique background color for the separator
#   * 'no_sep_bg_color' for using the default coloring for the separator
# * separator_foreground_color - specify a unique foreground color for the separator
#   * 'no_sep_fg_color' for using the default coloring for the separator
# * spacing_disable - remove space on left, right or both sides of the segment:
#   * "no_spacing_disable" - don't disable spacing (default)
#   * "left_disable" - disable space on the left
#   * "right_disable" - disable space on the right
#   * "both_disable" - disable spaces on both sides
#
# * separator_disable - disables drawing a separator on this segment, very useful for segments
#   with dynamic background colours (eg tmux_mem_cpu_load):
#   * "no_separator_disable" - don't disable the separator (default)
#   * "separator_disable" - disables the separator
#
# Example segment with separator disabled and right space character disabled:
# "hostname 33 0 {TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD} 0 0 right_disable separator_disable"
#
# Example segment with spacing characters disabled on both sides but not touching the default coloring:
# "hostname 33 0 {TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD} no_sep_bg_color no_sep_fg_color both_disable"
#
# Example segment with changing the foreground color of the default separator:
# "hostname 33 0 default_separator no_sep_bg_color 120"
#
## Note that although redundant the non_default_separator, separator_background_color and
# separator_foreground_color options must still be specified so that appropriate index
# of options to support the spacing_disable and separator_disable features can be used.
# The default_* and no_* can be used to keep the default behaviour.

# shellcheck disable=SC1143,SC2128
if [ -z "$TMUX_POWERLINE_LEFT_STATUS_SEGMENTS" ]; then
  TMUX_POWERLINE_LEFT_STATUS_SEGMENTS=(
    "mode_indicator #{?client_prefix,$orange,$green} $base default_separator no_sep_bg_color no_sep_fg_color left_disable"
    # "hostname $watermelon $thm_bg"
    "pwd $blue $base default_separator no_sep_bg_color no_sep_fg_color"
    "vcs_branch $thm_gray"
    "pane_state $thm_bg $watermelon default_separator no_sep_bg_color no_sep_fg_color right_disable separator_disable"
    # "tmux_session_info $blue $thm_bg"
  )
fi

# shellcheck disable=SC1143,SC2128
if [ -z "$TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS" ]; then
  TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS=(
    "vcs_stats $thm_gray $lavender"
    "load $surface0 $green"
    # "cpu $surface0 $green"
    "battery $surface0 $green default_separator no_sep_bg_color no_sep_fg_color left_disable"
    # use these to have a single cohesive vcs branch + stats
    # "vcs_branch $thm_gray $lavender default_separator no_sep_bg_color no_sep_fg_color right_disable"
    # "vcs_stats $thm_gray $lavender default_separator no_sep_bg_color no_sep_fg_color left_disable"
  )
fi

# shellcheck shell=bash
# Default configuration file for tmux-powerline.

# Modeline {
#	 vi: foldmarker={,} foldmethod=marker foldlevel=0 tabstop=4 filetype=sh
# }

# General {

# Show which segment fails and its exit code.
export TMUX_POWERLINE_DEBUG_MODE_ENABLED="false"
# Create error log in tmux runtime temp dir.
export TMUX_POWERLINE_ERROR_LOGS_ENABLED="false"
# Only log specific scopes. Space separated list of scopes. Supported scopes: weather.sh lib/text_roll.sh lib/powerline.sh lib/colors.sh config/helpers.sh
export TMUX_POWERLINE_ERROR_LOGS_SCOPES=""
# Use patched font symbols.
export TMUX_POWERLINE_PATCHED_FONT_IN_USE="true"

# The theme to use.
export TMUX_POWERLINE_THEME="ccaio"
# Overlay directory to look for themes. There you can put your own themes outside the repo. Fallback will still be the "themes" directory in the repo.
export TMUX_POWERLINE_DIR_USER_THEMES="${XDG_CONFIG_HOME:-$HOME/.config}/tmux-powerline/themes"
# Overlay directory to look for segments. There you can put your own segments outside the repo. Fallback will still be the "segments" directory in the repo.
export TMUX_POWERLINE_DIR_USER_SEGMENTS="${XDG_CONFIG_HOME:-$HOME/.config}/tmux-powerline/segments"

# Source theme colors
# shellcheck source=./themes/colors.sh
source "${TMUX_POWERLINE_DIR_USER_THEMES}/colors.sh"

# The initial visibility of the status bar. Can be {"on", "off", "2"}. 2 will create two status lines: one for the window list and one with status bar segments.
export TMUX_POWERLINE_STATUS_VISIBILITY="on"
# In case of visibility = 2, where to display window status and where left/right status bars.
# 0: window status top, left/right status bottom; 1: window status bottom, left/right status top
export TMUX_POWERLINE_WINDOW_STATUS_LINE=0
# The status bar refresh interval in seconds.
# Note that events that force-refresh the status bar (such as window renaming) will ignore this.
export TMUX_POWERLINE_STATUS_INTERVAL="1"
# The location of the window list. Can be {"absolute-centre, centre, left, right"}.
# Note that "absolute-centre" is only supported on `tmux -V` >= 3.2.
export TMUX_POWERLINE_STATUS_JUSTIFICATION="absolute-centre"

# The maximum length of the left status bar.
export TMUX_POWERLINE_STATUS_LEFT_LENGTH="100"
# The maximum length of the right status bar.
export TMUX_POWERLINE_STATUS_RIGHT_LENGTH="100"

# The separator to use between windows on the status bar.
export TMUX_POWERLINE_WINDOW_STATUS_SEPARATOR=""

# Uncomment these if you want to enable tmux bindings for muting (hiding) one of the status bars.
# E.g. this example binding would mute the left status bar when pressing <prefix> followed by Ctrl-[
export TMUX_POWERLINE_MUTE_LEFT_KEYBINDING="C-["
export TMUX_POWERLINE_MUTE_RIGHT_KEYBINDING="C-]"
# }

# battery.sh {
export TMUX_POWERLINE_SEG_BATTERY_TYPE="percentage"

export TMUX_POWERLINE_SEG_BATTERY_NUM_HEARTS="5"

export TMUX_POWERLINE_SEG_BATTERY_THRESH_LOW="20"
export TMUX_POWERLINE_SEG_BATTERY_COLOR_LOW="$red"
export TMUX_POWERLINE_SEG_BATTERY_THRESH_MED="40"
export TMUX_POWERLINE_SEG_BATTERY_COLOR_MED="$peach"
export TMUX_POWERLINE_SEG_BATTERY_COLOR_HIGH="$green"
export TMUX_POWERLINE_SEG_BATTERY_COLOR_CHARGING="$teal"

export TMUX_POWERLINE_SEG_BATTERY_CHARGED_ICON=""
# export TMUX_POWERLINE_SEG_BATTERY_CHARGED_ICON="󰚥"

# }

# cpu.sh {
export TMUX_POWERLINE_SEG_CPU_VALUE="user"
export TMUX_POWERLINE_SEG_CPU_ICON=" "
export TMUX_POWERLINE_SEG_CPU_THRESH_LOW="30"
export TMUX_POWERLINE_SEG_CPU_COLOR_LOW="$green"
export TMUX_POWERLINE_SEG_CPU_THRESH_MED="60"
export TMUX_POWERLINE_SEG_CPU_COLOR_MED="$yellow"
export TMUX_POWERLINE_SEG_CPU_COLOR_HIGH="$red"
# }

# hostname.sh {
# Use short, long or custom format for the hostname. Can be {"short", "long", "custom"}.
export TMUX_POWERLINE_SEG_HOSTNAME_FORMAT="short"
# Custom name to be used when format is "custom"
export TMUX_POWERLINE_SEG_HOSTNAME_CUSTOM=""
# }

# kubernetes_context.sh {
# Kubernetes config context display mode {"name_namespace", "name", "namespace"}.
# export TMUX_POWERLINE_SEG_KUBERNETES_CONTEXT_DISPLAY_MODE="name_namespace"
# Kubernetes config context symbol.
# export TMUX_POWERLINE_SEG_KUBERNETES_CONTEXT_SYMBOL="󱃾"
# Kubernetes config context symbol colour.
# export TMUX_POWERLINE_SEG_KUBERNETES_CONTEXT_SYMBOL_COLOUR="255"
# Separator for display mode "name_namespace"
# TMUX_POWERLINE_SEG_KUBERNETES_CONTEXT_SEPARATOR="󰿟"
# }

# load.sh {
export TMUX_POWERLINE_SEG_LOAD_VALUE="1min"
export TMUX_POWERLINE_SEG_LOAD_ICON="󰊚 "
export TMUX_POWERLINE_SEG_LOAD_THRESH_LOW="100"
export TMUX_POWERLINE_SEG_LOAD_COLOR_LOW="$green"
export TMUX_POWERLINE_SEG_LOAD_THRESH_MED="200"
export TMUX_POWERLINE_SEG_LOAD_COLOR_MED="$yellow"
export TMUX_POWERLINE_SEG_LOAD_COLOR_HIGH="$red"
# }

# mem_used.sh {
# Memory icon
export TMUX_POWERLINE_SEG_MEM_USED_ICON=" "
# Measure unit of memory: "GB" or "MB".
# In context of this segment "1 GB" equals "2 ^ 30 bytes" and "1 MB" eqauls "2 ^ 20 bytes".
export TMUX_POWERLINE_SEG_MEM_USED_UNIT="GB"
# }

# mode_indicator.sh {

# Whether the normal & prefix mode section should be enabled. Should be {"true, "false"}.
export TMUX_POWERLINE_SEG_MODE_INDICATOR_NORMAL_AND_PREFIX_MODE_ENABLED="true"
# Normal mode text & color overrides. Defaults to "normal" & the segment foreground color set in the theme used.
export TMUX_POWERLINE_SEG_MODE_INDICATOR_NORMAL_MODE_TEXT="  #S"
export TMUX_POWERLINE_SEG_MODE_INDICATOR_NORMAL_MODE_TEXT_COLOR=""
# Prefix mode text & color overrides. Defaults to "prefix" & the segment foreground color set in the theme used.
export TMUX_POWERLINE_SEG_MODE_INDICATOR_PREFIX_MODE_TEXT="  #S"
export TMUX_POWERLINE_SEG_MODE_INDICATOR_PREFIX_MODE_TEXT_COLOR=""
# Whether the mouse mode section should be enabled. Should be {"true, "false"}.
export TMUX_POWERLINE_SEG_MODE_INDICATOR_MOUSE_MODE_ENABLED="false"
# Mouse mode text & color overrides. Defaults to "mouse" & the segment foreground color set in the theme used.
export TMUX_POWERLINE_SEG_MODE_INDICATOR_MOUSE_MODE_TEXT="mouse"
export TMUX_POWERLINE_SEG_MODE_INDICATOR_MOUSE_MODE_TEXT_COLOR=""
# Whether the copy mode section should be enabled. Should be {"true, "false"}.
export TMUX_POWERLINE_SEG_MODE_INDICATOR_COPY_MODE_ENABLED="false"
# Copy mode text & color overrides. Defaults to "copy" & the segment foreground color set in the theme used.
export TMUX_POWERLINE_SEG_MODE_INDICATOR_COPY_MODE_TEXT=""
export TMUX_POWERLINE_SEG_MODE_INDICATOR_COPY_MODE_TEXT_COLOR=""
# Suspend mode text & color overrides. Defaults to "SUSPEND" & the segment foreground color set in the theme used.
export TMUX_POWERLINE_SEG_MODE_INDICATOR_SUSPEND_MODE_TEXT="SUSPEND"
export TMUX_POWERLINE_SEG_MODE_INDICATOR_SUSPEND_MODE_TEXT_COLOR=""
# Separator text override. Defaults to " • ".
export TMUX_POWERLINE_SEG_MODE_INDICATOR_SEPARATOR_TEXT=" • "
# }

# pane_state.sh {
export TMUX_POWERLINE_SEG_PANE_STATE_ZOOM_MODE_TEXT=" zoom"
export TMUX_POWERLINE_SEG_PANE_STATE_ZOOM_MODE_TEXT_COLOR=""
export TMUX_POWERLINE_SEG_PANE_STATE_COPY_MODE_TEXT=" copy"
export TMUX_POWERLINE_SEG_PANE_STATE_COPY_MODE_TEXT_COLOR=""
export TMUX_POWERLINE_SEG_PANE_STATE_SEPARATOR_TEXT=" 󰇙 "
# }

# pwd.sh {
# Maximum length of output.
export TMUX_POWERLINE_SEG_PWD_MAX_LEN="15"
# }

# time.sh {
# date(1) format for the time. Americans might want to have "%I:%M %p".
export TMUX_POWERLINE_SEG_TIME_FORMAT="%H:%M"
# Change this to display a different timezone than the system default.
# Use TZ Identifier like "America/Los_Angeles"
# export TMUX_POWERLINE_SEG_TIME_TZ=""
# }

# tmux_continuum_save.sh {
# Path to the tmux-continuum git repo.
export TMUX_POWERLINE_SEG_TMUX_CONTINUUM_PATH="/Users/ccaio/.local/share/tmux/plugins/tmux-continuum"
# }

# tmux_continuum_status.sh {
# Path to the tmux-continuum git repo.
export TMUX_POWERLINE_SEG_TMUX_CONTINUUM_PATH="/Users/ccaio/.local/share/tmux/plugins/tmux-continuum"
# Message to perfix the status indication with.
export TMUX_POWERLINE_SEG_TMUX_CONTINUUM_PREFIX="󰛤 "
# }

# tmux_session_info.sh {
# Session info format to feed into the command: tmux display-message -p
# For example, if FORMAT is '[ #S ]', the command is: tmux display-message -p '[ #S ]'
export TMUX_POWERLINE_SEG_TMUX_SESSION_INFO_FORMAT="#S"
# }

# vcs_branch.sh {

# Branch name max length
export TMUX_POWERLINE_SEG_VCS_BRANCH_MAX_LEN="10"

# Branch name color. Leave empty to use status color
export TMUX_POWERLINE_SEG_VCS_BRANCH_NAME_COLOR=""

# Branch status colors. Omit to use theme color config
export TMUX_POWERLINE_SEG_VCS_BRANCH_CLEAN_COLOR="$lavender"
export TMUX_POWERLINE_SEG_VCS_BRANCH_DIRTY_COLOR="$orange"
export TMUX_POWERLINE_SEG_VCS_BRANCH_PUSH_COLOR="$purple"
export TMUX_POWERLINE_SEG_VCS_BRANCH_PULL_COLOR="$teal"
# }

# vcs_stats.sh {
export TMUX_POWERLINE_SEG_VCS_STATS_CHANGED_COLOR="$yellow"
export TMUX_POWERLINE_SEG_VCS_STATS_INS_COLOR="$green"
export TMUX_POWERLINE_SEG_VCS_STATS_DEL_COLOR="$red"
export TMUX_POWERLINE_SEG_VCS_STATS_UNTRACKED_COLOR="$overlay2"
# }

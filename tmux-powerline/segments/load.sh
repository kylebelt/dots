#!/usr/bin/env bash
# shellcheck shell=bash
# Load average with selectable period (1min/5min/15min) and dynamic text color by threshold.
# Thresholds compare (load / ncpu * 100) against percentage values.

generate_segmentrc() {
	read -r -d '' rccontents <<EORC
export TMUX_POWERLINE_SEG_LOAD_VALUE="1min"
export TMUX_POWERLINE_SEG_LOAD_ICON="󰊚 "
export TMUX_POWERLINE_SEG_LOAD_THRESH_LOW="50"
export TMUX_POWERLINE_SEG_LOAD_COLOR_LOW="#a1cd5e"
export TMUX_POWERLINE_SEG_LOAD_THRESH_MED="100"
export TMUX_POWERLINE_SEG_LOAD_COLOR_MED="#e3d18a"
export TMUX_POWERLINE_SEG_LOAD_COLOR_HIGH="#fc514e"
EORC
	echo "$rccontents"
}

run_segment() {
	local value="${TMUX_POWERLINE_SEG_LOAD_VALUE:-1min}"
	local icon="${TMUX_POWERLINE_SEG_LOAD_ICON:-󰊚 }"
	local thresh_low="${TMUX_POWERLINE_SEG_LOAD_THRESH_LOW:-50}"
	local thresh_med="${TMUX_POWERLINE_SEG_LOAD_THRESH_MED:-100}"
	local color_low="${TMUX_POWERLINE_SEG_LOAD_COLOR_LOW:-#a1cd5e}"
	local color_med="${TMUX_POWERLINE_SEG_LOAD_COLOR_MED:-#e3d18a}"
	local color_high="${TMUX_POWERLINE_SEG_LOAD_COLOR_HIGH:-#fc514e}"

	local loads load1 load5 load15
	loads=$(uptime | sed 's/.*averages\{0,1\}: *//')
	load1=$(echo "$loads" | awk -F'[, ]+' '{print $1}')
	load5=$(echo "$loads" | awk -F'[, ]+' '{print $2}')
	load15=$(echo "$loads" | awk -F'[, ]+' '{print $3}')

	local selected
	case "$value" in
		1min)  selected="$load1" ;;
		5min)  selected="$load5" ;;
		15min) selected="$load15" ;;
		*)     selected="$load1" ;;
	esac
	[ -z "$selected" ] && return 1

	local ncpu
	if tp_shell_is_macos; then
		ncpu=$(sysctl -n hw.ncpu)
	else
		ncpu=$(nproc)
	fi

	local load_pct
	load_pct=$(awk "BEGIN {printf \"%d\", ($selected / $ncpu) * 100}")

	local fg="$color_low"
	[ "$load_pct" -ge "$thresh_low" ] && fg="$color_med"
	[ "$load_pct" -ge "$thresh_med" ] && fg="$color_high"

	printf "#[fg=%s]%s%s" "$fg" "$icon" "$selected"
}

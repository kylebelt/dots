#!/usr/bin/env bash
# shellcheck shell=bash
# CPU usage with selectable value (user/sys/idle) and dynamic text color by threshold.

generate_segmentrc() {
	read -r -d '' rccontents <<EORC
export TMUX_POWERLINE_SEG_CPU_VALUE="user"
export TMUX_POWERLINE_SEG_CPU_ICON=" "
export TMUX_POWERLINE_SEG_CPU_THRESH_LOW="30"
export TMUX_POWERLINE_SEG_CPU_COLOR_LOW="#a1cd5e"
export TMUX_POWERLINE_SEG_CPU_THRESH_MED="60"
export TMUX_POWERLINE_SEG_CPU_COLOR_MED="#e3d18a"
export TMUX_POWERLINE_SEG_CPU_COLOR_HIGH="#fc514e"
EORC
	echo "$rccontents"
}

run_segment() {
	local value="${TMUX_POWERLINE_SEG_CPU_VALUE:-user}"
	local icon="${TMUX_POWERLINE_SEG_CPU_ICON:- }"
	local thresh_low="${TMUX_POWERLINE_SEG_CPU_THRESH_LOW:-30}"
	local thresh_med="${TMUX_POWERLINE_SEG_CPU_THRESH_MED:-60}"
	local color_low="${TMUX_POWERLINE_SEG_CPU_COLOR_LOW:-#a1cd5e}"
	local color_med="${TMUX_POWERLINE_SEG_CPU_COLOR_MED:-#e3d18a}"
	local color_high="${TMUX_POWERLINE_SEG_CPU_COLOR_HIGH:-#fc514e}"

	local cpus_line cpu_user cpu_system cpu_idle
	if tp_shell_is_linux; then
		cpus_line=$(top -b -n 1 | grep "Cpu(s)")
		cpu_user=$(echo "$cpus_line" | grep -o "[0-9]\+\(.[0-9]\+\)\? *us\(er\)\?" | awk '{print $1}')
		cpu_system=$(echo "$cpus_line" | grep -o "[0-9]\+\(.[0-9]\+\)\? *sys\?" | awk '{print $1}')
		cpu_idle=$(echo "$cpus_line" | grep -o "[0-9]\+\(.[0-9]\+\)\? *id\(le\)\?" | awk '{print $1}')
	elif tp_shell_is_macos; then
		cpus_line=$(top -e -l 1 | grep "CPU usage:" | sed 's/CPU usage: //')
		cpu_user=$(echo "$cpus_line" | awk '{print $1}' | sed 's/%//')
		cpu_system=$(echo "$cpus_line" | awk '{print $3}' | sed 's/%//')
		cpu_idle=$(echo "$cpus_line" | awk '{print $5}' | sed 's/%//')
	fi

	local selected
	case "$value" in
		user) selected="$cpu_user" ;;
		sys)  selected="$cpu_system" ;;
		idle) selected="$cpu_idle" ;;
		*)    selected="$cpu_user" ;;
	esac
	[ -z "$selected" ] && return 1

	local int_val="${selected%%.*}"
	local fg="$color_low"
	[ "$int_val" -ge "$thresh_low" ] && fg="$color_med"
	[ "$int_val" -ge "$thresh_med" ] && fg="$color_high"

	printf "#[fg=%s]%s%4.1f%%" "$fg" "$icon" "$selected"
}

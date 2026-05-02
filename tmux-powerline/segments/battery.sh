#!/usr/bin/env bash
# shellcheck shell=bash
# Battery segment with configurable thresholds and dynamic text color.

TMUX_POWERLINE_SEG_BATTERY_TYPE_DEFAULT="percentage"
TMUX_POWERLINE_SEG_BATTERY_NUM_HEARTS_DEFAULT=5

HEART_FULL="♥"
HEART_EMPTY="♡"
BATTERY_FULL="󱊣"
BATTERY_MED="󱊢"
BATTERY_EMPTY="󱊡"
BATTERY_CHARGE="󰂄"
ADAPTER="󰚥"

generate_segmentrc() {
	read -r -d '' rccontents <<EORC
export TMUX_POWERLINE_SEG_BATTERY_TYPE="${TMUX_POWERLINE_SEG_BATTERY_TYPE_DEFAULT}"
export TMUX_POWERLINE_SEG_BATTERY_NUM_HEARTS="${TMUX_POWERLINE_SEG_BATTERY_NUM_HEARTS_DEFAULT}"
export TMUX_POWERLINE_SEG_BATTERY_THRESH_LOW="25"
export TMUX_POWERLINE_SEG_BATTERY_COLOR_LOW="#fc514e"
export TMUX_POWERLINE_SEG_BATTERY_THRESH_MED="50"
export TMUX_POWERLINE_SEG_BATTERY_COLOR_MED="#e3d18a"
export TMUX_POWERLINE_SEG_BATTERY_COLOR_HIGH="#a1cd5e"
export TMUX_POWERLINE_SEG_BATTERY_COLOR_CHARGING="#7fdbca"
export TMUX_POWERLINE_SEG_BATTERY_CHARGED_ICON="󰚥"
EORC
	echo "$rccontents"
}

run_segment() {
	__process_settings

	local thresh_low="${TMUX_POWERLINE_SEG_BATTERY_THRESH_LOW:-25}"
	local thresh_med="${TMUX_POWERLINE_SEG_BATTERY_THRESH_MED:-50}"
	local color_low="${TMUX_POWERLINE_SEG_BATTERY_COLOR_LOW:-#fc514e}"
	local color_med="${TMUX_POWERLINE_SEG_BATTERY_COLOR_MED:-#e3d18a}"
	local color_high="${TMUX_POWERLINE_SEG_BATTERY_COLOR_HIGH:-#a1cd5e}"
	local color_charging="${TMUX_POWERLINE_SEG_BATTERY_COLOR_CHARGING:-#7fdbca}"
	local charged_icon="${TMUX_POWERLINE_SEG_BATTERY_CHARGED_ICON-󰚥}"

	if tp_shell_is_macos; then
		__battery_macos
	else
		__battery_linux
	fi
}

__pick_color() {
	local charge="$1" charging="$2"
	if [ "$charging" = "yes" ]; then
		echo "$color_charging"
		return
	fi
	local fg="$color_high"
	[ "$charge" -lt "$thresh_med" ] && fg="$color_med"
	[ "$charge" -lt "$thresh_low" ] && fg="$color_low"
	echo "$fg"
}

__pick_icon() {
	local charge="$1" charging="$2"
	if [ "$charging" = "yes" ]; then
		echo "$BATTERY_CHARGE"
		return
	fi
	if [ "$charge" -lt "$thresh_low" ]; then
		echo "$BATTERY_EMPTY"
	elif [ "$charge" -lt "$thresh_med" ]; then
		echo "$BATTERY_MED"
	else
		echo "$BATTERY_FULL"
	fi
}

__format_output() {
	local charge="$1" charging="$2"
	local fg icon output
	fg=$(__pick_color "$charge" "$charging")
	icon=$(__pick_icon "$charge" "$charging")

	case "$TMUX_POWERLINE_SEG_BATTERY_TYPE" in
		percentage) output="$icon $charge%" ;;
		cute)       output=$(__cutinate "$charge") ;;
		hearts)     output=$(__generate_hearts "$charge") ;;
	esac
	printf "#[fg=%s]%s" "$fg" "$output"
}

__battery_macos() {
	local charge extconnect fully_charged
	eval "$(ioreg -c AppleSmartBattery -w0 |
		grep -o '"[^"]*" = [^ ]*' |
		sed -e 's/= //g' -e 's/"//g' |
		awk '$1=="CurrentCapacity"{print "local curcap="$2}
		     $1=="MaxCapacity"{print "local maxcap="$2}
		     $1=="ExternalConnected"{print "extconnect="$2}
		     $1=="FullyCharged"{print "fully_charged="$2}')"

	charge=$(pmset -g batt | grep -o "[0-9][0-9]*%" | sed 's/%//')
	[ -z "$charge" ] && return 1

	if [[ ("$fully_charged" == "Yes" || "$charge" -eq 100) && "$extconnect" == "Yes" ]]; then
		[ -z "$charged_icon" ] && return 1
		printf "#[fg=%s]%s" "$color_charging" "$charged_icon"
		return 0
	fi

	local charging="no"
	[ "$extconnect" = "Yes" ] && charging="yes"
	__format_output "$charge" "$charging"
}

__battery_linux() {
	local total_full=0 total_now=0
	while read -r bat; do
		local full="$bat/charge_full" now="$bat/charge_now"
		[ ! -r "$full" ] && full="$bat/energy_full"
		[ ! -r "$now" ] && now="$bat/energy_now"
		if [ -r "$full" ] && [ -r "$now" ]; then
			total_full=$((total_full + $(cat "$full")))
			total_now=$((total_now + $(cat "$now")))
		fi
	done <<<"$(grep -l "Battery" /sys/class/power_supply/*/type 2>/dev/null | sed 's,/type$,,')"

	[ "$total_full" -eq 0 ] && return 1
	[ "$total_now" -gt "$total_full" ] && total_now=$total_full

	local charge=$((100 * total_now / total_full))
	local charging="no"
	local status_file
	for bat in /sys/class/power_supply/BAT*; do
		status_file="$bat/status"
		[ -r "$status_file" ] && grep -qi "charging" "$status_file" && charging="yes"
	done
	__format_output "$charge" "$charging"
}

__cutinate() {
	local perc=$1 inc=$((100 / TMUX_POWERLINE_SEG_BATTERY_NUM_HEARTS))
	for _unused in $(seq "$TMUX_POWERLINE_SEG_BATTERY_NUM_HEARTS"); do
		[ "$perc" -lt 99 ] && echo -n "$BATTERY_EMPTY" || echo -n "$BATTERY_FULL"
		echo -n " "
		perc=$((perc + inc))
	done
}

__generate_hearts() {
	local perc=$1 num=$TMUX_POWERLINE_SEG_BATTERY_NUM_HEARTS out=""
	for i in $(seq 1 "$num"); do
		[ "$perc" -ge $((i * 100 / num)) ] && out+="$HEART_FULL " || out+="$HEART_EMPTY "
	done
	echo "$out"
}

__process_settings() {
	[ -z "$TMUX_POWERLINE_SEG_BATTERY_TYPE" ] && export TMUX_POWERLINE_SEG_BATTERY_TYPE="$TMUX_POWERLINE_SEG_BATTERY_TYPE_DEFAULT"
	[ -z "$TMUX_POWERLINE_SEG_BATTERY_NUM_HEARTS" ] && export TMUX_POWERLINE_SEG_BATTERY_NUM_HEARTS="$TMUX_POWERLINE_SEG_BATTERY_NUM_HEARTS_DEFAULT"
}

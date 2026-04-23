# CD to current yazi directory when yazi quits
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# nvim configuration switcher
nvim_switch_configuration () {
  config="$(
    fd -d 3 -L --min-depth 2 --regex "init\.(lua|vim)" -p "${XDG_CONFIG_HOME:-$HOME/.config}" \
    | awk -F"${XDG_CONFIG_HOME:-$HOME/.config}/" '{sub(/nvims\//, ""); sub(/nvim/, "default"); sub(/\/init.*/, ""); print $NF}' \
    | fzf --border --exit-0 --height=~50% --layout=reverse --prompt ' Neovim configuration switcher  ')"
  if [[ -z $config ]]; then
    printf "%s\n" "No configuration selected."
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  else
    config="nvims/$config"
    alias nv="NVIM_APPNAME=$config nvim"
  fi
  NVIM_APPNAME=$config nvim "$@"
}

# Cache evals for faster loading
_cache_eval() {
  local cache="${XDG_CACHE_HOME}/zsh/${1}.zsh"
  local bin=${commands[$1]}  # no subshell, uses zsh's $commands hash

  if [[ ! -f $cache || $bin -nt $cache ]]; then
    "$@" >| $cache
  fi

  source $cache
}

# Delete up to symbol instead of space
backward-kill-to-symbol() {
  local WORDCHARS='*?[]~&;!#$%^(){}<>'
  zle backward-kill-word
}
zle -N backward-kill-to-symbol

# Append last prompt word (used in vim mode with opt+.)
function append-last-word { 
  ((++CURSOR)); 
  zle insert-last-word; 
}
zle -N append-last-word

# Sesh Sessions
function sesh-sessions() {
  {
    exec </dev/tty
    exec <&1
    local session
    session=$(sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
    zle reset-prompt > /dev/null 2>&1 || true
    [[ -z "$session" ]] && return
    sesh connect $session
  }
}
zle -N sesh-sessions

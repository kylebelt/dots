# SECTION: ZSH Options

setopt automenu menu_complete     # autocmp fist menu match
setopt extended_glob              # match ~ # ^
setopt autocd                     # type a dir to cd
setopt auto_param_slash           # when dir is complete add / instead of space
setopt no_case_glob no_case_match # make cmp case sensitive
setopt globdots                   # include dotfiles
setopt interactive_comments       # allow comments in shell

# Enable advanced move
autoload zmv

# SECTION: ZSH auto completion

typeset -g ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=30
typeset -g ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'
typeset -g ZSH_AUTOSUGGEST_MANUAL_REBIND=true
typeset -g ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# SECTION: Shell Options

typeset -x EDITOR='nvim'
typeset -x BROWSER='open'
typeset -x MANPAGER="sh -c 'col -bx | bat -p -l man'"

# SECTION: History management

HISTSIZE=50000
SAVEHIST=$HISTSIZE
HISTFILE=${XDG_CACHE_HOME}/zsh/zsh_history
setopt append_history inc_append_history share_history # Better history
setopt hist_ignore_space                               # Don't save space prefixed commands
setopt hist_ignore_all_dups hist_expire_dups_first     # Dups handling

# SECTION: Specific app/integration settings

# Python
typeset -x PYTHON_VENV_NAME=".venv"
typeset -x PYTHON_VENV_NAMES=($PYTHON_VENV_NAME .env venv env)
typeset -x PYTHON_AUTO_VRUN=true

# AWS
typeset -x SHOW_AWS_PROMPT=false # Fix AWS p10k
typeset -x AWS_PROFILE='default'

# Completion cache file
ZCOMPDUMP_FILE="${XDG_CACHE_HOME}/zsh/zcompdump"

# EZA Settings
_EZA_PARAMS=('--git' '--icons' '--group-directories-first' '--time-style=long-iso' '--color-scale-mode=fixed' '--no-quotes' '--hyperlink' '--ignore-glob' '.DS_Store')

# ZINIT Initialization
source ${HOMEBREW_REPOSITORY}/opt/zinit/zinit.zsh

# SECTION: FZF settings

# Defaults
typeset -x FZF_DEFAULT_COMMAND='fd --follow --hidden --strip-cwd-prefix --exclude .git --exclude node_modules --exclude .venv --exclude .env --exclude .DS_Store --exclude "*.pyc"'
typeset -x FZF_DEFAULT_OPTS="--multi --cycle --height=40% --preview-window=right:60% \
  --layout=reverse --info=right --prompt='❱ ' --pointer='▶' --marker='✓' --separator='┄' --padding=1 \
  --preview '~/.local/bin/fzf-preview {}' \
  --header '?:Preview | C-a:Select All | C-d/u:Scroll'
  --bind '?:toggle-preview,ctrl-a:select-all,ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up' \
  --bind 'tab:toggle+down,shift-tab:toggle+up'"

# CTRL+T
typeset -x FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND --type=file"
typeset -x FZF_CTRL_T_OPTS="--height=70% --preview-window=right:60%"

# ALT+C
typeset -x FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type=dir"

# TMUX
typeset -x FZF_TMUX_OPTS=" -p90%,65% "

# Nightfly
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --color bg:#011627 \
  --color bg+:#0e293f \
  --color border:#2c3043 \
  --color fg:#acb4c2 \
  --color fg+:#d6deeb \
  --color gutter:#0e293f \
  --color header:#82aaff \
  --color hl+:#f78c6c \
  --color hl:#f78c6c \
  --color info:#ecc48d \
  --color marker:#f78c6c \
  --color pointer:#ff5874 \
  --color prompt:#82aaff \
  --color spinner:#21c7a8
"

# Tokyo Dark Theme
# typeset -x FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
#   --highlight-line \
#   --info=inline-right \
#   --ansi \
#   --layout=reverse \
#   --border=none \
#   --color=bg+:#282934 \
#   --color=bg:#11121d \
#   --color=border:#27a1b9 \
#   --color=fg:#abb2bf \
#   --color=gutter:#16161e \
#   --color=header:#dfae67 \
#   --color=hl+:#7199ee \
#   --color=hl:#7199ee \
#   --color=info:#545c7e \
#   --color=marker:#ee6d85 \
#   --color=pointer:#ee6d85 \
#   --color=prompt:#7199ee \
#   --color=query:#abb2bf:regular \
#   --color=scrollbar:#27a1b9 \
#   --color=separator:#dfae67 \
#   --color=spinner:#ee6d85 \
# "

# SECTION: Claude Code

# Claude config Block
# Enable Bedrock integration
typeset -x CLAUDE_CODE_USE_BEDROCK=1
typeset -x AWS_REGION="us-east-1"

# Optional: Override the region for the small/fast model (Haiku)
typeset -x ANTHROPIC_SMALL_FAST_MODEL_AWS_REGION="us-east-2"

# Pin Models
typeset -x ANTHROPIC_DEFAULT_OPUS_MODEL='us.anthropic.claude-opus-4-6-v1'
typeset -x ANTHROPIC_DEFAULT_SONNET_MODEL='us.anthropic.claude-sonnet-4-6'
typeset -x ANTHROPIC_DEFAULT_HAIKU_MODEL='us.anthropic.claude-haiku-4-5-20251001-v1:0'

# SECTION: ZVM Config function
# Can't be standalone as it is read during resources
function zvm_config() {
  ZVM_INIT_MODE="sourcing"
  ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT # Starting with insert mode.
  ZVM_SYSTEM_CLIPBOARD_ENABLED=true
  ZVM_VI_HIGHLIGHT_FOREGROUND=#011627 # Hex value
  ZVM_VI_HIGHLIGHT_BACKGROUND=#ecc48d # Hex value
  ZVM_VI_HIGHLIGHT_EXTRASTYLE=bold

  local ncur=$(zvm_cursor_style $ZVM_NORMAL_MODE_CURSOR)
  local icur=$(zvm_cursor_style $ZVM_INSERT_MODE_CURSOR)

  # Append your custom color for your cursor
  ZVM_INSERT_MODE_CURSOR=$icur
  ZVM_NORMAL_MODE_CURSOR=$ncur'\e\e]12;#ecc48d\a'
}

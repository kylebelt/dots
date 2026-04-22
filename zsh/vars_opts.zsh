# SECTION: ZSH Options

setopt automenu menu_complete # autocmp fist menu match
setopt extended_glob # match ~ # ^
setopt autocd # type a dir to cd
setopt auto_param_slash # when dir is complete add / instead of space
setopt no_case_glob no_case_match # make cmp case sensitive
setopt globdots # include dotfiles
setopt interactive_comments # allow comments in shell

# SECTION: History management

HISTSIZE=50000
SAVEHIST=$HISTSIZE
HISTFILE=${XDG_CACHE_HOME}/zsh/zsh_history
setopt append_history inc_append_history share_history # Better history
setopt hist_ignore_space # Don't save space prefixed commands
setopt hist_ignore_all_dups hist_expire_dups_first # Dups handling

# SECTION: Specific app/integration settings

# Completion cache file
ZCOMPDUMP_FILE="${XDG_CACHE_HOME}/zsh/zcompdump"

# EZA Settings
_EZA_PARAMS=('--git' '--icons' '--group-directories-first' '--time-style=long-iso' '--color-scale-mode=fixed' '--no-quotes' '--hyperlink')

# ZINIT Initialization
source ${HOMEBREW_REPOSITORY}/opt/zinit/zinit.zsh

# SECTION: FZF settings

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git "
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
#
# Preview settings
export FZF_CTRL_T_OPTS="--preview 'if [ -d {} ]; then eza --icons=always --tree --color=always --level=2 {}; else bat -n --color=always --line-range :500 {}; fi'"
export FZF_ALT_C_OPTS="--preview 'eza --icons=always --tree --color=always {} | head -200'"

# fzf preview for tmux
export FZF_TMUX_OPTS=" -p90%,70% "

#  CTRL-R Conf (atuin fallback)
export FZF_CTRL_R_OPTS="--LAYOUT=REVERSE --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'
  --preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
 
# Tokyo Dark Theme
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --layout=reverse \
  --border=none \
  --color=bg+:#282934 \
  --color=bg:#11121d \
  --color=border:#27a1b9 \
  --color=fg:#abb2bf \
  --color=gutter:#16161e \
  --color=header:#dfae67 \
  --color=hl+:#7199ee \
  --color=hl:#7199ee \
  --color=info:#545c7e \
  --color=marker:#ee6d85 \
  --color=pointer:#ee6d85 \
  --color=prompt:#7199ee \
  --color=query:#abb2bf:regular \
  --color=scrollbar:#27a1b9 \
  --color=separator:#dfae67 \
  --color=spinner:#ee6d85 \
"
# SECTION: Claude Code

# Claude config Block
# Enable Bedrock integration
export CLAUDE_CODE_USE_BEDROCK=1
export AWS_REGION="us-east-1"

# Optional: Override the region for the small/fast model (Haiku)
export ANTHROPIC_SMALL_FAST_MODEL_AWS_REGION="us-east-2"

# Pin Models
export ANTHROPIC_DEFAULT_OPUS_MODEL='us.anthropic.claude-opus-4-6-v1'
export ANTHROPIC_DEFAULT_SONNET_MODEL='us.anthropic.claude-sonnet-4-6'
export ANTHROPIC_DEFAULT_HAIKU_MODEL='us.anthropic.claude-haiku-4-5-20251001-v1:0'

# SECTION: ZVM Config function
# Can't be standalone as it is read during resources
function zvm_config() {
  ZVM_INIT_MODE="sourcing"
  ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT # Starting with insert mode.
  ZVM_SYSTEM_CLIPBOARD_ENABLED=true
  ZVM_VI_HIGHLIGHT_FOREGROUND=#11121d           # Hex value
  ZVM_VI_HIGHLIGHT_BACKGROUND=#dfae67           # Hex value
  ZVM_VI_HIGHLIGHT_EXTRASTYLE=bold
}

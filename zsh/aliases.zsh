# SECTION: General Aliases

# Vim
alias {vimdiff,vd}="nvim -d"
alias {vim,vi}="nvim"
alias nvs="nvim_switch_configuration"
alias vrc="vim $XDG_CONFIG_HOME/nvim/"

# ZSH
alias {reload,zsource}="source $ZDOTDIR/.zshrc"
alias zrc="vim $ZDOTDIR/.zshrc"

# Replacements
alias cat="bat"
alias top="btm -b"
alias ps="procs --sortd cpu"
alias ping="gping"

# Shorthand and mispelling
alias kc="kiro-cli"
alias gg="lazygit"
alias tmus="tmux"
alias sclaude="cd ~/sandbox/ && claude"
alias path='echo -e ${PATH//:/\\n}'
alias fpath='echo -e ${FPATH//:/\\n}'

# SECTION: Suffix aliases
alias -s rc=$EDITOR
alias -s py=$EDITOR
alias -s conf=$EDITOR
alias -s toml=$EDITOR
alias -s md=$EDITOR
alias -s html=$BROWSER
alias -s yaml="bat -l yaml"
alias -s json="jless"

# SECTION: Global aliases

# Colorize help commands with bat
alias -g -- -h='-h | bat --language=help --style=plain'
alias -g -- --help='--help | bat --language=help --style=plain'

# Pipe aliases
alias -g NE='2> /dev/null'
alias -g DN='> /dev/null'
alias -g NUL='> /dev/null 2>&1'
alias -g C='| pbcopy'
alias -g F='| fzf'
alias -g B='| bat'

# SECTION: Directory hashes

hash -d wd=~/workdesk
hash -d sb=~/sandbox
hash -d dl=~/Downloads

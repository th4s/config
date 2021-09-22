# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# This is currently overriden by PROMPT_COMMAND, so we uncomment it here
#PS1='\[\033[38;5;33m\]\u\[\033[0m\]|\w$ '

# Set PATH
PATH="$PATH:$HOME/.local/bin"

# Always cd into folders in home folder, no matter where we are
CDPATH=.:~

# Set nvim as our editor
export EDITOR=/usr/bin/nvim

# Bat should display filename as footer
export BAT_PAGER="less -MRF"

# Clear terminal history
alias delhistory='cat /dev/null > ~/.bash_history && history -c'

# Some frequent shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ls='exa'
alias ll='exa -alF'
alias tree='exa -lF --tree --git-ignore'
alias gs='git status -sb'
alias ga='git add -A'
alias gd='git diff HEAD'
alias gl='git log'
alias open='xdg-open'

# Simple variant of locate
# shows path of a file 
function where() {
    find . -iname "*$1*"
}

# We can query the internet for awesome terminal command help
function cheat() {
    curl cht.sh/$1
}

# Lookup weather in city ...
function weather() {
    curl wttr.in/$1
}

# Replace capslock with additional CTRL
setxkbmap -option caps:ctrl_modifier

# Some hotkeys for tmux
alias t="tmux"
alias ta="t a -t"
alias tls="t ls"
alias tn="t new -t"

# Search through history with arrow keys
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# A simple calculator in terminal
calc() {
    echo "scale=3;$@" | bc -l
}

# Configure xclip
# copy to clipboard
alias xc="xclip -se c"
# copy to pirmary buffer
alias xb="xclip"

# Source rust stuff
. "$HOME/.cargo/env"

# Source node-version manager
. "/usr/share/nvm/init-nvm.sh"

# Source git-prompt
. "$HOME/.git-prompt.sh"

# Set prompt_command to display git informationSource
PROMPT_COMMAND='__git_ps1 "\[\033[38;5;33m\]\u\[\033[0m\]|\w" "\\\$ "'

#Some git prompt modification
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1


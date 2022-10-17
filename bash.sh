# Install the following tools
# rust: ripgrep, git-delta, exa, bat, cargo-update,
# other: git, wget, tmux, zathura, neovim, xclip, fzf, bfs

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Replace capslock with additional CTRL
setxkbmap -option caps:ctrl_modifier

function switch-net() {
    wpa_cli list_networks
    read -n 1 -p "Please select a network: " NETWORK
    wpa_cli select_network $NETWORK
} 

# Set PATH
PATH="$PATH:$HOME/.local/bin"

# Always cd into folders in home folder, no matter where we are
CDPATH=:~

# Do not store commands starting with space in bash history
HISTCONTROL="ignorespace"

# Set nvim as our editor
if [[ -x "$(command -v nvim)" ]]; then
    export EDITOR=/usr/bin/nvim
    alias n='nvim'
elif [[ -x "$(command -v vim)" ]]; then
    export EDITOR=/usr/bin/vim
    alias n='vim'
fi

# Set visual editor like editor
export VISUAL=$EDITOR

# Clear terminal history
alias delhistory='cat /dev/null > ~/.bash_history && history -c'

# Update rust
if [[ -d "$HOME/.cargo" ]]; then
    . "$HOME/.cargo/env"
    alias rsup='rustup update && cargo install-update --all'
    alias c='cargo'
    alias cc='c c'
fi

# Some frequent shortcuts
if [[ -x "$(command -v xdg-open)" ]]; then
    alias open='xdg-open'
fi

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias o='open'
alias ss='. ~/.bashrc'



# Make our google searches a little bit faster
function g() {
    open "https://google.com/search?q="$(printf "+%s" "$@")   
}

if [[ -x "$(command -v exa)" ]]; then
    alias ls='exa --icons'
    alias ll='exa -algF --icons'
    alias tree='exa -lgF --tree --git-ignore --icons'
fi

if [[ -x "$(command -v git)" ]]; then
    alias gs='git status -sb'
    alias ga='git add -A'
    alias gd='git diff HEAD'
    alias gl='git log'
    alias gitgraph="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - "`
    `"%C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)'"
fi

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

# Create private keys
function random_pk {
    cat /dev/urandom | tr -dc 'a-f0-9' | fold -w 64 | head -n $1
}

# Copy whole file, or lines A:B from a file to clipboard
if [[ -x "$(command -v bat)" && -x "$(command -v xclip)" ]]; then
    function lc() {
        if [[ "$#" -eq 1 ]]; then
            bat -pp $1 | xclip -se c
        else
            bat -pp -r $1 $2 | xclip -se c
        fi
    }
fi

# Diff a remote file against a local file
if [[ -x "$(command -v delta)" && -x "$(command -v wget)" ]]; then
    function rdiff() {
            mkdir -p /tmp/cmpr && cd /tmp/cmpr
            tmpfilename=$(sed 's:.*/::' <<< $1)
            wget -qO $tmpfilename $1 && cd - >/dev/null
            delta /tmp/cmpr/${tmpfilename} $2
        }
fi

# Count lines of code in a directory recursively for all files
# having a file ending
function loc() {
        find . -name "*.$1" | xargs wc -l | sort -nr
    }

# Some hotkeys for tmux
if [[ -x "$(command -v tmux)" ]]; then
    alias t="tmux"
    alias ta="t a -t"
    alias tls="t ls"
    alias tn="t new -t"
fi

# Search through history with arrow keys
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# A simple calculator in terminal
calc() {
    if [ $# -eq 0 ]; then
        # replace comma in numblcok with point on german keyboard
        xmodmap -e "keycode 91 mod2 = KP_Delete period"; bc -ql; xmodmap -e "keycode 91 mod2 = KP_Delete comma"
    else
        echo "scale=3;$@" | bc -l
    fi
}

# Configure xclip
if [[ -x "$(command -v xclip)" ]]; then
    # copy to clipboard
    alias xc="xclip -se c"
    # copy to pirmary buffer
    alias xb="xclip"
fi

# Source node-version manager
if [[ -d "/usr/share/nvm" ]]; then
    . "/usr/share/nvm/init-nvm.sh"
fi

# Load fzf stuff
if [[ -d "/usr/share/fzf" ]]; then
    . "/usr/share/fzf/completion.bash"
    . "/usr/share/fzf/key-bindings.bash"

    # We use an improved version of this function, because we use breadth-first
    # search by using bfs instead of find
    unset -f __fzf_cd__
    function __fzf_cd__() {
        local cmd dir
        cmd="${FZF_ALT_C_COMMAND:-"command bfs -L . -mindepth 1 \\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
            -o -type d -print 2> /dev/null | cut -b3-"}"
        dir=$(eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse --bind=ctrl-z:ignore $FZF_DEFAULT_OPTS $FZF_ALT_C_OPTS" $(__fzfcmd) +m) && printf 'cd -- %q' "$dir"
    }

    # Bind "Change Dir" to C-SPACE
    bind "$(bind -s | grep '^"\\ec"' | sed 's/\\ec/\\C- /')"
    FZF_COMPLETION_TRIGGER='--'
fi

# Source git-prompt and set PS1
if [[ -e "$HOME/.git-prompt.sh" ]]; then
    . "$HOME/.git-prompt.sh"
    
    # Set prompt_command to display git informationSource
    PROMPT_COMMAND='__git_ps1 "\[\033[38;5;33m\]\u@\h\[\033[0m\]\w" "\\\$ "'
    
    #Some git prompt modification
    GIT_PS1_SHOWCOLORHINTS=true
    GIT_PS1_SHOWUPSTREAM="auto"
    GIT_PS1_SHOWDIRTYSTATE=true
    GIT_PS1_SHOWSTASHSTATE=true
    GIT_PS1_SHOWUNTRACKEDFILES=true
else
    PS1='\[\033[38;5;33m\]\u@\h\[\033[0m\]\w$ '
fi

# Set bash tab complete behavior
bind "TAB:menu-complete"
bind "set show-all-if-ambiguous on"
bind "set menu-complete-display-prefix on"

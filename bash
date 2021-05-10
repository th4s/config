PS1='[\u|\w]\$'

# Clear terminal history
alias delhistory='cat /dev/null > ~/.bash_history && history -c'

# Some frequent shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias ll='ls -alF'
alias cat='bat'
alias gs='git status'
alias fu='sudo !!'

function cheat() {
    curl cht.sh/$1
}

function weather() {
    curl wttr.in/$1
}

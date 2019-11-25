#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

umask 22 # fix broken WSL umask

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

# Explorer alias
alias explorer='/mnt/c/Windows/explorer.exe'
alias open="explorer"

# # Docker alias
# alias docker='/mnt/c/Program\ Files/Docker/Docker/resources/bin/docker.exe'
# alias docker-compose='/mnt/c/Program\ Files/Docker/Docker/resources/bin/docker-compose.exe'

function winpath() {
    wslpath -m $(readlink -f "$1")
}

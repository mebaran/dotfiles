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

function winpath() {
    wslpath -m $(readlink -f "$1")
}

# Configure Virtualenvwrapper
export VIRTUALENVWRAPPER_PYTHON=`which python3`

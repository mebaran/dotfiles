#
# Defines environment variables.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

export GDK_SCALE=2
export GDK_DPI_SCALE=-1

# Configure R
export R_LIBS_USER=~/.R/
export GOPATH=~/.go

# Configure Sybase
if [[ -f ~/.sa_config.sh  ]]; then;
    source ~/.sa_config.sh
fi

# Source zshlocal file if exists
if [[ -f ~/.zshlocal ]]; then;
    source ~/.zshlocal
fi

if [[ -f ~/.cargo/env ]]; then;
    source ~/.cargo/env
fi


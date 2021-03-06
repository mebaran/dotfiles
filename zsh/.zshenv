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

# Configure WSL X
if [[ ! -z $WSL_INTEROP ]]; then
    export DISPLAY=$(grep -m 1 nameserver /etc/resolv.conf | awk '{print $2}'):0.0
else
    export DISPLAY=:0.0
fi
export LIBGL_ALWAYS_INDIRECT=1
export GDK_SCALE=2
export GDK_DPI_SCALE=-1

# Configure R
export R_LIBS_USER=~/.R/

# Configure Sybase
if [[ -f ~/.sa_config.sh  ]]; then;
    source ~/.sa_config.sh
fi

# Source zshlocal file if exists
if [[ -f ~/.zshlocal ]]; then;
    source ~/.zshlocal
fi

if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then;
    source ~/.nix-profile/etc/profile.d/nix.sh
fi

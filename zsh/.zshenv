# Defines environment variables.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

# Rust setup
if [[ -d $HOME/.cargo/bin ]]; then
    path=("$HOME/.cargo/bin" $path)
fi

# Go Setup
export GOPATH="$HOME/.go"
if [[ -d "$GOPATH/bin" ]]; then
    path=("$GOPATH/bin" $path)
fi

#GHCup setup
if [[ -d $HOME/.ghcup/bin ]]; then
    path=("$HOME/.ghcup/bin" $path)
fi

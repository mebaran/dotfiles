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

#Solana setup
if [[ -d $HOME/.local/share/solana/install/active_release/bin ]]; then;
    path=("$HOME/.local/share/solana/install/active_release/bin" $path)
fi

#Dotnet Tool setup
if [[ -d $HOME/.dotnet/tools ]]; then;
    path=("$HOME/.dotnet/tools" $path)
fi

if [[ -d $HOME/.npm-packages ]]; then;
    path=("$HOME/.npm-packages/bin" $path)
fi

#Bun setup (for the all in one Javascript distro)
if [[ -d $HOME/.bun ]]; then;
    export BUN_INSTALL="$HOME/.bun"
    path=("$BUN_INSTALL/bin" $path)
fi

#Brew Setup
if [[ -d /opt/homebrew/bin ]]; then;
    path=(/opt/homebrew/bin $path)
fi

if [[ -f $HOME/.zshlocal ]]; then;
    source $HOME/.zshlocal
fi

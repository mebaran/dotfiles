#
# Executes commands at login pre-zshrc.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

#
# Browser
#

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

#
# Editors
#

export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'

#
# Language
#

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

#
# Paths
#

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the list of directories that cd searches.
# cdpath=(
#   $cdpath
# )

# Set the list of directories that Zsh searches for programs.
path=(
  ~/bin
  ~/.local/bin
  $path
)


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

#
# Less
#

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X to enable it.
export LESS='-g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

# FZF
fcd() {
  local dir
  dir=$(fd ${1:-.} --type d --exclude .git | fzf --preview 'tree -C {} | head -n 100' +m) && cd "$dir"
}

fzp() {
  local file
  file=$(fzf --preview 'batcat --style=numbers --color=always --theme=TwoDark {} || cat {}' \
             --height=100% --layout=reverse --border \
             --preview-window=right:60%:wrap)
  if [[ -n "$file" ]]; then
    nvim "$file"
  fi
}


#ZSH local
if [[ -f $HOME/.zshlocal ]]; then;
    source $HOME/.zshlocal
fi

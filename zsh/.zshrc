# Install zgenom to initialize shell
if [ ! -d $HOME/.zgenom ]; then;
    echo "Installing zgenom"
    git clone https://github.com/jandamm/zgenom.git "${HOME}/.zgenom"
fi
source "${HOME}/.zgenom/zgenom.zsh"
zgenom autoupdate

if ! zgenom saved; then;

    # ohmyzsh plugins
    zgenom ohmyzsh
    zgenom ohmyzsh plugins/aliases
    zgenom ohmyzsh plugins/direnv
    zgenom ohmyzsh plugins/fzf
    zgenom ohmyzsh plugins/git
    zgenom ohmyzsh plugins/gitignore
    zgenom ohmyzsh plugins/history
    zgenom ohmyzsh plugins/python
    zgenom ohmyzsh plugins/ssh-agent
    zgenom ohmyzsh plugins/virtualenvwrapper
    zgenom ohmyzsh plugins/z

    # completions
    zgenom load zsh-users/zsh-completions
    zgenom load zdharma-continuum/fast-syntax-highlighting
    zgenom load nix-community/nix-zsh-completions
    zgenom load marlonrichert/zsh-autocomplete
    
    # other plugins
    zgenom load djui/alias-tips
    # zgenom load whjvenyl/fasd
    zgenom load supercrabtree/k
    zgenom load unixorn/autoupdate-zgenom

    # theme
    zgenom ohmyzsh themes/steeef

    # save all to init script
    zgenom save

    # # Compile your zsh files
    # zgenom compile "$HOME/.zprofile"
    # zgenom compile "$HOME/.zshrc"
    # zgenom compile "$HOME/.zshenv"

    # You can perform other "time consuming" maintenance tasks here as well.
    # If you use `zgenom autoupdate` you're making sure it gets
    # executed every 7 days.

    # rbenv rehash
fi

# Extra env vars for interactive computing
unsetopt AUTO_CD
setopt EXTENDED_GLOB
setopt AUTO_PUSHD
setopt HIST_IGNORE_ALL_DUPS

# SSH-agent config
zstyle ':omz:plugins:ssh-agent' identities ~/.ssh/id*~*.pub 

# Autocomplete config
zstyle ':autocomplete:*' min-input 999
bindkey '\t' menu-select "$terminfo[kcbt]" menu-select
bindkey -M menuselect '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete

# zoxide functions
whence zoxide &> /dev/null && eval "$(zoxide init --cmd d zsh)"

source "$HOME/.zsh_aliases"
if [[ -f "$HOME/.zsh_local" ]]; then;
    source "$HOME/.zsh_local";
fi

if [[ -d /opt/homebrew/share/zsh/site-functions/ ]]; then;
    fpath=(/opt/homebrew/share/zsh/site-functions/ $fpath)
fi

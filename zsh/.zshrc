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
    zgenom ohmyzsh plugins/python
    zgenom ohmyzsh plugins/ssh-agent
    zgenom ohmyzsh plugins/virtualenvwrapper

    # other plugins
    zgenom load djui/alias-tips
    zgenom load whjvenyl/fasd
    zgenom load supercrabtree/k
    zgenom load unixorn/autoupdate-zgenom

    # completions
    zgenom load marlonrichert/zsh-autocomplete
    zgenom load zsh-users/zsh-completions
    zgenom load zdharma-continuum/fast-syntax-highlighting

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

# Autocomplete config
zstyle ':autocomplete:*' min-input 99
bindkey '\t' menu-select "$terminfo[kcbt]" menu-select
bindkey -M menuselect '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete

source "$HOME/.zsh_aliases"
if [[ -f "$HOME/.zsh_local" ]]; then;
    source "$HOME/.zsh_local";
fi

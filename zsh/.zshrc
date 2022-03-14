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
    zgenom ohmyzsh plugins/ag
    zgenom ohmyzsh plugins/aliases
    zgenom ohmyzsh plugins/fasd
    zgenom ohmyzsh plugins/git
    zgenom ohmyzsh plugins/gitignore
    zgenom ohmyzsh plugins/history-substring-search
    zgenom ohmyzsh plugins/python
    zgenom ohmyzsh plugins/ssh-agent
    zgenom ohmyzsh plugins/virtualenvwrapper
    
    zgenom load supercrabtree/k

    # completions   
    zgenom load marlonrichert/zsh-autocomplete
    zgenom load zsh-users/zsh-completions

    zgenom ohmyzsh themes/steeef

    # save all to init script
    zgenom save

    # Compile your zsh files
    zgenom compile "$HOME/.zprofile"
    zgenom compile "$HOME/.zshrc"
    # You can perform other "time consuming" maintenance tasks here as well.
    # If you use `zgenom autoupdate` you're making sure it gets
    # executed every 7 days.

    # rbenv rehash
fi

# Extra env vars for interactive computing
unsetopt AUTO_CD
zstyle ':autocomplete:*' widget-style menu-select
zstyle ':autocomplete:*' recent-dirs fasd
zstyle ':autocomplete:*' min-input 100
export AWS_PROFILE="fastpay"
export VIRTUALENVWRAPPER_PYTHON="python3"

source "$HOME/.zsh_aliases"

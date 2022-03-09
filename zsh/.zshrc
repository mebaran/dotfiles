# Install zgenom to initialize shell
if [ ! -d $HOME/.zgenom ]; then;
    echo "Installing zgenom"
    git clone https://github.com/jandamm/zgenom.git "${HOME}/.zgenom"
fi
source "${HOME}/.zgenom/zgenom.zsh"
zgenom autoupdate

if ! zgenom saved; then;
    # completions   
    zgenom load zsh-users/zsh-syntax-highlighting
    zgenom load zsh-users/zsh-completions
    
    # ohmyzsh plugins
    zgenom ohmyzsh
    zgenom ohmyzsh plugins/aliases
    zgenom ohmyzsh plugins/gitignore
    zgenom ohmyzsh plugins/history-substring-search
    zgenom ohmyzsh plugins/python
    zgenom ohmyzsh plugins/ssh-agent
    zgenom ohmyzsh plugins/virtualenvwrapper    

    zgenom prezto
    zgenom prezto fasd 
    
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
export VIRTUALENVWRAPPER_PYTHON="python3"

source "$HOME/.zsh_aliases"
eval "$(starship init zsh)"

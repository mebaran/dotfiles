" Deoplete config
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1
set shortmess+=c
set completeopt-=preview

Plug 'ncm2/float-preview.nvim'

" Install additional completion sources (other than LSP configure elsewhere"
Plug 'wellle/tmux-complete.vim'

" Register command to configure deoplete after load."
function DeopleteSetup()
    call deoplete#custom#option('ignore_sources', {'_': ['buffer', 'around']})
    call deoplete#custom#option('min_pattern_length', 3)
endfunction
autocmd VimEnter * call DeopleteSetup()

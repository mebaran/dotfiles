"Deoplete config
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'ncm2/float-preview.nvim'
let g:deoplete#enable_at_startup = 1
set completeopt-=preview

"ALE LSP config
let g:ale_completion_enabled = 1
Plug 'dense-analysis/ale'
" Python setup
let g:ale_linters = {
\   'python': ['pyls', 'flake8', 'mypy'],
\   'r': ['languageserver', 'lintr']
\}


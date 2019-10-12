call plug#begin('~/.vim/plugged')

Plug 'roxma/nvim-yarp'

" AlE config
let g:ale_linters = {
\   'python': ['pyls'],
\   'r': ['R', '--slave', '-e', 'languageserver::run()']
\}
let g:ale_completion_enabled = 1
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_save = 1
Plug 'w0rp/ale'

Plug 'jalvesaq/Nvim-R'
Plug 'davidhalter/jedi-vim'

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-eunuch'

Plug 'kassio/neoterm'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'wsdjeg/FlyGrep.vim' 
Plug 'airblade/vim-gitgutter'  " show git changes to files in gutter
            
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tyrannicaltoucan/vim-deep-space'

call plug#end()

set number
set relativenumber
set hidden
set mouse=a

" themes
set background=dark
set termguicolors
colorscheme deep-space
let g:deepspace_italics=1
let g:airline_theme='deep_space'

" Tab and Indent configuration
set expandtab
set tabstop=4
set shiftwidth=4

set splitright  " i prefer splitting right and below
set splitbelow

set hlsearch  " highlight search and search while typing
set incsearch
set cpoptions+=x  " stay at seach item when <esc>

" easy split movement
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
"autoformat hotkey
noremap <F3> :Autoformat<CR>

" tabs:
nnoremap tn :tabnew<Space>
nnoremap tk :tabnext<CR>
nnoremap tj :tabprev<CR>
nnoremap th :tabfirst<CR>
nnoremap tl :tablast<CR>

"set completeopt=noinsert,menuone,noselect
set shortmess+=c
set noshowmode

autocmd FileType r,rdoc nnoremap <buffer> K :Rhelp <C-R><C-W><CR>

" Disable Jedi-vim autocompletion and enable call-signatures options
let g:jedi#auto_initialization = 1
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#popup_on_dot = 0
let g:jedi#completions_command = ""
let g:jedi#show_call_signatures = 0


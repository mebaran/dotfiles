call plug#begin('~/.vim/plugged')

Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-jedi'
Plug 'ncm2/ncm2-path'
Plug 'jalvesaq/Nvim-R'
Plug 'gaalcaras/ncm-R'

Plug 'davidhalter/jedi-vim'
Plug 'w0rp/ale'

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-eunuch'

Plug 'kassio/neoterm'
Plug 'chrisbra/csv.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'wsdjeg/FlyGrep.vim' 
Plug 'airblade/vim-gitgutter'  " show git changes to files in gutter
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'cohama/lexima.vim'

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

" NCM2
autocmd BufEnter * call ncm2#enable_for_buffer()
" :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect
set shortmess+=c
set noshowmode
" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new line.
" inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
" uncomment this block if you use vimtex for LaTex
" autocmd Filetype tex call ncm2#register_source({
"           \ 'name': 'vimtex',
"           \ 'priority': 8,
"           \ 'scope': ['tex'],
"           \ 'mark': 'tex',
"           \ 'word_pattern': '\w+',
"           \ 'complete_pattern': g:vimtex#re#ncm2,
"           \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
"           \ })
" use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

let g:ncm2#matcher = 'substrfuzzy'
set pumheight=5

autocmd FileType r,rdoc nnoremap <buffer> K :Rhelp <C-R><C-W><CR>

" Disable Jedi-vim autocompletion and enable call-signatures options
let g:jedi#auto_initialization = 1
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#popup_on_dot = 0
let g:jedi#completions_command = ""
let g:jedi#show_call_signatures = 0

" AlE config
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_save = 1

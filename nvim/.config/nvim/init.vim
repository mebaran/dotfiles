call plug#begin('~/.vim/plugged')

Plug 'roxma/nvim-yarp'

Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-path'
" Plug 'ncm2/ncm2-jedi' | Plug 'davidhalter/jedi-vim'
Plug 'ncm2/ncm2-vim' | Plug 'Shougo/neco-vim'
"Plug 'ncm2/ncm2-ultisnips' | Plug 'SirVer/ultisnips'

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
"Plug 'ncm2/float-preview.nvim'
"Plug 'w0rp/ale'

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-unimpaired'

" rmarkdown support
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-rmarkdown'

Plug 'chrisbra/NrrwRgn'
Plug 'Chiel92/vim-autoformat'
Plug 'junegunn/goyo.vim'
Plug 'kassio/neoterm'
Plug 'chrisbra/csv.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'wsdjeg/FlyGrep.vim' 

Plug 'airblade/vim-gitgutter'  " show git changes to files in gutter
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tyrannicaltoucan/vim-deep-space'

call plug#end()

let mapleader=" "

set number
set relativenumber
set hidden
set mouse=a
set signcolumn=yes

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

" autoformat hotkey
noremap <F3> :Autoformat<CR>
inoremap <F3> <Esc>:Autoformat<CR>

" hardcore mode
" noremap <Up>    <Nop>
" noremap <Down>  <Nop>
" noremap <Left>  <Nop>
" noremap <Right> <Nop>
" inoremap <Up>    <Nop>
" inoremap <Down>  <Nop>
" inoremap <Left>  <Nop>
" inoremap <Right> <Nop>

" buffers
let g:airline#extensions#tabline#buffer_idx_mode = 1

" NCM2
autocmd BufEnter * call ncm2#enable_for_buffer()
" :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect
set shortmess+=c
set noshowmode
" use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
let g:ncm2#matcher = 'substrfuzzy'
set pumheight=5

"Language client coverage
let g:LanguageClient_serverCommands = {
    \ 'java': ['jdtls', getcwd()],
    \ 'r': ['R', '--slave', '-e', 'languageserver::run()'],
    \ 'rmarkdown': ['R', '--slave', '-e', 'languageserver::run()'],
    \ 'python': ["pyls"]
    \ }
let g:LanguageClient_fzfContextMenu = 0
let g:LanguageClient_useVirtualText = 0

function SetLSPShortcuts()
  nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
  nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
  nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
  nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
  nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
  nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
  nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
  nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
  nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
  nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>

  nmap K <leader>lh
endfunction()

augroup LSP
  autocmd!
  autocmd FileType r,rmarkdown,python,java call SetLSPShortcuts()
augroup END

"Neoterm config
tnoremap <Esc> <C-\><C-n>
nmap gx <Plug>(neoterm-repl-send)
xmap gx <Plug>(neoterm-repl-send)
nmap gxx <Plug>(neoterm-repl-send-line)
let g:neoterm_autoscroll = 1
let g:neoterm_size = 16
let g:neoterm_direct_open_repl = 1
let g:neoterm_autoinsert = 1
let g:neoterm_default_mod = ':botright'

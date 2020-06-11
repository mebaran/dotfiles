" Basics
set nocompatible
set expandtab
set ts=4 sw=4
set hidden
set noshowmode
set signcolumn=yes
set splitright
set splitbelow

" Enable ftype
syntax on
filetype plugin indent on
set encoding=UTF-8

" Good numbers
set number relativenumber
set nu rnu

" Keybindings
let mapleader = " "

" Split navigation
tnoremap <Esc> <C-\><C-n>
tnoremap <C-w> <C-\><C-n><C-w>
inoremap <C-w> <Esc><C-w>

" Plugins
call plug#begin('~/.vim/plugged')
runtime themes.vim
for f in glob("~/.config/nvim/plugs/*.vim", 0, 1) | exe "source" f | endfor
call plug#end()

" Themes
set termguicolors
colorscheme deus


set nocompatible
set expandtab
set ts=4 sw=4
set hidden
set noshowmode
set signcolumn=yes

" Enable ftype

syntax on
filetype plugin indent on
set encoding=UTF-8

" Good numbers
set number relativenumber
set nu rnu

" Plugins
call plug#begin('~/.vim/plugged')
runtime themes.vim
for f in glob("~/.config/nvim/plugs/*.vim", 0, 1) | exe "source" f | endfor
call plug#end()

" Themes
set termguicolors
colorscheme seoul256 

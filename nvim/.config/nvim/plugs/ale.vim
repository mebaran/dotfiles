Plug 'dense-analysis/ale'
let g:airline#extensions#ale#enabled = 1
autocmd VimEnter * call deoplete#custom#source('ale', 'rank', 999)

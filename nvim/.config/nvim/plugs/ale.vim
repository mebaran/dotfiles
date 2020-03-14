Plug 'dense-analysis/ale'
let g:airline#extensions#ale#enabled = 1
autocmd VimEnter * call deoplete#custom#source('ale', 'rank', 999)

" Leader mappings
nmap <leader>ag <plug>(ale_go_to_definition)
nmap <leader>at <plug>(ale_go_to_type_definition)
nmap <leader>ah <plug>(ale_hover)
nmap <leader>ad <plug>(ale_documentation)
nmap <leader>ap <plug>(ale_detail)
nmap <leader>af <plug>(ale_fix)
nmap <leader>al <plug>(ale_lint)
nmap <leader>ar <plug>(ale_find_references)

" Quick mappings
nmap K <plug>(ale_hover)

"Move between linting errors
nmap ]r <plug>(ale_next_wrap)
nmap [r <plug>(ale_previous_wrap)

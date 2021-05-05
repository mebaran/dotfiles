Plug 'reedes/vim-pencil'
Plug 'reedes/vim-textobj-sentence'
Plug 'reedes/vim-textobj-quote'
Plug 'reedes/vim-lexical'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

augroup pencil
  autocmd!
  autocmd FileType txt,markdown,mkd call pencil#init() | lexical#init()
augroup END
      

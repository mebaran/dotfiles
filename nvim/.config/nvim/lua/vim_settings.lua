-- No Show
vim.o.showmode = false

-- Split management
vim.o.splitright = true
vim.o.splitbelow = true

--Set tab width and stop
vim.o.tabstop = 4
vim.o.shiftwidth = 0
vim.o.expandtab = true

--Incremental live completion (note: this is now a default on master)
vim.o.inccommand = 'nosplit'

--Set highlight on search
vim.o.hlsearch = false

--Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

--Do not save when switching buffers (note: this is now a default on master)
vim.o.hidden = true

--Enable mouse mode
vim.o.mouse = 'a'

--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.opt.undofile = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Y yank until the end of line  (note: this is now a default on master)
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true })

-- Highlight on yank
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]],
  false
)

--Map blankline
vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_char_highlight = 'LineNr'
vim.g.indent_blankline_show_trailing_blankline_indent = false

-- Luxurious terminal experience
vim.api.nvim_set_keymap('t', '<C-w>', [[<C-\><C-n><C-w>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<Esc>', [[<C-\><C-n>]], { noremap = true, silent = true })
vim.api.nvim_exec([[
  augroup neovim_terminal
    autocmd!
    " Enter Terminal-mode (insert) automatically
    autocmd BufEnter * if &buftype == 'terminal' | :startinsert | endif
    " Disables number lines on terminal buffers
    autocmd TermOpen * :set nonumber norelativenumber
  augroup END
]], false)

vim.api.nvim_set_keymap('n', '<Leader>bd', ':Bdelete<CR>', {})
vim.api.nvim_set_keymap('n', '<Leader>bD', ':Bdelete!<CR>', {})

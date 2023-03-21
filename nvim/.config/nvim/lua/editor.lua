local cmd = vim.cmd
local opt = vim.opt
local api = vim.api
local g = vim.g

g.mapleader = ' '

-- misc
opt.backspace = { 'eol', 'start', 'indent' }
opt.encoding = 'utf-8'
opt.matchpairs = { '(:)', '{:}', '[:]', '<:>' }
opt.syntax = 'enable'

-- indention
local indent = 4
opt.autoindent = true
opt.expandtab = true
opt.shiftwidth = indent
opt.smartindent = true
opt.softtabstop = indent
opt.tabstop = indent

-- search
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.wildmenu = true

-- ui
opt.number = true
opt.rnu = true
opt.scrolloff = 20
opt.showmode = false
opt.sidescrolloff = 3 -- Lines to scroll horizontally
opt.signcolumn = 'yes'

-- backups
opt.backup = false
opt.swapfile = false
opt.writebackup = false

-- terminal fixes
local clean_term_grp = api.nvim_create_augroup("CleanTermGutter", { clear = true })
api.nvim_create_autocmd("TermOpen", {
    command = [[
        setlocal nonumber norelativenumber signcolumn=yes:1
    ]],
    group = clean_term_grp
})

-- Disable virtual text noise
vim.diagnostic.config({
    virtual_text = false
})
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

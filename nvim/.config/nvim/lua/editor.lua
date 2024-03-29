local opt = vim.opt
local api = vim.api
local g = vim.g

g.mapleader = ' '

-- misc
opt.backspace = { 'eol', 'start', 'indent' }
opt.encoding = 'utf-8'
opt.matchpairs = { '(:)', '{:}', '[:]', '<:>' }
opt.syntax = 'enable'
opt.listchars = 'tab:▸ '
opt.exrc = true

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

-- Diagnostics config
vim.diagnostic.config({
    virtual_text = false,
    underline = true,
    severity_sort = true,
})

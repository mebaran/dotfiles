local cmd = vim.cmd
local opt = vim.opt
local api = vim.api
local g = vim.g

cmd([[
	filetype plugin indent on
]])

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
opt.wildignore = opt.wildignore + { '*/node_modules/*', '*/.git/*', '*/vendor/*' }
opt.wildmenu = true

-- ui
opt.cursorline = true
opt.mouse = 'a'
opt.number = true
opt.rnu = true
opt.scrolloff = 20
opt.showmode = false
opt.sidescrolloff = 3 -- Lines to scroll horizontally
opt.signcolumn = 'yes:2'
opt.splitbelow = true -- Open new split below
opt.splitright = true -- Open new split to the right
opt.wrap = false

-- backups
opt.backup = false
opt.swapfile = false
opt.writebackup = false

-- theme
opt.termguicolors = true

-- terminal fixes
local clean_term_grp = api.nvim_create_augroup("CleanTermGutter", { clear = true })
api.nvim_create_autocmd("TermOpen", {
    command = [[
        setlocal nonumber norelativenumber signcolumn=yes:1
    ]],
    group = clean_term_grp
})

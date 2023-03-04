local map = function(mode, keys, cmd)
    vim.keymap.set(mode, keys, cmd, {silent=true, noremap=true})
end

-- resize with arrows
map('n', '<C-Up>', ':resize -2<CR>')
map('n', '<C-Down>', ':resize +2<CR>')
map('n', '<C-Left>', ':vertical resize -2<CR>')
map('n', '<C-Right>', ':vertical resize +2<CR>')

-- Terminal
map('n', '<C-l>', ':FloatermToggle<CR>')
map('t', '<C-l>', [[<C-\><C-n>]])
map('t', '<C-w>l', [[<C-\><C-n>:FloatermNext<CR>]])
map('t', '<C-w>h', [[<C-\><C-n>:FloatermPrev<CR>]])
map('t', '<C-w>n', [[<C-\><C-n>:FloatermNew<CR>]])
map('t', '<C-w>c', [[<C-\><C-n>:FloatermKill<CR>]])

-- Terminal navigation
map('t', '<C-w><Left>', [[<C-\><C-n><C-w><Left><CR>]])
map('t', '<C-w><Right>', [[<C-\><C-n><C-w><Right><CR>]])
map('t', '<C-w><Up>', [[<C-\><C-n><C-w><Up><CR>]])
map('t', '<C-w><Down>', [[<C-\><C-n><C-w><Down><CR>]])

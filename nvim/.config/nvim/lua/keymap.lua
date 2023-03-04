local map = function(mode, keys, cmd, opts)
    vim.keymap.set(mode, keys, cmd, {silent=true, noremap=true})
end

--Quickfix and Location list
map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

-- resize with arrows
map('n', '<C-Up>', ':resize -2<CR>')
map('n', '<C-Down>', ':resize +2<CR>')
map('n', '<C-Left>', ':vertical resize -2<CR>')
map('n', '<C-Right>', ':vertical resize +2<CR>')

-- Terminal navigation
map('t', '<C-w><Left>', [[<C-\><C-n><C-w><Left><CR>]])
map('t', '<C-w><Right>', [[<C-\><C-n><C-w><Right><CR>]])
map('t', '<C-w><Up>', [[<C-\><C-n><C-w><Up><CR>]])
map('t', '<C-w><Down>', [[<C-\><C-n><C-w><Down><CR>]])

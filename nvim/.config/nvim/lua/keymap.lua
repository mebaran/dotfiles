local map = function(mode, keys, cmd, opts)
    local allopts = { silent = true, noremap = true }
    if opts then
        for k, v in pairs(opts) do
            allopts[k] = v
        end
    end
    vim.keymap.set(mode, keys, cmd, allopts)
end

--Quickfix and Location list
map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Open Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Open Quickfix List" })

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

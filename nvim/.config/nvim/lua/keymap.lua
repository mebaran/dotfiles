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

-- Terminal
map('t', '<C-w>', [[<C-\><C-n><C-w>]], { noremap = false })
map('t', '<C-t>', [[<C-\><C-n>]])
map('n', '<leader>tv', "<cmd>vsplit | terminal<cr>", { desc = 'Split terminal vertically' })
map('n', '<leader>tx', "<cmd>split | terminal<cr>", { desc = 'Split terminal horizontally' })

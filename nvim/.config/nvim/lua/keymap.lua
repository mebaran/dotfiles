local map = function(mode, keys, cmd, opts)
    local allopts = { silent = true }
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

-- Window resize (respecting `v:count`)
map('n', '<C-Left>', '<Cmd>vertical resize -2<CR>', { desc = 'Decrease window width' })
map('n', '<C-Down>', '<Cmd>resize -2<CR>', { desc = 'Decrease window height' })
map('n', '<C-Up>', '<Cmd>resize +2<CR>', { desc = 'Increase window height' })
map('n', '<C-Right>', '<Cmd>vertical resize +2<CR>', { desc = 'Increase window width' })

-- Terminal
map('t', '<C-W>', [[<C-\><C-N><C-w>]], { desc = 'Focus other window' })
map('t', '<C-x>', [[<C-\><C-n>]], { desc = 'Quick access to normal mode' })
map('n', '<leader>tv', "<cmd>vsplit | terminal <cr>", { desc = 'Split terminal vertically' })
map('n', '<leader>tx', "<cmd>split | resize 20 | terminal<cr>", { desc = 'Split terminal horizontally' })

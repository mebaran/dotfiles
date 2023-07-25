local setupf = function()
    require("gitsigns").setup({
        on_attach = function(bufnr)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            map("n", "]c", function()
                if vim.wo.diff then
                    return "]c"
                end
                vim.schedule(function()
                    gs.next_hunk()
                end)
                return "<Ignore>"
                end, { expr = true })

            map("n", "[c", function()
                if vim.wo.diff then
                    return "[c"
                end
                vim.schedule(function()
                    gs.prev_hunk()
                end)
                return "<Ignore>"
                end, { expr = true })

            -- Actions
            map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
            map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
            map("n", "<leader>hS", gs.stage_buffer, { desc = "Gitsigns stage buffer" })
            map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Gitsigns undo stage hunk" })
            map("n", "<leader>hR", gs.reset_buffer, { desc = "Gitsigns reset buffer" })
            map("n", "<leader>hp", gs.preview_hunk, { desc = "Gitsigns preview hunk" })
            map("n", "<leader>hb", function()
                gs.blame_line({ full = true })
                end, { desc = "Gitsigns blame line" })
            map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Gitsigns toggle current line blame" })
            map("n", "<leader>hd", gs.diffthis, { desc = "Gitsigns diff this" })
            map("n", "<leader>hD", function()
                gs.diffthis("~")
                end, { desc = "Gitsigns diff this ~" })
            map("n", "<leader>td", gs.toggle_deleted, { desc = "Gitsigns toggle deleted" })

            -- Text object
            map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
        end,
    })
end

return {
    {
        "lewis6991/gitsigns.nvim",
        config = setupf,
    },
    {
        "akinsho/git-conflict.nvim",
        config = true
    },
}

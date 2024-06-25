return {
    {
        'kevinhwang91/nvim-bqf',
        ft = 'qf'
    },
    {
        'tversteeg/registers.nvim',
        name = "registers",
        keys = {
            { "\"",    mode = { "n", "v" } },
            { "<C-R>", mode = "i" }
        },
        cmd = "Registers",
        opts = {}
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {},
        keys = {
            {
                "s",
                mode = { "n", "x", "o" },
                function()
                    require("flash").jump()
                end,
                desc = "Flash",
            },
            {
                "S",
                mode = { "n", "o", "x" },
                function()
                    require("flash").treesitter()
                end,
                desc = "Flash Treesitter",
            },
            {
                "r",
                mode = "o",
                function()
                    require("flash").remote()
                end,
                desc = "Remote Flash",
            },
            {
                "R",
                mode = { "o", "x" },
                function()
                    require("flash").treesitter_search()
                end,
                desc = "Flash Treesitter Search",
            },
            {
                "<c-s>",
                mode = { "c" },
                function()
                    require("flash").toggle()
                end,
                desc = "Toggle Flash Search",
            },
        },
    },
    {
        "folke/ts-comments.nvim",
        opts = {},
        event = "VeryLazy",
        enabled = vim.fn.has("nvim-0.10.0") == 1,
    },
    {
        "folke/zen-mode.nvim",
        opts = {},
        cmd = "ZenMode"
    },
    {
        "gbprod/yanky.nvim",
        dependencies = { { "kkharji/sqlite.lua", enabled = not jit.os:find("Windows") } },
        opts = {
            highlight = { timer = 250 },
            ring = { storage = jit.os:find("Windows") and "shada" or "sqlite" },
        },
        keys = {
            -- stylua: ignore
            {
                "<leader>p",
                function()
                    require("telescope").extensions.yank_history.yank_history({})
                end,
                desc = "Open Yank History"
            },
            {
                "y",
                "<Plug>(YankyYank)",
                mode = { "n", "x" },
                desc = "Yank text"
            },
            {
                "p",
                "<Plug>(YankyPutAfter)",
                mode = { "n", "x" },
                desc = "Put yanked text after cursor"
            },
            {
                "P",
                "<Plug>(YankyPutBefore)",
                mode = { "n", "x" },
                desc = "Put yanked text before cursor"
            },
            {
                "gp",
                "<Plug>(YankyGPutAfter)",
                mode = { "n", "x" },
                desc = "Put yanked text after selection"
            },
            {
                "gP",
                "<Plug>(YankyGPutBefore)",
                mode = { "n", "x" },
                desc = "Put yanked text before selection"
            },
            { "[y", "<Plug>(YankyCycleForward)",              desc = "Cycle forward through yank history" },
            { "]y", "<Plug>(YankyCycleBackward)",             desc = "Cycle backward through yank history" },
            { "]p", "<Plug>(YankyPutIndentAfterLinewise)",    desc = "Put indented after cursor (linewise)" },
            { "[p", "<Plug>(YankyPutIndentBeforeLinewise)",   desc = "Put indented before cursor (linewise)" },
            { "]P", "<Plug>(YankyPutIndentAfterLinewise)",    desc = "Put indented after cursor (linewise)" },
            { "[P", "<Plug>(YankyPutIndentBeforeLinewise)",   desc = "Put indented before cursor (linewise)" },
            { ">p", "<Plug>(YankyPutIndentAfterShiftRight)",  desc = "Put and indent right" },
            { "<p", "<Plug>(YankyPutIndentAfterShiftLeft)",   desc = "Put and indent left" },
            { ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put before and indent right" },
            { "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)",  desc = "Put before and indent left" },
            { "=p", "<Plug>(YankyPutAfterFilter)",            desc = "Put after applying a filter" },
            { "=P", "<Plug>(YankyPutBeforeFilter)",           desc = "Put before applying a filter" },
        },
    },
    {
        "numtostr/Fterm.nvim",
        opts = {},
        keys = {
            { "<C-l>", '<cmd>lua require("FTerm").toggle()<cr>', mode = { "n", "t" }, desc = "Toggle Floating Term" },
        },
    },
    {
        "willothy/flatten.nvim",
        opts = {},
        lazy = false,
        priority = 10001
    },
}

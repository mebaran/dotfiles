local function lsp_zero_setup()
    local lsp = require('lsp-zero').preset({
        name = 'minimal',
        set_lsp_keymaps = true,
        manage_nvim_cmp = true,
        suggest_lsp_servers = false,
    })

    -- Snippet setup
    require("luasnip.loaders.from_vscode").lazy_load()

    -- (Optional) Configure lua language server for neovim
    lsp.nvim_workspace()
    lsp.setup()
end

return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    dependencies = {
        -- LSP Support
        'neovim/nvim-lspconfig',             -- Required
        'williamboman/mason.nvim',           -- Optional
        'williamboman/mason-lspconfig.nvim', -- Optional

        -- Autocompletion
        'hrsh7th/nvim-cmp',         -- Required
        'hrsh7th/cmp-nvim-lsp',     -- Required
        'saadparwaiz1/cmp_luasnip', -- Optional
        'hrsh7th/cmp-nvim-lua',     -- Optional

        -- LSP diagnostics UI
        {
            "folke/trouble.nvim",
            cmd = { "TroubleToggle", "Trouble" },
            opts = { use_diagnostic_signs = true },
            keys = {
                { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>",  desc = "Document Diagnostics (Trouble)" },
                { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
                { "<leader>xL", "<cmd>TroubleToggle loclist<cr>",               desc = "Location List (Trouble)" },
                { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>",              desc = "Quickfix List (Trouble)" },
                {
                    "[q",
                    function()
                        if require("trouble").is_open() then
                            require("trouble").previous({ skip_groups = true, jump = true })
                        else
                            vim.cmd.cprev()
                        end
                    end,
                    desc = "Previous trouble/quickfix item",
                },
                {
                    "]q",
                    function()
                        if require("trouble").is_open() then
                            require("trouble").next({ skip_groups = true, jump = true })
                        else
                            vim.cmd.cnext()
                        end
                    end,
                    desc = "Next trouble/quickfix item",
                },
            },
        },

        -- Snippets
        {
            'L3MON4D3/LuaSnip',
            build = 'make install_jsregexp'
        },
        'rafamadriz/friendly-snippets' -- Optional
    },
    config = lsp_zero_setup
}

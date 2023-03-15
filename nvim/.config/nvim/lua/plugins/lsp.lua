local function lsp_zero_setup()
    local lsp = require("lsp-zero").preset({
        name = "minimal",
        set_lsp_keymaps = true,
        manage_nvim_cmp = true,
        suggest_lsp_servers = false,
    })
    lsp.on_attach(function(client, bufnr)
        local opts = {
            desc = "Format with attached LSP(s)",
            buffer = bufnr
        }
        vim.keymap.set({ "n", "v" }, "<leader>=", "<cmd>LspZeroFormat<cr>", opts)
    end)

    -- Snippet setup
    require("luasnip.loaders.from_vscode").lazy_load()

    -- (Optional) Configure lua language server for neovim
    lsp.nvim_workspace()
    lsp.setup()
end

return {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v1.x",
    dependencies = {
        -- LSP Support
        "neovim/nvim-lspconfig",

        -- Autocompletion
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",

        -- Snippets
        {
            "L3MON4D3/LuaSnip",
            build = "make install_jsregexp",
        },
        "rafamadriz/friendly-snippets",
    },
    config = lsp_zero_setup,
}

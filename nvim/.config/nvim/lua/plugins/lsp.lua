local function lsp_zero_setup ()
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
        {'neovim/nvim-lspconfig'},             -- Required
        {'williamboman/mason.nvim'},           -- Optional
        {'williamboman/mason-lspconfig.nvim'}, -- Optional

        -- Autocompletion
        {'hrsh7th/nvim-cmp'},         -- Required
        {'hrsh7th/cmp-nvim-lsp'},     -- Required
        {'hrsh7th/cmp-buffer'},       -- Optional
        {'hrsh7th/cmp-path'},         -- Optional
        {'saadparwaiz1/cmp_luasnip'}, -- Optional
        {'hrsh7th/cmp-nvim-lua'},     -- Optional

        -- LSP diagnostics UI
        {'folke/trouble.nvim'},

        -- Snippets
        {
            'L3MON4D3/LuaSnip',
            build = 'make install_jsregexp'
        },
        {'rafamadriz/friendly-snippets'} -- Optional
    },
    config = lsp_zero_setup
}

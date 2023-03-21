local function lsp_setup()
    -- Disable virtual text noise
    vim.diagnostic.config({
        virtual_text = false
    })

    -- Start LSP zero
    local lsp = require('lsp-zero').preset({
        name = 'minimal',
        manage_nvim_cmp = true,
        suggest_lsp_servers = false,
        set_lsp_keymaps = {
            omit = { '<F2>', '<F3>', '<F4>' }
        }
    })

    -- CMP config
    local cmp = require('cmp')
    local cmp_action = require('lsp-zero').cmp_action()
    cmp.setup({
        mapping = {
            ['<Tab>'] = cmp_action.luasnip_supertab(),
            ['<S-Tab'] = cmp_action.luasnip_shift_supertab(),
            ['<C-u>'] = cmp.mapping.scroll_docs(-4),
            ['<C-d>'] = cmp.mapping.scroll_docs(4),
            ['<C-f>'] = cmp_action.luasnip_jump_forward(),
            ['<C-b>'] = cmp_action.luasnip_jump_backward(),
            ["<CR>"] = cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Replace,
                select = false,
            }
        }
    })

    lsp.skip_server_setup({ 'jdtls' })

    ---@diagnostic disable-next-line: unused-local
    lsp.on_attach(function(_client, bufnr)
        lsp.default_keymaps({ buffer = bufnr })
        local function nvmap(keys, func)
            vim.keymap.set({ 'n', 'x' }, keys, func, { buffer = bufnr })
        end
        nvmap('<leader>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>')
        nvmap('<leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>')
        nvmap('<leader>=', '<Cmd>lua vim.lsp.buf.format({async=true})<CR>')
        nvmap('<leader>==', '<Cmd>lua vim.lsp.buf.format()<CR>')

        vim.keymap.set({'i'}, '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>')
    end)

    -- (Optional) Configure lua language server for neovim
    require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

    -- Load friendly snippets
    require('luasnip.loaders.from_vscode').lazy_load()

    lsp.setup()
end

local function mason_null_ls_setup()
    local null_ls = require('null-ls')
    local mason_null_ls = require('mason-null-ls')
    mason_null_ls.setup({
        automatic_installation = false,
        automatic_setup = true
    })
    null_ls.setup()
    mason_null_ls.setup_handlers()
end

return {
    -- LSP Support
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            {
                'williamboman/mason.nvim',
                config = true
            },
            {
                'williamboman/mason-lspconfig.nvim',
                opts = {
                    ensure_installed = { 'lua_ls', 'pyright' }
                }
            },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-path' },
            {
                "L3MON4D3/LuaSnip",
                build = "make install_jsregexp",
            },
            { "rafamadriz/friendly-snippets" }
        },
        config = lsp_setup
    },
    {
        "folke/neodev.nvim",
        config = true
    },
    {
        'jay-babu/mason-null-ls.nvim',
        config = mason_null_ls_setup,
        dependencies = {
            'jose-elias-alvarez/null-ls.nvim'
        }
    }
}

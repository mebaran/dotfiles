local function lsp_callback(bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set({ 'i', 'n' }, '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>=', function()
        vim.lsp.buf.format { async = true }
    end, opts)
    vim.keymap.set('n', '<leader>==', function()
        vim.lsp.buf.format { async = false }
    end, opts)
end

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev) lsp_callback(ev.buf) end
})

local LSP_SETUP_DISABLED = function() end
local LSP_CUSTOM_SETUP = {
    jdtls = LSP_SETUP_DISABLED
}

return {
    -- LSP Support
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            {
                "folke/neodev.nvim",
                config = true
            },

        }
    },
    {
        'williamboman/mason.nvim',
        config = true
    },
    {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            local opts = {
                ensure_installed = { 'lua_ls', 'pyright', 'csharp_ls', 'jdtls', 'tsserver' }
            }
            local mlsp = require('mason-lspconfig')
            mlsp.setup(opts)
            local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
            local lspconfig = require('lspconfig')
            mlsp.setup_handlers({
                function(server_name)
                    local custom_setup = LSP_CUSTOM_SETUP[server_name]
                    if custom_setup then
                        custom_setup()
                    else
                        lspconfig[server_name].setup({
                            capabilities = lsp_capabilities,
                        })
                    end
                end
            })
        end
    },
    {
        'jay-babu/mason-null-ls.nvim',
        config = function()
            local null_ls = require('null-ls')
            local mason_null_ls = require('mason-null-ls')
            mason_null_ls.setup({
                automatic_installation = false,
                automatic_setup = true
            })
            null_ls.setup()
            mason_null_ls.setup_handlers({})
        end,
        dependencies = {
            'jose-elias-alvarez/null-ls.nvim'
        }
    },
    {
        "mfussenegger/nvim-jdtls",
        ft = 'java'
    }
}

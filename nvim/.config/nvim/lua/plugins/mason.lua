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
    {
        'williamboman/mason.nvim',
        config = true,
        dependencies = {
            'williamboman/mason-lspconfig.nvim'
        }
    },
    {
        'jay-babu/mason-null-ls.nvim',
        config = mason_null_ls_setup,
        dependencies = {
            'jose-elias-alvarez/null-ls.nvim'
        }
    }
}

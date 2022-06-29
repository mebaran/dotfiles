-- LSP settings
local nvim_lsp = require('lspconfig')
local lsp_attach = require('lsp_keys').lsp_keys

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Enable the following language servers
local servers = {
    prismals = lsp_attach,
    pyright = lsp_attach,
    tsserver = lsp_attach,
    r_language_server = lsp_attach,
    bashls = lsp_attach,
    hls = lsp_attach,
    volar = lsp_attach,
    sqls = function(client, buf)
        lsp_attach(client, buf)
        client.resolved_capabilities.execute_command = true
        client.commands = require('sqls').commands -- Neovim 0.6+ only
        require('sqls').setup {picker = 'telescope'}
    end
}
for lsp, attach_fn in pairs(servers) do
    nvim_lsp[lsp].setup {on_attach = attach_fn, capabilities = capabilities}
end

--Volar Configuration
require'lspconfig'.volar.setup{
    filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'}
}

--Ionide Configuration
local ionide = require('ionide').setup {on_attach = lsp_attach, capabilities = capabilities}
vim.g["fsharp#fsi_keymap"] = "vim-fsharp"
vim.g["fsharp#lsp_auto_setup"] = 0

-- LspUtil Configuration
local bufnr = vim.api.nvim_buf_get_number(0)
vim.lsp.handlers['textDocument/codeAction'] =
    function(_, _, actions)
        require('lsputil.codeAction').code_action_handler(nil, actions, nil,
                                                          nil, nil)
    end
vim.lsp.handlers['textDocument/references'] =
    function(_, _, result)
        require('lsputil.locations').references_handler(nil, result,
                                                        {bufnr = bufnr}, nil)
    end
vim.lsp.handlers['textDocument/definition'] =
    function(_, method, result)
        require('lsputil.locations').definition_handler(nil, result, {
            bufnr = bufnr,
            method = method
        }, nil)
    end
vim.lsp.handlers['textDocument/declaration'] =
    function(_, method, result)
        require('lsputil.locations').declaration_handler(nil, result, {
            bufnr = bufnr,
            method = method
        }, nil)
    end
vim.lsp.handlers['textDocument/typeDefinition'] =
    function(_, method, result)
        require('lsputil.locations').typeDefinition_handler(nil, result, {
            bufnr = bufnr,
            method = method
        }, nil)
    end
vim.lsp.handlers['textDocument/implementation'] =
    function(_, method, result)
        require('lsputil.locations').implementation_handler(nil, result, {
            bufnr = bufnr,
            method = method
        }, nil)
    end
vim.lsp.handlers['textDocument/documentSymbol'] =
    function(_, _, result, _, bufn)
        require('lsputil.symbols').document_handler(nil, result,
                                                    {bufnr = bufn}, nil)
    end
vim.lsp.handlers['textDocument/symbol'] =
    function(_, _, result, _, bufn)
        require('lsputil.symbols').workspace_handler(nil, result,
                                                     {bufnr = bufn}, nil)
    end

-- Null ls config
null_ls = require('null-ls')
null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.flake8,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.autopep8
    }
})

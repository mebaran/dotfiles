-- LSP settings
local nvim_lsp = require 'lspconfig'
local lsp_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }
  local nbufmap = function(keys, cmd)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', keys, cmd, opts)
  end
  
  nbufmap('gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
  nbufmap('gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
  nbufmap('K', '<cmd>lua vim.lsp.buf.hover()<CR>')
  nbufmap('gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
  nbufmap('<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
  nbufmap('<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
  nbufmap('<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
  nbufmap('<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
  nbufmap('<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
  nbufmap('<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
  nbufmap('gr', '<cmd>lua vim.lsp.buf.references()<CR>')
  nbufmap('<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
  nbufmap('<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
  nbufmap('[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
  nbufmap(']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
  nbufmap('<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')
  nbufmap('<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]])
  nbufmap('<leader>ff', [[<cmd>:Format<CR>]]) 
  
  vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Enable the following language servers
local servers = { 
    pyright = lsp_attach, 
    tsserver = lsp_attach, 
    r_language_server = lsp_attach, 
    bashls = lsp_attach, 
    hls = lsp_attach, 
    sqls = function(client, buf)
        client.resolved_capabilities.execute_command = true
        client.commands = require('sqls').commands -- Neovim 0.6+ only
        lsp_attach(client, buf)
        require('sqls').setup{ picker = 'telescope' }
    end
}
for lsp, attach_fn in pairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = attach_fn,
    capabilities = capabilities
  }
end

-- LspUtil Configuration
if vim.fn.has('nvim-0.5.1') == 1 then
    vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
    vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
    vim.lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
    vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
    vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
    vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
    vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
    vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler
else
    local bufnr = vim.api.nvim_buf_get_number(0)

    vim.lsp.handlers['textDocument/codeAction'] = function(_, _, actions)
        require('lsputil.codeAction').code_action_handler(nil, actions, nil, nil, nil)
    end

    vim.lsp.handlers['textDocument/references'] = function(_, _, result)
        require('lsputil.locations').references_handler(nil, result, { bufnr = bufnr }, nil)
    end

    vim.lsp.handlers['textDocument/definition'] = function(_, method, result)
        require('lsputil.locations').definition_handler(nil, result, { bufnr = bufnr, method = method }, nil)
    end

    vim.lsp.handlers['textDocument/declaration'] = function(_, method, result)
        require('lsputil.locations').declaration_handler(nil, result, { bufnr = bufnr, method = method }, nil)
    end

    vim.lsp.handlers['textDocument/typeDefinition'] = function(_, method, result)
        require('lsputil.locations').typeDefinition_handler(nil, result, { bufnr = bufnr, method = method }, nil)
    end

    vim.lsp.handlers['textDocument/implementation'] = function(_, method, result)
        require('lsputil.locations').implementation_handler(nil, result, { bufnr = bufnr, method = method }, nil)
    end

    vim.lsp.handlers['textDocument/documentSymbol'] = function(_, _, result, _, bufn)
        require('lsputil.symbols').document_handler(nil, result, { bufnr = bufn }, nil)
    end

    vim.lsp.handlers['textDocument/symbol'] = function(_, _, result, _, bufn)
        require('lsputil.symbols').workspace_handler(nil, result, { bufnr = bufn }, nil)
    end
end

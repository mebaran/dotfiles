local M = {}

function M.lsp_keys(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = {noremap = true, silent = true}
    local nbufmap = function(keys, cmd)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', keys, cmd, opts)
    end 
    local vbufmap = function(keys, cmd)
        vim.api.nvim_buf_set_keymap(bufnr, 'v', keys, cmd, opts)
    end

    nbufmap('gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
    nbufmap('gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
    nbufmap('K', '<cmd>lua vim.lsp.buf.hover()<CR>')
    nbufmap('gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
    nbufmap('<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
    nbufmap('<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
    nbufmap('<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
    nbufmap('<leader>wl',
            '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
    nbufmap('<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
    nbufmap('<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
    nbufmap('gr', '<cmd>lua vim.lsp.buf.references()<CR>')
    nbufmap('<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
    nbufmap('<leader>e',
            '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
    nbufmap('[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
    nbufmap(']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
    nbufmap('<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')
    nbufmap('<leader>so',
            [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]])
    nbufmap('<leader>ff', [[<cmd>:Format<CR>]])

    vbufmap(bufnr, 'v', '<leader>ca','<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
    vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

return M

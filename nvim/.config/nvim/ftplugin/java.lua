local function jdtls_attach(_, bufnr)
    require('jdtls.setup').add_commands()
    require('lsp_keys').lsp_keys()
    local opts = { noremap = true, silent = true }
    local function buf_set_keymap(mode, mapping, command)
        vim.api.nvim_buf_set_keymap(bufnr, mode, mapping, command, opts)
    end
    buf_set_keymap('n', '<Leader>ca', [[<Cmd>lua require'jdtls'.code_action()<CR>]])
    buf_set_keymap('n', 'gdi', "<Cmd>lua require'jdtls'.organize_imports()<CR>")
    buf_set_keymap('n', 'gdt', "<Cmd>lua require'jdtls'.test_class()<CR>")
    buf_set_keymap('n', 'gdn', "<Cmd>lua require'jdtls'.test_nearest_method()<CR>")
    buf_set_keymap('v', 'gde', "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>")
    buf_set_keymap('n', 'gde', "<Cmd>lua require('jdtls').extract_variable()<CR>")
    buf_set_keymap('v', 'gdm', "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>")
    require('jdtls').setup_dap({ hotcodereplace = 'auto' })
end

local jdtls_ui = require'jdtls.ui'
function jdtls_ui.pick_one_async(items, _, _, cb)
    require'lsputil.codeAction'.code_action_handler(nil, items, nil, nil, cb)
end

local config = {
    cmd = { 'jdtls' },
    on_attach = jdtls_attach
}
require('jdtls').start_or_attach(config)

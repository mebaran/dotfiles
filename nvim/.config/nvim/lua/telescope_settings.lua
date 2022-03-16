-- Telescope
require('telescope').setup {
    defaults = {mappings = {i = {['<C-u>'] = false, ['<C-d>'] = false}}}
}

if jit then require('telescope').load_extension('fzf') end

-- Add leader shortcuts

local nbufmap = function(keys, cmd)
    vim.api.nvim_set_keymap('n', keys, cmd, {noremap = true, silent = true}) 
end

-- Telescope hotkey setup
nbufmap('<leader><space>', [[<cmd>lua require('telescope.builtin').buffers()<CR>]])
nbufmap('<leader>sf', [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]])
nbufmap('<leader>sb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]])
nbufmap('<leader>sh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]])
nbufmap('<leader>st', [[<cmd>lua require('telescope.builtin').tags()<CR>]])
nbufmap('<leader>sd', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]])
nbufmap('<leader>sp', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]])
nbufmap('<leader>so', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]])
nbufmap('<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]]) 

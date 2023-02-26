local map = function(mode, keys, cmd)
    vim.keymap.set(mode, keys, cmd, {silent=true, noremap=true})
end

-- Telescope
local project_files = function()
    local opts = {} -- define here if you want to define something
    local ok = pcall(require('telescope.builtin').git_files, opts)
    if not ok then
        require('telescope.builtin').find_files(opts)
    end
end
map('n', '<leader>ff', project_files)
map('n', '<leader>fg', ':Telescope git_files<cr>')
map('n', '<leader>fk', ':Telescope buffers<cr>')
map('n', '<leader>fs', ':Telescope live_grep<cr>')
map('n', '<leader>fw', ':Telescope grep_string<cr>')

-- git navigation
map('n', '<leader>ggc', ':Telescope git_commits<cr>')
map('n', '<leader>ggs', ':Telescope git_status<cr>')

-- Quickfix mappings
map('n', '<leader>ck', ':cexpr []<cr>')
map('n', '<leader>cc', ':cclose <cr>')
map('n', '<leader>co', ':copen <cr>')
map('n', '<leader>cf', ':cfdo %s/')
map('n', '<leader>cp', ':cprev<cr>zz')
map('n', '<leader>cn', ':cnext<cr>zz')

-- buffer navigation
map('n', '<leader>bp', ':bprev<cr>')
map('n', '<leader>bn', ':bnext<cr>')
map('n', '<leader>bd', ':bdelete<cr>')

-- tab navigation
map('n', '<leader>tp', ':tabprevious<cr>')
map('n', '<leader>tn', ':tabnext<cr>')
map('n', '<leader>td', ':tabclose<cr>')

-- resize with arrows
map('n', '<C-Up>', ':resize -2<CR>')
map('n', '<C-Down>', ':resize +2<CR>')
map('n', '<C-Left>', ':vertical resize -2<CR>')
map('n', '<C-Right>', ':vertical resize +2<CR>')

-- Terminal
map('n', '<C-l>', ':FloatermToggle<CR>')
map('t', '<C-l>', [[<C-\><C-n>]])
map('t', '<C-w>l', [[<C-\><C-n>:FloatermNext<CR>]])
map('t', '<C-w>h', [[<C-\><C-n>:FloatermPrev<CR>]])
map('t', '<C-w>n', [[<C-\><C-n>:FloatermNew<CR>]])
map('t', '<C-w>c', [[<C-\><C-n>:FloatermKill<CR>]])

-- Terminal navigation
map('t', '<C-w><Left>', [[<C-\><C-n><C-w><Left><CR>]])
map('t', '<C-w><Right>', [[<C-\><C-n><C-w><Right><CR>]])
map('t', '<C-w><Up>', [[<C-\><C-n><C-w><Up><CR>]])
map('t', '<C-w><Down>', [[<C-\><C-n><C-w><Down><CR>]])

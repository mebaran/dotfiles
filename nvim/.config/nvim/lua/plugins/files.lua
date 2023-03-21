local function drex_minus()
    local drex = require('drex')
    local elements = require('drex.elements')
    if vim.bo.filetype == 'drex' then
        local path = vim.fn.expand('%:h:s?drex://??')
        local parent = vim.fn.fnamemodify(path, ':h')
        print(string.format('Minus from Drex: %s', parent))
        drex.open_directory_buffer(parent)
    else
        local path = vim.fn.expand('%:h')
        if path == '' then
            drex.open_directory_buffer() -- open at cwd
        else
            drex.open_directory_buffer(vim.fn.fnamemodify(path, ':h'))
            elements.focus_element(0, path)
        end
    end
end

local function drex_setup()
    local elements = require('drex.elements')
    require('drex.config').configure {
        keybindings = {
            ['n'] = {
                ['~'] = '<CMD>Drex ~<CR>',
                ['-'] = '<CMD>lua require("drex.elements").open_parent_directory()<CR>',
                ['.'] = function()
                    local element = require('drex.utils').get_element(vim.api.nvim_get_current_line())
                    local left = vim.api.nvim_replace_termcodes('<left>', true, false, true)
                    vim.api.nvim_feedkeys(': ' .. element .. string.rep(left, #element + 1), 'n', true)
                end,
                ['<CR>'] = function()
                    local line = vim.api.nvim_get_current_line()

                    if require('drex.utils').is_open_directory(line) then
                        elements.collapse_directory()
                    else
                        elements.expand_element()
                    end
                end
            }
        }
    }
end

return {
    'tpope/vim-vinegar',
    {
        'TheBlob42/drex.nvim',
        config = drex_setup,
        cmd = { 'Drex', 'DrexDrawerToggle' },
        keys = {
            { '-', drex_minus },
            { '~', '<CMD>Drex ~<CR>' }
        }
    }
}

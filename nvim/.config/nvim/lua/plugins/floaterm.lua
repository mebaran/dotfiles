local function floaterm_setup()
    local g = vim.g
    local title = vim.env.SHELL

    g.floaterm_width = 0.7
    g.floaterm_height = 0.8
    g.floaterm_title = '[' .. title .. ']:($1/$2)'
    g.floaterm_borderchars = '─│─│╭╮╯╰'
    g.floaterm_opener = 'vsplit'
end

return {
    {
        "voldikss/vim-floaterm",
        name = "floaterm",
        config = floaterm_setup,
        keys = {
            { '<C-l>',  ':FloatermToggle<CR>', mode = {'n', 'v'} },
            { '<C-l>',  [[<C-\><C-n>]], mode = { 't' } },
            { '<C-w>l', [[<C-\><C-n>:FloatermNext<CR>]], mode = { 't' } },
            { '<C-w>h', [[<C-\><C-n>:FloatermPrev<CR>]], mode = { 't' } },
            { '<C-w>n', [[<C-\><C-n>:FloatermNew<CR>]], mode = { 't' } },
            { '<C-w>c', [[<C-\><C-n>:FloatermKill<CR>]], mode = { 't' } }
        }
    }
}

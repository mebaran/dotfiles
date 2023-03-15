local function mini_setup()
    local rs = function(s, t)
        require(s).setup(t)
    end
    rs('mini.ai')
    rs('mini.basics', {
        options = {
            extra_ui = true
        }
    })
    rs('mini.bufremove')
    rs('mini.bracketed')
    rs('mini.jump')
    rs('mini.pairs')
    rs('mini.starter')
    rs('mini.surround')

    rs('mini.indentscope', { try_as_border = true })
    vim.api.nvim_create_autocmd("FileType", {
        pattern = { "terminal", "help", "alpha", "dashboard", "Trouble", "lazy", "mason", "nofile" },
        callback = function()
            vim.b.miniindentscope_disable = true
        end
    })
    local function bufdelete(force)
        return function()
            require('mini.bufremove').delete(nil, force)
        end
    end
    vim.keymap.set('n', '<leader>bd', bufdelete(false), { desc = 'Delete buffer' })
    vim.keymap.set('n', '<leader>bD', bufdelete(true), { desc = 'Force delete buffer' })
end

return {
    "echasnovski/mini.nvim",
    config = mini_setup
}

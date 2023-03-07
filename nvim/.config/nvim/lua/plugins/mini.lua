local function mini_setup()
    local rs = function (s, t)
        require(s).setup(t)
    end
    rs('mini.ai')
    rs('mini.basics')
    rs('mini.bracketed')
    rs('mini.jump')
    rs('mini.pairs')
    rs('mini.starter')
    rs('mini.surround')

    rs('mini.indentscope', { try_as_border = true })
    vim.api.nvim_create_autocmd("FileType", {
        pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason", "nofile" },
        callback = function()
          vim.b.miniindentscope_disable = true
        end
    })
end

return {
    "echasnovski/mini.nvim",
    config = mini_setup
}

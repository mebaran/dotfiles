local function mini_setup()
    local rs = function (s, t)
        require(s).setup(t)
    end
    rs('mini.ai')
    rs('mini.basics')
    rs('mini.bracketed')
    rs('mini.comment')
    rs('mini.jump')
    rs('mini.jump2d')
    rs('mini.pairs')
    rs('mini.starter')
    rs('mini.surround')
    rs('mini.comment')
end

return {
    "echasnovski/mini.nvim",
    config = mini_setup
}

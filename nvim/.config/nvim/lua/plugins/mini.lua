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
end

return {
    "echasnovski/mini.nvim",
    config = mini_setup
}

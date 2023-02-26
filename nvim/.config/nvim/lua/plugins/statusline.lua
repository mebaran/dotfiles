local function lualine_setup ()
    require('lualine').setup({
        globalstatus = true
    })
end

local function tabby_setup ()
end

return {
    {
        "nvim-lualine/lualine.nvim",
        config = lualine_setup
    },
    {
        "nanozuki/tabby.nvim",
        config = true
    }
}

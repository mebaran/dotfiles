return {
    {
        "mcchrish/zenbones.nvim",
        -- Optionally install Lush. Allows for more configuration or extending the colorscheme
        -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
        -- In Vim, compat mode is turned on as Lush only works in Neovim.
        dependencies = "rktjmp/lush.nvim",
        lazy = true,
    },
    {
        "sainnhe/everforest",
        lazy = true,
    },
    {
        "olivercederborg/poimandres.nvim",
        lazy = true,
        opts = {},
    },
    {
        "dgox16/oldworld.nvim",
        lazy = true,
        opts = {},
    },
}

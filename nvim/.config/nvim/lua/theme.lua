local theme = 'catppuccin'
vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha
require('lualine').setup {
    options = {
        theme = theme
    }
}
vim.cmd(string.format([[colorscheme %s]], theme))
return theme

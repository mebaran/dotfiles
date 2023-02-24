local telescope_setup = function ()
    local telescope = require('telescope')
    telescope.load_extension('fzf')
    telescope.setup()
end

return {
    { 
        "nvim-telescope/telescope-fzf-native.nvim", 
        build = "make"
    },
    {
        "nvim-telescope/telescope.nvim",
        config = telescope_setup,
        dependencies = {
            "telescope-fzf-native.nvim",
            "nvim-lua/plenary.nvim"
        }
    }
}

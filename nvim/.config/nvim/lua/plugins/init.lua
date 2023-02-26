return {
    "tpope/vim-vinegar",
    "nvim-tree/nvim-web-devicons",
    {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    },
    {
	    "tversteeg/registers.nvim",
	    name = "registers",
	    keys = {
		    { "\"",    mode = { "n", "v" } },
		    { "<C-R>", mode = "i" }
	    },
	    cmd = "Registers",
        config = true
    },
    {
        {
            'stevearc/oil.nvim',
            config = true
        }
    }
}

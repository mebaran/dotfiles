return {
    'nvim-tree/nvim-web-devicons',
    {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    },
    {
	    'tversteeg/registers.nvim',
	    name = "registers",
	    keys = {
		    { "\"",    mode = { "n", "v" } },
		    { "<C-R>", mode = "i" }
	    },
	    cmd = "Registers",
        config = true
    },
    'kevinhwang91/nvim-bqf'
}

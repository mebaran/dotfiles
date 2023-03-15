return {
    'kevinhwang91/nvim-bqf',
    'nvim-tree/nvim-web-devicons',
    {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    },
    'nvim-treesitter/nvim-treesitter-textobjects',
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
    {
        'numtostr/comment.nvim',
        keys = {
            { "gc", mode = {'n', 'v'} },
            { "gb", mode = {'n', 'v'} }
        },
        config = true
    },
}

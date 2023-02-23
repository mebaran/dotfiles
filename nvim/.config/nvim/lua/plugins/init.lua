return {
    "tpope/vim-vinegar",
    "nvim-tree/nvim-web-devicons",
    {
        'nvim-treesitter/nvim-treesitter',
        run=':TSUpdate'
    },
    {
	    "tversteeg/registers.nvim",
	    name = "registers",
	    keys = {
		    { "\"",    mode = { "n", "v" } },
		    { "<C-R>", mode = "i" }
	    },
	    cmd = "Registers",
    },
    {
        "williamboman/mason.nvim",
        config=true,
        lazy=false
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config=true
    },
    "neovim/nvim-lspconfig",
}

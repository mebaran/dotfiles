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
    {
        {
            'stevearc/oil.nvim',
            keys = { "-", mode = { "n" } },
            cmd = "Oil",
            config = function ()
                require('oil').setup()
                vim.keymap.set("n", "-", require("oil").open)
            end
        }
    },
    {
        'kevinhwang91/nvim-bqf'
    }
}

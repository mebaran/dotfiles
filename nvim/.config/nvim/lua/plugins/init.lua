return {
    {
        'kevinhwang91/nvim-bqf',
        ft = 'qf'
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
    }
}

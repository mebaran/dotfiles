return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            {
                "leoluz/nvim-dap-go",
                config = true,
            },
        },
    },
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/neotest-go",
        },
        opts = {
            adapters = {
                ["neotest-go"] = {
                    -- Here we can set options for neotest-go, e.g.
                    -- args = { "-tags=integration" }
                },
            },
        },
    },
}

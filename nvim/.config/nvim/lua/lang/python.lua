return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "mfussenegger/nvim-dap-python",
            -- stylua: ignore
            keys = {
                { "<leader>dPt", function() require('dap-python').test_method() end, desc = "Debug Method" },
                { "<leader>dPc", function() require('dap-python').test_class() end,  desc = "Debug Class" },
            },
            config = function()
                local path = require("mason-registry").get_package("debugpy"):get_install_path()
                require("dap-python").setup(path .. "/venv/bin/python")
            end,
        },
    },
    {
        "linux-cultist/venv-selector.nvim",
        cmd = "VenvSelect",
        opts = function(_, opts)
            return vim.tbl_deep_extend("force", opts, {
                name = {
                    "venv",
                    ".venv",
                    "env",
                    ".env",
                },
            })
        end,
        keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv" } },
    },
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                python = { "autopep8", "isort" }
            }
        }
    }
}

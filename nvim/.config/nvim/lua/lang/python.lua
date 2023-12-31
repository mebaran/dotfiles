return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            if type(opts.ensure_installed) == "table" then
                vim.list_extend(opts.ensure_installed, { "ninja", "python", "rst", "toml" })
            end
        end,
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                pyright = {},
            },
        },
    },
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/neotest-python",
        },
        opts = {
            adapters = {
                ["neotest-python"] = {
                    -- Here you can specify the settings for the adapter, i.e.
                    -- runner = "pytest",
                    -- python = ".venv/bin/python",
                },
            },
        },
    },
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
        "williamboman/mason.nvim",
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, { "pyright", "debugpy", "autopep8", "isort", "flake8", })
        end
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
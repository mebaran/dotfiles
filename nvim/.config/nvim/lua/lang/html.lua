return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                htmx = {}
            },
        },
    },
    {
        "mason.nvim",
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(
                opts.ensure_installed,
                {
                    "htmx-lsp",
                    "emmet-ls",
                    "html-lsp",
                    "prettierd",
                    "css-lsp",
                })
        end,
    },
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                css = { "prettierd" },
                html = { "prettierd" },
            }
        }
    }
}

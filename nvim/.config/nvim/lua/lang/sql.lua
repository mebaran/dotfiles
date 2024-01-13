return {
    {
        "mfussenegger/nvim-lint",
        optional = true,
        opts = function(_, opts)
            opts.linters_by_ft = opts.linters_by_ft or {}
            opts.linters_by_ft.sql = { "sqlfluff" }
        end
    },
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = {
            formatters_by_ft = {
                sql = { "pg_format" },
            },
        },
    },
    {
        "mason.nvim",
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, { "sqlfluff" })
        end,
    },
    {
        "nanotee/sqls.nvim",
        --ft = "sql",
        config = function()
            require('lspconfig').sqls.setup{
                on_attach = function(client, bufnr)
                    require('sqls').on_attach(client, bufnr)
                end
            }
        end
    }
}

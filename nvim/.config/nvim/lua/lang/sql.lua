return {
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
        "nanotee/sqls.nvim",
        ft = "sql",
        config = function()
            require('lspconfig').sqls.setup{
                on_attach = function(client, bufnr)
                    require('sqls').on_attach(client, bufnr)
                end
            }
        end
    }
}

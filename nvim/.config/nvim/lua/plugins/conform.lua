return {
    {
        "stevearc/conform.nvim",
        dependencies = { "mason.nvim" },
        lazy = true,
        cmd = "ConformInfo",
        keys = {
            {
                "<leader>cf",
                function()
                    require("conform").format()
                end,
                mode = { "n", "v" },
                desc = "Format Injected Langs",
            },
        },
        init = function()
            vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        end,
        opts = {
            -- LazyVim will merge the options you set here with builtin formatters.
            -- You can also define any custom formatters here.
            ---@type table<string,table>
            formatters_by_ft = {
                -- -- Example of using dprint only when a dprint.json file is present
                -- dprint = {
                --   condition = function(ctx)
                --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
                --   end,
                -- },
            },
        }
    },
}

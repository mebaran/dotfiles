vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
require('conform').setup {
    formatters_by_ft = {
        css = { "prettierd" },
        go = { "goimports", "golines", "gofumpt" },
        html = { "prettierd" },
        javascript = { "prettierd" },
        lua = { "stylua" },
        python = { "isort", "pyink" },
        sql = { "pg_format" },
        terraform = { "terraform_fmt" },
        tf = { "terraform_fmt" },
        ["terraform-vars"] = { "terraform_fmt" },
        -- -- Example of using dprint only when a dprint.json file is present
        -- dprint = {
        --   condition = function(ctx)
        --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
        --   end,
        -- },
    },
}
local keys = {
    {
        "<leader>cf",
        function()
            require("conform").format({ lsp_fallback = true })
        end,
        mode = { "n", "v" },
        desc = "Format via Conform",
    },
}
for _, k in ipairs(keys) do
    vim.keymap.set(k.mode, k[1], k[2], { desc = k.desc })
end

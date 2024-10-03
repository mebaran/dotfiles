return {
    {

        "williamboman/mason.nvim",
        cmd = "Mason",
        keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
        build = ":MasonUpdate",
        opts = {
            ensure_installed = {
                -- Lua
                "shfmt",
                "stylua",
                -- Golang
                "delve",
                "gofumpt",
                "goimports",
                "goimports-reviser",
                "golines",
                "gomodifytags",
                "gopls",
                "gotests",
                "gotestsum",
                "iferr",
                "impl",
                "nilaway",
                "revive",
                "templ",
                -- Python
                "autopep8",
                "debugpy",
                "isort",
                "pyink",
                -- Java
                "java-debug-adapter",
                "java-test",
                "jdtls",
                -- SQL
                "sqlfluff",
                "sqls",
                -- Javascript
                "eslint_d",
                "prettierd",
                "typescript-language-server",
                -- Teraform
                "terraform-ls",
            },
        },
        ---@param opts MasonSettings | {ensure_installed: string[]}
        config = function(_, opts)
            require("mason").setup(opts)
            local mr = require("mason-registry")
            local function ensure_installed()
                for _, tool in ipairs(opts.ensure_installed) do
                    local p = mr.get_package(tool)
                    if not p:is_installed() then
                        p:install()
                    end
                end
            end
            if mr.refresh then
                mr.refresh(ensure_installed)
            else
                ensure_installed()
            end
        end,
    },
}

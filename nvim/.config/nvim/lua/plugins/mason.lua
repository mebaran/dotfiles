local function mason_dap_setup()
    local mason_dap = require("mason-nvim-dap")
    mason_dap.setup({
        automatic_installation = false,
        ensure_installed = { "python", "javadbg", "coreclr" },
        automatic_setup = true,
    })
end

local function efmls_setup()
    local efmls = require("efmls-configs")
    efmls.init({
        -- Use a list of default configurations
        -- set by this plugin
        -- (Default: false)
        default_config = true,
        init_options = {
            documentFormatting = true,
        },
    })
    efmls.setup()
end

local function mason_lsp_setup()
    local LSP_SETUP_DISABLED = function() end
    local LSP_CUSTOM_SETUP = {
        jdtls = LSP_SETUP_DISABLED,
    }
    local opts = {
        ensure_installed = {
            "lua_ls",
            "pyright",
            "csharp_ls",
            "jdtls",
            "tsserver",
            "astro",
        },
    }
    local mlsp = require("mason-lspconfig")
    mlsp.setup(opts)
    local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
    local lspconfig = require("lspconfig")
    mlsp.setup_handlers({
        function(server_name)
            local custom_setup = LSP_CUSTOM_SETUP[server_name]
            if custom_setup then
                custom_setup()
            else
                lspconfig[server_name].setup({
                    capabilities = lsp_capabilities,
                })
            end
        end,
    })
end

return {
    {

        "williamboman/mason.nvim",
        cmd = "Mason",
        keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
        build = ":MasonUpdate",
        opts = {
            ensure_installed = {
                "stylua",
                "shfmt",
                -- Python
                "flake8",
                "autopep8",
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
    {
        "creativenull/efmls-configs-nvim",
        lazy = true,
        dependencies = {
            "neovim/nvim-lspconfig",
            "williamboman/mason.nvim"
        },
        config = efmls_setup,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = true,
        config = mason_lsp_setup,
        dependencies = {
            "williamboman/mason.nvim",
        },
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        lazy = true,
        config = mason_dap_setup,
        dependencies = {
            "williamboman/mason.nvim",
        },
    },
}

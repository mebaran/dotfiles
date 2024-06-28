local function lsp_callback(bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Buffer local mappings.
    local function opts_desc(desc)
        return { buffer = bufnr, desc = desc }
    end
    local map = vim.keymap.set
    map("n", "gD", vim.lsp.buf.declaration, opts_desc("Goto declaration"))
    map("n", "gd", vim.lsp.buf.definition, opts_desc("Goto definition"))
    map("n", "gI", vim.lsp.buf.implementation, opts_desc("Goto implementation"))
    map("n", "gr", vim.lsp.buf.references, opts_desc("Goto references"))
    map("n", "K", vim.lsp.buf.hover, {})
    map({ "i", "n" }, "<C-k>", vim.lsp.buf.signature_help, opts_desc("Signature help"))
    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts_desc("Add workspace folder"))
    map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts_desc("Remove workspace folder"))
    map("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts_desc("Print workspace folders list"))
    map("n", "<leader>gy", vim.lsp.buf.type_definition, opts_desc("Goto t(y)pe definition"))
    map("n", "<leader>cr", vim.lsp.buf.rename, opts_desc("Code rename"))
    map("n", "<leader>ca", vim.lsp.buf.code_action, opts_desc("Code action"))
    map({ "n", "v" }, "<leader>=", vim.lsp.buf.format, opts_desc("Code format"))
end

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        lsp_callback(ev.buf)
    end,
})

return {
    -- lspconfig
    {
        "neovim/nvim-lspconfig",
        -- event = "LazyFile",
        dependencies = {
            { "folke/neoconf.nvim", opts = {} },
            { "williamboman/mason-lspconfig.nvim", opts = {} },
            {
                "b0o/SchemaStore.nvim",
                lazy = true,
                version = false, -- last release is way too old
            },
        },
        ---@class PluginLspOpts
        opts = {
            -- add any global capabilities here
            capabilities = {},
            -- Automatically format on save
            -- options for vim.lsp.buf.format
            -- `bufnr` and `filter` is handled by the LazyVim formatter,
            -- but can be also overridden when specified
            -- LSP Server Settings
            ---@type lspconfig.options
            servers = {
                jsonls = {
                    -- lazy-load schemastore when needed
                    on_new_config = function(new_config)
                        new_config.settings.json.schemas = new_config.settings.json.schemas or {}
                        vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
                    end,
                    settings = {
                        json = {
                            format = {
                                enable = true,
                            },
                            validate = { enable = true },
                        },
                    },
                },
                gopls = {
                    settings = {
                        gopls = {
                            gofumpt = true,
                            codelenses = {
                                gc_details = false,
                                generate = true,
                                regenerate_cgo = true,
                                run_govulncheck = true,
                                test = true,
                                tidy = true,
                                upgrade_dependency = true,
                                vendor = true,
                            },
                            hints = {
                                assignVariableTypes = true,
                                compositeLiteralFields = true,
                                compositeLiteralTypes = true,
                                constantValues = true,
                                functionTypeParameters = true,
                                parameterNames = true,
                                rangeVariableTypes = true,
                            },
                            analyses = {
                                fieldalignment = true,
                                nilness = true,
                                unusedparams = true,
                                unusedwrite = true,
                                useany = true,
                            },
                            usePlaceholders = true,
                            completeUnimported = true,
                            staticcheck = true,
                            directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
                            semanticTokens = true,
                        },
                    },
                },
            },

            -- you can do any additional lsp server setup here
            -- return true if you don't want this server to be setup with lspconfig
            ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
            setup = {
                jdtls = function()
                    return true
                end,
                -- example to setup with typescript.nvim
                -- tsserver = function(_, opts)
                --   require("typescript").setup({ server = opts })
                --   return true
                -- end,
                -- Specify * to use this function as a fallback for any server
                -- ["*"] = function(server, opts) end,
            },
        },
        ---@param opts PluginLspOpts
        config = function(_, opts)
            local servers = opts.servers
            local cmp_nvim_lsp = require("cmp_nvim_lsp")
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                cmp_nvim_lsp.default_capabilities() or {},
                opts.capabilities or {}
            )

            local function setup(server)
                local server_opts = vim.tbl_deep_extend("force", {
                    capabilities = vim.deepcopy(capabilities),
                }, servers[server] or {})
                require("lspconfig")[server].setup(server_opts)
            end

            -- get all the servers that are available through mason-lspconfig
            local mlsp = require("mason-lspconfig")
            local all_mlsp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
            for server, _ in pairs(vim.tbl_keys(servers)) do
                if not all_mlsp_servers[server] then
                    setup(server)
                end
            end
            mlsp.setup({ handlers = { setup } })
        end,
    },
}

local function lsp_callback(bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
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
            { "folke/neodev.nvim", opts = {} },
            "williamboman/mason-lspconfig.nvim",
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
                lua_ls = {
                    -- mason = false, -- set to false if you don't want this server to be installed with mason
                    -- Use this to add any additional keymaps
                    -- for specific lsp servers
                    ---@type LazyKeys[]
                    -- keys = {},
                    settings = {
                        Lua = {
                            workspace = {
                                checkThirdParty = false,
                            },
                            completion = {
                                callSnippet = "Replace",
                            },
                        },
                    },
                },
            },
            -- you can do any additional lsp server setup here
            -- return true if you don't want this server to be setup with lspconfig
            ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
            setup = {
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
            local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                has_cmp and cmp_nvim_lsp.default_capabilities() or {},
                opts.capabilities or {}
            )

            local function setup(server)
                local server_opts = vim.tbl_deep_extend("force", {
                    capabilities = vim.deepcopy(capabilities),
                }, servers[server] or {})

                if opts.setup[server] then
                    if opts.setup[server](server, server_opts) then
                        return
                    end
                elseif opts.setup["*"] then
                    if opts.setup["*"](server, server_opts) then
                        return
                    end
                end
                require("lspconfig")[server].setup(server_opts)
            end

            -- get all the servers that are available through mason-lspconfig
            local have_mason, mlsp = pcall(require, "mason-lspconfig")
            local all_mslp_servers = {}
            if have_mason then
                all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
            end

            local ensure_installed = {} ---@type string[]
            for server, server_opts in pairs(servers) do
                if server_opts then
                    server_opts = server_opts == true and {} or server_opts
                    -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
                    if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
                        setup(server)
                    else
                        ensure_installed[#ensure_installed + 1] = server
                    end
                end
            end

            if have_mason then
                mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })
            end
        end,
    },
}

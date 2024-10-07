local tools = {
    -- Lua
    "shfmt",
    "stylua",
    "lua-language-server",
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
    "basedpyright",
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
}

require("mason").setup()
local mr = require("mason-registry")
local function ensure_installed()
    for _, tool in ipairs(tools) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
            p:install()
        end
    end
end
mr.refresh(ensure_installed)

local servers = {
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
}

local function lspsetup(server)
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        cmp_nvim_lsp.default_capabilities() or {}
    )
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
        lspsetup(server)
    end
end
mlsp.setup({ handlers = { lspsetup } })

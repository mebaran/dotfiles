-- Mappings and utility functions borrowed from LazyVim

local telescope_setup = function()
    local telescope = require('telescope')
    telescope.load_extension('fzf')
    telescope.load_extension('ui-select')
    telescope.setup()
end

local function get_root()
    local root_patterns = { ".git", "lua" }

    ---@type string?
    local path = vim.api.nvim_buf_get_name(0)
    path = path ~= "" and vim.loop.fs_realpath(path) or nil
    ---@type string[]
    local roots = {}
    if path then
        for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
            local workspace = client.config.workspace_folders
            local paths = workspace and vim.tbl_map(function(ws)
                    return vim.uri_to_fname(ws.uri)
                end, workspace) or client.config.root_dir and { client.config.root_dir } or {}
            for _, p in ipairs(paths) do
                local r = vim.loop.fs_realpath(p)
                if path:find(r, 1, true) then
                    roots[#roots + 1] = r
                end
            end
        end
    end
    table.sort(roots, function(a, b)
        return #a > #b
    end)
    ---@type string?
    local root = roots[1]
    if not root then
        path = path and vim.fs.dirname(path) or vim.loop.cwd()
        ---@type string?
        root = vim.fs.find(root_patterns, { path = path, upward = true })[1]
        root = root and vim.fs.dirname(root) or vim.loop.cwd()
    end
    ---@cast root string
    return root
end

local function telescope_builtin(builtin, opts)
    local params = { builtin = builtin, opts = opts }
    local loader = function()
        builtin = params.builtin
        opts = params.opts
        opts = vim.tbl_deep_extend("force", { cwd = get_root() }, opts or {})
        if builtin == "files" then
            if vim.loop.fs_stat((opts.cwd or vim.loop.cwd()) .. "/.git") then
                opts.show_untracked = true
                builtin = "git_files"
            else
                builtin = "find_files"
            end
        end
        require("telescope.builtin")[builtin](opts)
    end
    return loader
end

return {
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        lazy = true
    },
    {
        'nvim-telescope/telescope-ui-select.nvim'
    },
    {
        "nvim-telescope/telescope.nvim",
        config = telescope_setup,
        dependencies = {
            "telescope-fzf-native.nvim",
            "nvim-lua/plenary.nvim"
        },
        cmd = 'Telescope',
        keys = {
            { "<leader>,",       "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
            { "<leader>/",       telescope_builtin("live_grep"),                     desc = "Find in Files (Grep)" },
            { "<leader>:",       "<cmd>Telescope command_history<cr>",               desc = "Command History" },
            { "<leader><space>", telescope_builtin("files"),                         desc = "Find Files (root dir)" },
            -- find
            { "<leader>fb",      "<cmd>Telescope buffers<cr>",                       desc = "Buffers" },
            { "<leader>ff",      telescope_builtin("files"),                         desc = "Find Files (root dir)" },
            { "<leader>fF",      telescope_builtin("files", { cwd = false }),        desc = "Find Files (cwd)" },
            { "<leader>fr",      "<cmd>Telescope oldfiles<cr>",                      desc = "Recent" },
            -- git
            { "<leader>gc",      "<cmd>Telescope git_commits<CR>",                   desc = "commits" },
            { "<leader>gs",      "<cmd>Telescope git_status<CR>",                    desc = "status" },
            -- search
            { "<leader>sa",      "<cmd>Telescope autocommands<cr>",                  desc = "Auto Commands" },
            { "<leader>sb",      "<cmd>Telescope current_buffer_fuzzy_find<cr>",     desc = "Buffer" },
            { "<leader>sc",      "<cmd>Telescope command_history<cr>",               desc = "Command History" },
            { "<leader>sC",      "<cmd>Telescope commands<cr>",                      desc = "Commands" },
            { "<leader>sd",      "<cmd>Telescope diagnostics<cr>",                   desc = "Diagnostics" },
            { "<leader>sg",      telescope_builtin("live_grep"),                     desc = "Grep (root dir)" },
            { "<leader>sG",      telescope_builtin("live_grep", { cwd = false }),    desc = "Grep (cwd)" },
            { "<leader>sh",      "<cmd>Telescope help_tags<cr>",                     desc = "Help Pages" },
            {
                "<leader>sH",
                "<cmd>Telescope highlights<cr>",
                desc =
                "Search Highlight Groups"
            },
            { "<leader>sk", "<cmd>Telescope keymaps<cr>",                      desc = "Key Maps" },
            { "<leader>sM", "<cmd>Telescope man_pages<cr>",                    desc = "Man Pages" },
            { "<leader>sm", "<cmd>Telescope marks<cr>",                        desc = "Jump to Mark" },
            { "<leader>so", "<cmd>Telescope vim_options<cr>",                  desc = "Options" },
            { "<leader>sR", "<cmd>Telescope resume<cr>",                       desc = "Resume" },
            { "<leader>sw", telescope_builtin("grep_string"),                  desc = "Word (root dir)" },
            { "<leader>sW", telescope_builtin("grep_string", { cwd = false }), desc = "Word (cwd)" },
            {
                "<leader>uC",
                telescope_builtin("colorscheme", { enable_preview = true }),
                desc =
                "Colorscheme with preview"
            },
            {
                "<leader>ss",
                telescope_builtin("lsp_document_symbols", {
                    symbols = {
                        "Class",
                        "Function",
                        "Method",
                        "Constructor",
                        "Interface",
                        "Module",
                        "Struct",
                        "Trait",
                        "Field",
                        "Property",
                    },
                }),
                desc = "Goto Symbol",
            },
            {
                "<leader>sS",
                telescope_builtin("lsp_workspace_symbols", {
                    symbols = {
                        "Class",
                        "Function",
                        "Method",
                        "Constructor",
                        "Interface",
                        "Module",
                        "Struct",
                        "Trait",
                        "Field",
                        "Property",
                    },
                }),
                desc = "Goto Symbol (Workspace)",
            },
        }
    }
}

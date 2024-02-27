return {
    -- Ensure java debugger and test packages are installed
    {
        "mfussenegger/nvim-jdtls",
        ft = "java",
        config = function()
            -- Find the extra bundles that should be passed on the jdtls command-line
            -- if nvim-dap is enabled with java debug/test.
            local mason_registry = require("mason-registry")
            local bundles = {} ---@type string[]
            if mason_registry.is_installed("java-debug-adapter") then
                local java_dbg_pkg = mason_registry.get_package("java-debug-adapter")
                local java_dbg_path = java_dbg_pkg:get_install_path()
                local jar_patterns = {
                    java_dbg_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar",
                }
                -- java-test also depends on java-debug-adapter.
                if mason_registry.is_installed("java-test") then
                    local java_test_pkg = mason_registry.get_package("java-test")
                    local java_test_path = java_test_pkg:get_install_path()
                    vim.list_extend(jar_patterns, {
                        java_test_path .. "/extension/server/*.jar",
                    })
                end
                for _, jar_pattern in ipairs(jar_patterns) do
                    for _, bundle in ipairs(vim.split(vim.fn.glob(jar_pattern), "\n")) do
                        table.insert(bundles, bundle)
                    end
                end
            end

            local find_root_dir = require("lspconfig.server_configurations.jdtls").default_config.root_dir
            -- How to find the project name for a given root dir.
            local find_project_name = function(root_dir)
                return root_dir and vim.fs.basename(find_root_dir(root_dir))
            end
            -- Where are the config and workspace dirs for a project?
            local jdtls_config_dir = function(project_name)
                return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/config"
            end
            local jdtls_workspace_dir = function(project_name)
                return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/workspace"
            end
            local function attach_jdtls()
                local fname = vim.api.nvim_buf_get_name(0)
                local pname = find_project_name(fname)
                local lombok_path = mason_registry.get_package('jdtls'):get_install_path() .. "/lombok.jar"
                -- Configuration can be augmented and overridden by opts.jdtls
                local config = {
                    cmd = {
                        "jdtls",
                        "--jvm-arg=-javaagent:" .. lombok_path,
                        "--jvm-arg=-Xbootclasspath/a:" .. lombok_path,
                        '-configuration', jdtls_config_dir(pname),
                        '-data', jdtls_workspace_dir(pname)
                    },
                    root_dir = find_root_dir(fname),
                    init_options = {
                        bundles = bundles,
                    },
                    -- enable CMP capabilities
                    capabilities = require("cmp_nvim_lsp").default_capabilities()
                }

                -- Existing server will be reused if the root_dir matches.
                require("jdtls").start_or_attach(config)
                -- not need to require("jdtls.setup").add_commands(), start automatically adds commands
            end

            -- Attach the jdtls for each java buffer. HOWEVER, this plugin loads
            -- depending on filetype, so this autocmd doesn't run for the first file.
            -- For that, we call directly below.
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "java",
                callback = attach_jdtls,
            })

            -- Setup keymap and dap after the lsp is fully attached.
            -- https://github.com/mfussenegger/nvim-jdtls#nvim-dap-configuration
            -- https://neovim.io/doc/user/lsp.html#LspAttach
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if client and client.name == "jdtls" then
                        local ckeys = {
                            ["<leader>cxv"] = { require("jdtls").extract_variable_all, "Extract Variable" },
                            ["<leader>cxc"] = { require("jdtls").extract_constant, "Extract Constant" },
                            ["gs"] = { require("jdtls").super_implementation, "Goto Super" },
                            ["gS"] = { require("jdtls.tests").goto_subjects, "Goto Subjects" },
                            ["<leader>co"] = { require("jdtls").organize_imports, "Organize Imports" },
                        } -- { mode = "n", buffer = args.buf })
                        for k, v in pairs(ckeys) do
                            vim.keymap.set('n', k, v[1], { buffer = args.buf, desc = v[2] })
                        end
                        local cvkeys = {
                            ["<leader>cxm"] = {
                                [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]],
                                "Extract Method",
                            },
                            ["<leader>cxv"] = {
                                [[<ESC><CMD>lua require('jdtls').extract_variable_all(true)<CR>]],
                                "Extract Variable",
                            },
                            ["<leader>cxc"] = {
                                [[<ESC><CMD>lua require('jdtls').extract_constant(true)<CR>]],
                                "Extract Constant",
                            },
                        } -- { mode = "v", buffer = args.buf })
                        for k, v in pairs(cvkeys) do
                            vim.keymap.set('v', k, v[1], { buffer = args.buf, desc = v[2] })
                        end

                        if mason_registry.is_installed("java-debug-adapter") then
                            -- custom init for Java debugger
                            require("jdtls").setup_dap()
                            require("jdtls.dap").setup_dap_main_class_configs()

                            -- Java Test require Java debugger to work
                            if mason_registry.is_installed("java-test") then
                                -- custom keymaps for Java test runner (not yet compatible with neotest)
                                local dapkeys = {
                                    ["<leader>tt"] = { require("jdtls.dap").test_class, "Run All Test" },
                                    ["<leader>tr"] = { require("jdtls.dap").test_nearest_method, "Run Nearest Test" },
                                    ["<leader>tT"] = { require("jdtls.dap").pick_test, "Run Test" },
                                }
                                for k, v in pairs(dapkeys) do
                                    vim.keymap.set('n', k, v[1], { buffer = args.buf, desc = v[2] })
                                end
                            end
                        end
                    end
                end,
            })
            attach_jdtls()
        end
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            -- make sure mason installs the server
            servers = {
                jdtls = {},
            },
            setup = {
                jdtls = function()
                    return true -- avoid duplicate servers
                end,
            },
        },
    }
}

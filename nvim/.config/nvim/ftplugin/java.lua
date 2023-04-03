local config = {
    -- The command that starts the language server
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    cmd = {
        'jdtls',
        "--jvm-arg=-javaagent:" .. vim.fn.glob('$MASON/packages/jdtls/lombok.jar', true)
    },
    -- 💀
    -- This is the default if not provided, you can remove it. Or adjust as needed.
    -- One dedicated LSP server & client will be started per unique root_dir
    root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'gradlew' }),
    -- Here you can configure eclipse.jdt.ls specific settings
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
    -- settings = {
    --     java = {
    --     }
    -- },
    -- Language server `initializationOptions`
    -- You need to extend the `bundles` with paths to jar files
    -- if you want to use additional eclipse.jdt.ls plugins.
    --
    -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
    --
    -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
    init_options = {
        bundles = {
            vim.fn.glob("$MASON/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", true)
        }
    },
    on_attach = function(client, bufnr)
        require('jdtls').setup_dap({ hotcodereplace = 'auto' })
        require('jdtls.setup').add_commands()
    end
}


-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
print('Booting JDTLS...')
require('jdtls').start_or_attach(config)

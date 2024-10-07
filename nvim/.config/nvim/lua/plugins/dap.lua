require("nvim-dap-virtual-text").setup({
    commented = true,
})

local dap, dapui = require("dap"), require("dapui")
dapui.setup({})

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

-- Python DAP
local path = require("mason-registry").get_package("debugpy"):get_install_path()
require("dap-python").setup(path .. "/venv/bin/python")

-- Go DAP
require("dap-go").setup()

    -- stylua: ignore
local keys = {
    {
        "<leader>dR",
        function() require("dap").run_to_cursor() end,
        desc = "Run to Cursor",
    },
    {
        "<leader>dE",
        function() require("dapui").eval(vim.fn.input "[Expression] > ") end,
        desc = "Evaluate Input",
    },
    {
        "<leader>dC",
        function() require("dap").set_breakpoint(vim.fn.input "[Condition] > ") end,
        desc = "Conditional Breakpoint",
    },
    {
        "<leader>dU",
        function() require("dapui").toggle() end,
        desc = "Toggle UI",
    },
    {
        "<leader>db",
        function() require("dap").step_back() end,
        desc = "Step Back",
    },
    {
        "<leader>dc",
        function() require("dap").continue() end,
        desc = "Continue",
    },
    {
        "<leader>dd",
        function() require("dap").disconnect() end,
        desc = "Disconnect",
    },
    {
        "<leader>de",
        function() require("dapui").eval() end,
        mode = { "n", "v" },
        desc = "Evaluate",
    },
    {
        "<leader>dg",
        function() require("dap").session() end,
        desc = "Get Session",
    },
    {
        "<leader>dh",
        function() require("dap.ui.widgets").hover() end,
        desc = "Hover Variables",
    },
    { "<leader>dS", function() require("dap.ui.widgets").scopes() end, desc = "Scopes", },
    { "<leader>di", function() require("dap").step_into() end,         desc = "Step Into", },
    { "<leader>do", function() require("dap").step_over() end,         desc = "Step Over", },
    { "<leader>dp", function() require("dap").pause.toggle() end,      desc = "Pause", },
    { "<leader>dq", function() require("dap").close() end,             desc = "Quit", },
    { "<leader>dr", function() require("dap").repl.toggle() end,       desc = "Toggle REPL", },
    { "<leader>ds", function() require("dap").continue() end,          desc = "Start", },
    {
        "<leader>dt",
        function() require("dap").toggle_breakpoint() end,
        desc = "Toggle Breakpoint",
    },
    { "<leader>dx", function() require("dap").terminate() end,                       desc = "Terminate", },
    { "<leader>du", function() require("dap").step_out() end,                        desc = "Step Out", },
    { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Debug Nearest" },
}
for _, k in ipairs(keys) do
    vim.keymap.set("n", k[1], k[2], { desc = k.desc })
end

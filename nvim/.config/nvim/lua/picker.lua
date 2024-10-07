local picker = require("mini.pick")
local extra = require("mini.extra")

vim.ui.select = picker.ui_select

local function l(k)
    return "<leader>" .. k
end

-- Key maps
local keys = {
    { l("ff"), picker.builtin.files, desc = "Pick files" },
    { l("bb"), picker.builtin.buffers, desc = "Pick buffers" },
    { l("sg"), picker.builtin.grep_live, desc = "Pick by grep (live)" },
    { l('"'),  extra.pickers.registers, desc = "Pick registers" },
    { l('sl'), extra.pickers.lsp, desc = "Pick LSP symbols" },
    { l("sk"), extra.pickers.keymaps, desc = "Pick keymaps" },
    { l("fo"), extra.pickers.oldfiles, desc = "Pick oldfiles" },
    { l("sc"), extra.pickers.treesitter, desc = "Pick code (nodes)" },
    {
        l("sc"),
        function()
            extra.pickers.history({ scope = ":" })
        end,
        desc = "Pick command (history)",
    },
    {
        l("s/"),
        function()
            extra.pickers.history({ scope = "/" })
        end,
    },
}

for _, k in ipairs(keys) do
    vim.keymap.set("n", k[1], k[2], { desc = k.desc })
end

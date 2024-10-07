local keys = {
    { "<C-l>", require("FTerm").toggle, mode = { "n", "t" }, desc = "Toggle Floating Term" },
}
for _, k in ipairs(keys) do
    vim.keymap.set(k.mode or {"n"}, k[1], k[2], { desc = k.desc })
end

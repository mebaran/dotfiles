require('neogen').setup({
    snippet_engine = "luasnip"
})
local keys = {
    {
        "<Leader>cd",
        function()
            require("neogen").generate({ type = "func" })
        end,
        desc = "Neogen function docstring",
    },
}
for _, k in ipairs(keys) do
    vim.keymap.set("n", k[1], k[2], { desc = k.desc })
end

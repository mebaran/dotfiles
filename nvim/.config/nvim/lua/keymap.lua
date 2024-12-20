local map = function(mode, keys, cmd, opts)
    local allopts = { silent = true }
    if opts then
        for k, v in pairs(opts) do
            allopts[k] = v
        end
    end
    vim.keymap.set(mode, keys, cmd, allopts)
end

--Quickfix and Location list
map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Open Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Open Quickfix List" })
map("n", "<leader>xc", "<cmd>cclose<cr>", { desc = "Close Quickfix / Location Buffer" })
map("n", "<leader>xb", "<C-w>b<C-w>c", { desc = "Close bottom window" })

--Q to close everywhere reasonable
vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "checkhealth",
        "fugitive*",
        "git",
        "help",
        "lspinfo",
        "netrw",
        "notify",
        "qf",
        "query",
        "sqls_output",
    },
    callback = function()
        map("n", "q", vim.cmd.close, { desc = "Close the current buffer", buffer = true })
    end,
})

-- Window resize
map("n", "<C-Left>", "<Cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Down>", "<Cmd>resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Up>", "<Cmd>resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Right>", "<Cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- Terminal
map("t", "<C-W>", [[<C-\><C-N><C-w>]], { desc = "Focus other window" })
map("t", "<C-x>", [[<C-\><C-n>]], { desc = "Quick access to normal mode" })
map("n", "<leader>tv", "<cmd>vsplit | terminal <cr>", { desc = "Split terminal vertically" })
map("n", "<leader>tx", "<cmd>split | terminal<cr>", { desc = "Split terminal horizontally" })

--Diagnostics
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open diagnostic float" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Goto next diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Goto previous diagnostic" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Set loclist with diagnostic locations" })

--Useful borrowings from LazyNvim below:

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
    "n",
    "<leader>ur",
    "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
    { desc = "Redraw / clear hlsearch / diff update" }
)

map({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

map("x", ">", ">gv", { desc = "Indent selection" })
map("x", "<", "<gv", { desc = "Unindent selection" })

--LSP key maps
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

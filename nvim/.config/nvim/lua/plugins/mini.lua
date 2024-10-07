local rs = function(s, t)
    require(s).setup(t)
end

local ai = require("mini.ai")
rs("mini.ai", {
    custom_textobjects = {
        o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
        }, {}),
        f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
        c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
    },
})
rs("mini.basics", {
    options = {
        extra_ui = true,
    },
})
rs("mini.bufremove")
rs("mini.bracketed")
rs("mini.clue", {
    triggers = {
        -- Leader triggers
        { mode = "n", keys = "<Leader>" },
        { mode = "x", keys = "<Leader>" },

        -- Built-in completion
        { mode = "i", keys = "<C-x>" },

        -- `g` key
        { mode = "n", keys = "g" },
        { mode = "x", keys = "g" },

        -- Marks
        { mode = "n", keys = "'" },
        { mode = "n", keys = "`" },
        { mode = "x", keys = "'" },
        { mode = "x", keys = "`" },

        -- Registers
        { mode = "n", keys = '"' },
        { mode = "x", keys = '"' },
        { mode = "i", keys = "<C-r>" },
        { mode = "c", keys = "<C-r>" },

        -- Window commands
        { mode = "n", keys = "<C-w>" },

        -- `z` key
        { mode = "n", keys = "z" },
        { mode = "x", keys = "z" },

        -- `Brackets`
        { mode = "n", keys = "[" },
        { mode = "n", keys = "]" },
        { mode = "x", keys = "[" },
        { mode = "x", keys = "]" },
    },
    clues = {
        -- Enhance this by adding descriptions for <Leader> mapping groups
        require("mini.clue").gen_clues.builtin_completion(),
        require("mini.clue").gen_clues.g(),
        require("mini.clue").gen_clues.marks(),
        -- require('mini.clue').gen_clues.registers(),
        require("mini.clue").gen_clues.windows(),
        require("mini.clue").gen_clues.z(),

        -- Submode for quick buffer navigation
        { mode = "n", keys = "]b", postkeys = "]" },
        { mode = "n", keys = "]w", postkeys = "]" },
        { mode = "n", keys = "[b", postkeys = "[" },
        { mode = "n", keys = "[w", postkeys = "[" },
    },
})
rs("mini.comment")
rs("mini.files")
rs("mini.icons")
rs("mini.indentscope", { try_as_border = true })
rs("mini.jump")
rs("mini.notify")
rs("mini.pairs")
rs("mini.starter")
rs("mini.surround", {
    mappings = {
        add = "gsa",
        delete = "gsd",
        find = "gsf",
        find_left = "gsF",
        highlight = "gsh",
        replace = "gsr",
        update_n_lines = "gsn",
    },
})

--Mini Indentscope
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "dbui", "terminal", "help", "alpha", "dashboard", "trouble", "lazy", "mason", "nofile" },
    callback = function()
        vim.b.miniindentscope_disable = true
    end,
})
vim.api.nvim_create_autocmd("TermOpen", {
    callback = function()
        vim.b.miniindentscope_disable = true
    end,
})

-- Mini BufDelete
local function bufdelete(force)
    return function()
        MiniBufremove.delete(nil, force)
    end
end
vim.keymap.set("n", "<leader>bd", bufdelete(false), { desc = "Delete buffer" })
vim.keymap.set("n", "<leader>bD", bufdelete(true), { desc = "Force delete buffer" })

-- Mini Files Vinegar minus
local function mini_minus()
    MiniFiles.open(vim.api.nvim_buf_get_name(0))
end
vim.keymap.set("n", "-", mini_minus, { desc = "Open Mini Files over current file" })

-- Mini Files explorer buffer customization
local show_dotfiles = true
local filter_show = function(fs_entry)
    return true
end
local filter_hide = function(fs_entry)
    return not vim.startswith(fs_entry.name, ".")
end
local toggle_dotfiles = function()
    show_dotfiles = not show_dotfiles
    local new_filter = show_dotfiles and filter_show or filter_hide
    MiniFiles.refresh({ content = { filter = new_filter } })
end
local function mini_enter()
    MiniFiles.go_in({ close_on_file = true })
end
local function map_split(buf_id, lhs, direction)
    local rhs = function()
        -- Make new window and set it as target
        local new_target_window
        local exp_target_window = MiniFiles.get_explorer_state().target_window
        vim.api.nvim_win_call(exp_target_window, function()
            vim.cmd(direction .. " split")
            new_target_window = vim.api.nvim_get_current_win()
        end)

        MiniFiles.set_target_window(new_target_window)
        mini_enter()
    end

    -- Adding `desc` will result into `show_help` entries
    local desc = "Split " .. direction
    vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
end
vim.api.nvim_create_autocmd("User", {
    pattern = "MiniFilesBufferCreate",
    callback = function(args)
        local buf_id = args.data.buf_id
        vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id })
        vim.keymap.set("n", "-", MiniFiles.go_out, { buffer = buf_id })
        vim.keymap.set("n", "<CR>", mini_enter, { buffer = buf_id })
        map_split(buf_id, "<C-x>", "belowright horizontal")
        map_split(buf_id, "<C-v>", "belowright vertical")
    end,
})

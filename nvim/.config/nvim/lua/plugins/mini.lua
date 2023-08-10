local function mini_setup()
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
    rs("mini.comment")
    rs("mini.files")
    rs("mini.indentscope", { try_as_border = true })
    rs("mini.jump")
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
        pattern = { "terminal", "help", "alpha", "dashboard", "Trouble", "lazy", "mason", "nofile" },
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
        local fs_entry = MiniFiles.get_fs_entry()
        local is_at_file = fs_entry ~= nil and fs_entry.fs_type == "file"
        MiniFiles.go_in()
        if is_at_file then
            MiniFiles.close()
        end
    end
    vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
            local buf_id = args.data.buf_id
            vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id })
            vim.keymap.set("n", "-", MiniFiles.go_out, { buffer = buf_id })
            vim.keymap.set("n", "<CR>", mini_enter, { buffer = buf_id })
        end,
    })
end

return {
    "echasnovski/mini.nvim",
    config = mini_setup,
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
}

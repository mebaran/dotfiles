local function mini_setup()
    local rs = function(s, t)
        require(s).setup(t)
    end
    rs('mini.ai')
    rs('mini.basics', {
        options = {
            extra_ui = true
        }
    })
    rs('mini.bufremove')
    rs('mini.bracketed')
    rs('mini.files')
    rs('mini.jump')
    rs('mini.pairs')
    rs('mini.starter')
    rs('mini.surround')

    rs('mini.indentscope', { try_as_border = true })

    --Mini Indentscope
    vim.api.nvim_create_autocmd("FileType", {
        pattern = { "terminal", "help", "alpha", "dashboard", "Trouble", "lazy", "mason", "nofile" },
        callback = function()
            vim.b.miniindentscope_disable = true
        end
    })

    -- Mini BufDelete
    local function bufdelete(force)
        return function()
            MiniBufremove.delete(nil, force)
        end
    end
    vim.keymap.set('n', '<leader>bd', bufdelete(false), { desc = 'Delete buffer' })
    vim.keymap.set('n', '<leader>bD', bufdelete(true), { desc = 'Force delete buffer' })

    -- Mini Files Vinegar minus
    local function mini_minus()
        MiniFiles.open(vim.api.nvim_buf_get_name(0))
    end
    vim.keymap.set('n', '-', mini_minus, { desc = 'Open Mini Files over current file' })

    -- Mini Files explorer buffer customization
    local show_dotfiles = true
    local filter_show = function(fs_entry) return true end
    local filter_hide = function(fs_entry)
        return not vim.startswith(fs_entry.name, '.')
    end
    local toggle_dotfiles = function()
        show_dotfiles = not show_dotfiles
        local new_filter = show_dotfiles and filter_show or filter_hide
        MiniFiles.refresh({ content = { filter = new_filter } })
    end
    vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        callback = function(args)
            local buf_id = args.data.buf_id
            vim.keymap.set('n', 'g.', toggle_dotfiles, { buffer = buf_id })
            vim.keymap.set('n', '-', MiniFiles.go_out, { buffer = buf_id })
            vim.keymap.set('n', '<CR>', MiniFiles.go_in, {buffer = buf_id })
        end,
    })
end

return {
    "echasnovski/mini.nvim",
    config = mini_setup
}

local function tabby_setup()
    local theme = {
        fill = 'Visual',
        tab = 'StatusLine',
        win = 'StatusLine',
        head = 'StatusLine',
        tail = 'StatusLine',
    }
    require('tabby.tabline').set(function(line)
        return {
            {
                { '  ', hl = theme.head },
                line.sep('', theme.head, theme.fill),
            },
            line.tabs().foreach(function(tab)
                local hl = tab.is_current() and theme.current_tab or theme.tab
                return {
                    line.sep('', hl, theme.fill),
                    tab.is_current() and '' or '',
                    tab.number(),
                    tab.name(),
                    -- tab.close_btn(''), -- show a close button
                    line.sep('', hl, theme.fill),
                    hl = hl,
                    margin = ' ',
                }
            end),
            line.spacer(),
            -- shows list of windows in tab
            -- line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
            --   return {
            --     line.sep('', theme.win, theme.fill),
            --     win.is_current() and '' or '',
            --     win.buf_name(),
            --     line.sep('', theme.win, theme.fill),
            --     hl = theme.win,
            --     margin = ' ',
            --   }
            -- end),
            {
                line.sep('', theme.tail, theme.fill),
                { '  ', hl = theme.tail },
            },
            hl = theme.fill,
        }
    end)
end

return {
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            globalstatus = true
        },
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        }
    },
    {
        "nanozuki/tabby.nvim",
        config = tabby_setup,
        event = "VeryLazy",
    }
}

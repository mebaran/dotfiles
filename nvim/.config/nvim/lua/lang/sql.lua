return {
    {
        'nanotee/sqls.nvim',
        event = 'LspAttach',
        setup = function()
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if client and client.name == "sqls" then
                        require('sqls').on_attach(client, args.buf)
                    end
                end
            })
        end
    },
}

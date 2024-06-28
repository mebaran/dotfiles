return {
    {
        "nanotee/sqls.nvim",
        config = function()
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("SqlsNvim", { clear = true }),
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if client and client.name == "sqls" then
                        print("Setting up sqls.nvim...")
                        require("sqls").on_attach(client, args.buf)
                    end
                end,
            })
        end,
    },
}

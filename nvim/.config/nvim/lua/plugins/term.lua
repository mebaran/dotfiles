return {
    {
        'numtostr/Fterm.nvim',
        config = true,
        keys = {
            {  '<C-l>', '<cmd>lua require("FTerm").toggle()<cr>', mode = { 'n' , 't' }, desc = 'Toggle FTerm' }
        }
    }
}

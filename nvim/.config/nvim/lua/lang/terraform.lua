vim.api.nvim_create_autocmd("FileType", {
    pattern = { "hcl", "terraform" },
    desc = "terraform/hcl commentstring configuration",
    command = "setlocal commentstring=#\\ %s",
})

return {}

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "hcl", "terraform" },
    desc = "terraform/hcl commentstring configuration",
    command = "setlocal commentstring=#\\ %s",
})

return {
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                terraform = { "terraform_fmt" },
                tf = { "terraform_fmt" },
                ["terraform-vars"] = { "terraform_fmt" },
            },
        },
    },
}

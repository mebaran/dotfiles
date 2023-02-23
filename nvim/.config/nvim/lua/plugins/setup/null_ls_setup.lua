local null_ls = require("null-ls")

null_ls.setup {
  sources = {
    null_ls.builtins.code_actions.gitsigns,
    -- Python
    null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.autopep8,
  }
}

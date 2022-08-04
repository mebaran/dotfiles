local ionide = require('ionide')
local lsp = require('lsp-zero')

vim.g["fsharp#lsp_auto_setup"] = 0
ionide_lsp = lsp.build_options('fsautocomplete', {})
ionide.setup(ionide_lsp)

local function lsp_callback(bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

	-- Buffer local mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local function opts_desc(desc)
		return { buffer = bufnr, desc = desc }
	end
	local map = vim.keymap.set
	map("n", "gD", vim.lsp.buf.declaration, opts_desc("Goto declaration"))
	map("n", "gd", vim.lsp.buf.definition, opts_desc("Goto definition"))
	map("n", "gI", vim.lsp.buf.implementation, opts_desc("Goto implementation"))
	map("n", "gr", vim.lsp.buf.references, opts_desc("Goto references"))
	map("n", "K", vim.lsp.buf.hover, {})
	map({ "i", "n" }, "<C-k>", vim.lsp.buf.signature_help, opts_desc("Signature help"))
	map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts_desc("Add workspace folder"))
	map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts_desc("Remove workspace folder"))
	map("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, opts_desc("Print workspace folders list"))
	map("n", "<leader>gy", vim.lsp.buf.type_definition, opts_desc("Goto t(y)pe definition"))
	map("n", "<leader>cr", vim.lsp.buf.rename, opts_desc("Code rename"))
	map("n", "<leader>ca", vim.lsp.buf.code_action, opts_desc("Code action"))
	map({ "n", "v" }, "<leader>=", vim.lsp.buf.format, opts_desc("Code format"))
end

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		lsp_callback(ev.buf)
	end,
})

return {
	-- LSP Support
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "LspInfo", "LspInstall", "LspUninstall" },
		config = function ()
		    local lspconfig = require('lspconfig')
            lspconfig.jdtls.setup = function () return true end
		end,
        dependencies = {
			{
				"folke/neodev.nvim",
			},
			"williamboman/mason-lspconfig.nvim",
		},
	},
}

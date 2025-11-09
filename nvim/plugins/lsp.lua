return {
	{
		"folke/noice.nvim",
		opts = {
			presets = {
				lsp_doc_border = true,
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			codelens = {
				enabled = false,
			},
			inlay_hints = { enabled = true },
			servers = {
				bashls = {
					filetypes = { "sh", "zsh" },
				},
			},
		},
	},
}

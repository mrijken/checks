return {
	{
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").setup({
				bind = true, -- This is mandatory
				handler_opts = {
					border = "rounded", -- Options: 'single', 'double', 'shadow', 'none', 'rounded'
				},
			})
		end,
	},
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
		},
	},
}

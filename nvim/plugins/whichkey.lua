return {
	{
		"folke/which-key.nvim",
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = true })
				end,
				desc = "Buffer Keymaps (which-key global)",
			},
		},
	},
}

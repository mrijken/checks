return {
	{
		"jeangiraldoo/codedocs.nvim",
		opts = {
			default_styles = { python = "Google" },
		},
		keys = {
			{
				"<leader>k",
				function()
					require("codedocs").insert_docs()
				end,
				desc = "Insert docstring",
			},
		},
	},
}

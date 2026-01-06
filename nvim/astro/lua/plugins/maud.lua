return {
	{
		"eboody/maud-fmt.nvim",
		config = function()
			require("maud-fmt").setup()
		end,
		ft = "rust", -- Only load for Rust files
	},
	-- alternative: https://github.com/Jeosas/maudfmt
	-- {
	-- 	"stevearc/conform.nvim",
	-- 	optional = true,
	-- 	opts = {
	-- 		formatters = {
	-- 			maudfmt = {
	-- 				command = "maudfmt",
	-- 				args = { "-s" }, -- add any config you wish
	-- 			},
	-- 		},
	-- 		formatters_by_ft = {
	-- 			rust = { "rustfmt", "maudfmt" },
	-- 		},
	-- 	},
	-- },
}

return {
	{
		"emrearmagan/atlas.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- optional but recommended
			"MeanderingProgrammer/render-markdown.nvim", -- optional but recommended
			"esmuellert/codediff.nvim", -- optional (PullRequest diff)
			"sindrets/diffview.nvim", -- optional; or "dlyongemallo/diffview-plus.nvim"
		},
		-- See Configuration below
		---@type AtlasConfig
		opts = {
			providers = {
				---@type AtlasGitHubConfig
				github = {
					cache_ttl = 300, -- Set to 0 to disable caching.
				},

				---@type AtlasGitLabConfig
				gitlab = {
					base_url = "https://gitlab.com",
					-- Personal Access Token with `api` scope:
					-- https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html
					token = "glpat-74KV4YjOGNKVuZkHwFSpo2M6MQpvOjEKdToyZDRyDg.01.160oj9mgy",
					-- token = vim.env.GITLAB_TOKEN,
					cache_ttl = 300, -- Set to 0 to disable caching.
				},
			},
		},
	},
}

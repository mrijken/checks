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
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = function(_, opts)
			local function read_json_servers(path)
				local f = io.open(path, "r")
				if not f then
					return {}
				end
				local content = f:read("*a")
				f:close()
				local ok, decoded = pcall(vim.fn.json_decode, content)
				if not ok or type(decoded) ~= "table" then
					return {}
				end
				return decoded.servers or {}
			end

			local json_path = vim.fn.stdpath("config") .. "/lua/plugins/lsp.json"
			local servers = read_json_servers(json_path)

			-- merge with any existing ensure_installed
			-- opts.ensure_installed = vim.tbl_extend("force", opts.ensure_installed or {}, servers)
			opts.ensure_installed = servers
		end,
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},
}

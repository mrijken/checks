return {
	"nvim-neotest/neotest-python",
	dependencies = {
		"nvim-neotest/neotest-python",
	},
	opt = {
		adapters = {
			["neotest-python"] = {
				runner = "pytest",
			},
		},
	},
}

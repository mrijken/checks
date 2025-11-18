-- vim.cmd.colorscheme("dracula")

vim.opt.wrap = false
vim.opt.number = true
vim.opt.relativenumber = true

-- Set tab width to 4 spaces
vim.opt.tabstop = 4

-- Set the number of spaces to use for each step of (auto)indent
vim.opt.shiftwidth = 4

-- Use spaces instead of tabs
vim.opt.expandtab = true

-- Ensure indentation when editing existing files follows the same
vim.opt.softtabstop = 4

-- Cursor settings
vim.opt.guicursor = "n-v-c-sm-i-ci-ve:block,r-cr-o:hor20,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor"
vim.o.scrolloff = 10

vim.g.autoformat = true

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- make the bg color black
-- vim.o.background = "dark"
-- vim.cmd("highlight Normal guibg=black")

-- Change the background color of floating windows
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#3f4145" }) -- background color

-- Optionally, change the border color of floating windows
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#1e222a", fg = "#ffffff" }) -- Replace with desired color

-- Enable persistent undo
vim.opt.undofile = true

-- Set undo directory to LazyVim's location
vim.opt.undodir = vim.fn.expand("~/.local/share/nvim/undo")

-- Reasonable limits for undo history
vim.opt.undolevels = 500 -- Save up to 500 undo steps per file
vim.opt.undoreload = 5000 -- Reload up to 5000 lines for undo

--autoread files
vim.opt.autoread = true

-- Enable highlighting for the word under the cursor
vim.opt.cursorline = true -- Highlight the current line

-- Enable automatic spell checking
vim.opt.spell = true

--  show ruler
vim.opt.ruler = true

-- Enable border around floating windows
vim.opt.winborder = "rounded"

-- TODO: move to python
vim.g.lazyvim_python_lsp = "pyrefly"
vim.lsp.config["basedpyright"] = {
	settings = {
		basedpyright = {
			analysis = {
				diagnosticMode = "workspace",
				diagnosticSeverityOverrides = {
					reportUnusedImport = false,
				},
				typeCheckingMode = "basic",
			},
		},
	},
}

-- TODO: Move to snack options
vim.g.snacks_animate = false

-- WSL Clipboard support
local is_wsl = vim.fn.has("wsl") == 1
if is_wsl then
	-- This is NeoVim's recommended way to solve clipboard sharing if you use WSL
	-- See: https://github.com/neovim/neovim/wiki/FAQ#how-to-use-the-windows-clipboard-from-wsl
	vim.g.clipboard = {
		name = "wsl-clip",
		copy = {
			["+"] = "clip.exe",
			["*"] = "clip.exe",
		},
		paste = {
			["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
			["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
		},
		cache_enabled = 0,
	}
else
	-- https://www.reddit.com/r/neovim/comments/1e9vllk/neovim_weird_issue_when_copypasting_using_osc_52/
	vim.o.clipboard = "unnamedplus"

	local function paste()
		return {
			vim.fn.split(vim.fn.getreg(""), "\n"),
			vim.fn.getregtype(""),
		}
	end

	vim.g.clipboard = {
		name = "OSC 52",
		copy = {
			["+"] = require("vim.ui.clipboard.osc52").copy("+"),
			["*"] = require("vim.ui.clipboard.osc52").copy("*"),
		},
		paste = {
			["+"] = paste,
			["*"] = paste,
		},
	}
end

-- TODO: move to lsp options
vim.keymap.set("n", "K", '<cmd>lua vim.lsp.buf.hover({border = "single"})<cr>')
vim.keymap.set("i", "<C-s>", '<cmd>lua vim.lsp.buf.signature_help({border = "single"})<cr>')

-- do not use swapfile
vim.opt.swapfile = false

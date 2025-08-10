local configs = require("nvim-treesitter.configs")

configs.setup({
	highlight = { enable = true },
	indent = { enable = true },
	ensure_installed = { "lua" },
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
			},
		}
	},
})

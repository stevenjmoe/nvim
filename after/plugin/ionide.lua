-- Basic Ionide settings

-- File type specific settings
vim.api.nvim_create_autocmd("FileType", {
	pattern = "fsharp",
	callback = function()
		-- Indentation settings
		vim.bo.expandtab = true
		vim.bo.shiftwidth = 4
		vim.bo.softtabstop = 4
		vim.bo.tabstop = 4
		vim.bo.commentstring = "// %s"
	end
})

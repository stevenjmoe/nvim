vim.g['fsharp#fsautocomplete_command'] = {
	'dotnet',
	'fsautocomplete',
	'--background-service-enabled'
}

vim.g['fsharp#lsp_auto_setup'] = 0
vim.g['fsharp#exclude_project_directories'] = { 'paket-files' }

-- Set up tooltip on cursor hold
--vim.opt.updatetime = 1000
--vim.api.nvim_create_autocmd("CursorHold", {
--	pattern = { "*.fs", "*.fsi", "*.fsx" },
--	callback = function()
--		vim.fn['fsharp#showTooltip']()
--	end
--})

-- Optional: Modify LSP handlers
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
	vim.lsp.handlers.hover, { focusable = false }
)

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		virtual_text = {
			prefix = '!',
		},
	}
)

-- Set indentation to 4 spaces for F# files
vim.api.nvim_create_autocmd("FileType", {
	pattern = "fsharp",
	callback = function()
		vim.bo.expandtab = true -- Use spaces instead of tabs
		vim.bo.shiftwidth = 4 -- Set indentation width to 4 spaces
		vim.bo.tabstop = 4  -- Set tab width to 4 spaces
		vim.bo.softtabstop = 4 -- Set soft tab stop to 4 spaces
	end,
})

-- Optionally, you can add a key mapping to retab the file
vim.api.nvim_create_autocmd("FileType", {
	pattern = "fsharp",
	callback = function()
		vim.keymap.set("n", "<leader>rt", ":retab<CR>", { buffer = true, silent = true })
	end,
})

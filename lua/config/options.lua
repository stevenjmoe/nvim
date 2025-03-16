vim.opt.relativenumber = true
vim.opt.nu = true
vim.opt.hlsearch = false
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.undofile = true
vim.opt.smarttab = true
vim.opt.cc = "80"
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.hidden = false

-- Ocaml specific settings
--vim.opt.rtp:prepend("~/.opam/default/share/ocp-indent/vim")
vim.api.nvim_create_autocmd("FileType", {
	pattern = "ocaml",
	callback = function()
		vim.opt_local.shiftwidth = 2
		vim.opt_local.tabstop = 2
		vim.opt.cc = "100"
	end
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "gleam",
	callback = function()
		vim.opt_local.shiftwidth = 2
		vim.opt_local.tabstop = 2
	end
})

-- Other autocmds
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking text',
	group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.g.netrw_bufsettings = "noma nomod nu nobl nowrap ro rnu"

vim.g.omni_sql_no_default_maps = 1
vim.opt.conceallevel = 2

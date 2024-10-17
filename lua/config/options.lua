vim.opt.relativenumber = true
vim.opt.hlsearch = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.undofile = true
vim.opt.smarttab = true
vim.opt.cc = "80"
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"

-- Ocaml specific settings
--vim.opt.rtp:prepend("~/.opam/default/share/ocp-indent/vim")
vim.api.nvim_create_autocmd("FileType", {
	pattern = "ocaml",
	callback = function()
		vim.opt_local.shiftwidth = 2
		vim.opt_local.tabstop = 2
	end
})

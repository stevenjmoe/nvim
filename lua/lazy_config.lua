local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- color scheme
	"rebelot/kanagawa.nvim",

	{ 'williamboman/mason.nvim' },
	{ 'williamboman/mason-lspconfig.nvim' },
	{ "neovim/nvim-lspconfig" },
	{ 'hrsh7th/cmp-nvim-lsp' },
	{ 'hrsh7th/nvim-cmp' },
	{ 'L3MON4D3/LuaSnip' },

	{ 'hrsh7th/cmp-buffer' },
	{ 'hrsh7th/cmp-path' },
	{ 'hrsh7th/cmp-cmdline' },

	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},

	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

	-- git
	{ 'tpope/vim-fugitive' },
	"mbbill/undotree",
	{ 'WhoIsSethDaniel/mason-tool-installer.nvim' },
	{
		'stevearc/conform.nvim',
		opts = {
			notify_on_error = false,
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			}
		},
		formatters_by_ft = {
			lua = { 'stylua' },
		}
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {}
	},
	{
		'christoomey/vim-tmux-navigator',
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
		},
		keys = {
			{ "<c-H>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-J>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-K>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-L>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
	}
})

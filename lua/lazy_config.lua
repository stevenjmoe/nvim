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
	{ 'L3MON4D3/LuaSnip' },


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
	},
	{
		"ionide/Ionide-vim",
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		ft = { "fsharp" },
		build = function()
			vim.fn.system({ "dotnet", "tool", "install", "--global", "fsautocomplete" })
		end,
	},
	{
		'rescript-lang/vim-rescript',
		tag = "v2.1.0"
	},
	{
		'nvim-flutter/flutter-tools.nvim',
		lazy = false,
		dependencies = {
			'nvim-lua/plenary.nvim',
			'stevearc/dressing.nvim', -- optional for vim.ui.select
		},
		config = true,
	},
	{ 'mfussenegger/nvim-dap' },
	{
		"rcarriga/nvim-dap-ui",
		dependencies =
		{
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio"
		}
	},
	{
		'saghen/blink.cmp',
		dependencies = 'rafamadriz/friendly-snippets',

		version = 'v0.*',
		opts = {
			-- 'default' for mappings similar to built-in completion
			-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
			-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
			-- see the "default configuration" section below for full documentation on how to define
			-- your own keymap.
			keymap = { preset = 'default' },

			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = 'mono'
			},
			sources = {
				default = { 'lsp', 'path', 'snippets', 'buffer' },
			},

			signature = { enabled = true }
		},
	},
	{
		'stevearc/oil.nvim',
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {},
		-- Optional dependencies
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
	}
})

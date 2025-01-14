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
			keymap = { preset = 'default' },

			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = 'mono'
			},
			sources = {
				completion = {
					enabled_providers = { "lsp", "path", "snippets", "buffer", "dadbod", },
				},
				providers = {
					dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
				},
				default = { 'lsp', 'path', 'snippets', 'buffer' },
				cmdline = function()
					local type = vim.fn.getcmdtype()
					-- Search forward and backward
					if type == '/' or type == '?' then return { 'buffer' } end
					-- Commands
					if type == ':' then return { 'cmdline' } end
					return {}
				end,
			},
			documentation = { auto_show = true, auto_show_delay_ms = 500 },
			signature = { enabled = true },
			ghost_text = { enabled = true },
		},
	},
	{
		'stevearc/oil.nvim',
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {},
		-- Optional dependencies
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
	},
	{ "tpope/vim-dadbod" },
	{
		'kristijanhusak/vim-dadbod-ui',
		dependencies = {
			{
				'tpope/vim-dadbod',
				lazy = true
			},
			{ 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true }, -- Optional
		},
		cmd = {
			'DBUI',
			'DBUIToggle',
			'DBUIAddConnection',
			'DBUIFindBuffer',
		},
		init = function()
			-- Your DBUI configuration
			vim.g.db_ui_use_nerd_fonts = 1
		end,
	},
	{
		"epwalsh/obsidian.nvim",
		version = "*",
		lazy = true,
		ft = "markdown",
		dependencies = {
			-- Required.
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"folke/zen-mode.nvim",
		opts = {
		}
	},
	{
		"folke/twilight.nvim",
		opts = {
		}
	},
})

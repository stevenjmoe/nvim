local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>pg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>pz', builtin.grep_string, {})
vim.keymap.set('n', '<leader>pb', builtin.buffers, {})
vim.keymap.set('n', '<leader>pk', builtin.keymaps, {})
vim.keymap.set('n', '<leader>pht', builtin.help_tags, {})
vim.keymap.set('n', '<leader>po', builtin.oldfiles, {})
vim.keymap.set('n', '<leader>pc', builtin.commands, {})
vim.keymap.set('n', '<leader>ph', builtin.search_history, {})
vim.keymap.set('n', '<leader>pq', builtin.quickfix, {})
vim.keymap.set('n', '<leader>px', builtin.registers, {})
vim.keymap.set('n', '<leader>ps', builtin.spell_suggest, {})
vim.keymap.set('n', '<leader>p/', builtin.current_buffer_fuzzy_find, {})

vim.keymap.set('n', '<leader>ds', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>ws', builtin.lsp_dynamic_workspace_symbols, {})

-- Search neovim config files
vim.keymap.set('n', '<leader>pa', function()
	builtin.find_files { cwd = vim.fn.stdpath('config') }
end)

-- LSP picker mappings
vim.keymap.set('n', '<leader>gr', builtin.lsp_references, {})
vim.keymap.set('n', '<leader>pe', builtin.diagnostics, {})
vim.keymap.set('n', '<leader>li', builtin.lsp_implementations, {})
vim.keymap.set('n', '<leader>ld', builtin.lsp_definitions, {})

--builtin.find_files(require('telescope.themes').get_dropdown({}))

require('telescope').setup {
	defaults = {
		mappings = {
			i = {
				["<C-h>"] = require('telescope.actions').select_horizontal,
				["<C-s>"] = require('telescope.actions').select_vertical,
			},
			n = {
				["<C-h>"] = require('telescope.actions').select_horizontal,
				["<C-s>"] = require('telescope.actions').select_vertical,
			},
		}
	},
	pickers = {
		find_files = {
			theme = "dropdown"
		},
		live_grep = {
			theme = "dropdown"
		},
		grep_string = {
			theme = "dropdown"
		},
		buffers = {
			theme = "dropdown"
		},
		keymaps = {
			theme = "dropdown"
		},
		quickfix = {
			theme = "dropdown"
		},
		current_buffer_fuzzy_find = {
			theme = "dropdown"
		},
	},
}

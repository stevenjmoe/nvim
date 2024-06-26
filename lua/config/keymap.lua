vim.g.mapleader = ' '
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Yoink to clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- Diagnostics
vim.keymap.set("n", "<leader>[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "<leader>]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>le", vim.diagnostic.setloclist)

vim.keymap.set('n', '<C-k>', "<cmd>cnext<CR>zz")
vim.keymap.set('n', '<C-j>', "<cmd>cprev<CR>zz")

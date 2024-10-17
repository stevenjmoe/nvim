vim.api.nvim_create_autocmd('LspAttach', {
	desc = 'LSP actions',
	callback = function(event)
		local opts = { buffer = event.buf }

		-- these will be buffer-local keybindings
		-- because they only work if you have an active language server

		vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)
		vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)
		vim.keymap.set('i', '<C-space>', vim.lsp.buf.completion)
		vim.keymap.set('n', '<leader>fd', vim.lsp.buf.format)
		vim.keymap.set('n', 'H', vim.lsp.buf.hover)
		vim.keymap.set('n', '<C-h>', vim.lsp.buf.signature_help)
		vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help)

		vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition)
		vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration)
		vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation)
	end
})

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

local default_setup = function(server)
	require('lspconfig')[server].setup({
		capabilities = lsp_capabilities,
	})
end

require('mason').setup({})
require('mason-lspconfig').setup({
	handlers = {
		default_setup,
		lua_ls = function()
			require('lspconfig').lua_ls.setup({
				settings = {
					Lua = {
						runtime = {
							version = 'LuaJIT'
						},
						diagnostics = {
							globals = { 'vim' },
						},
						workspace = {
							library = {
								vim.env.VIMRUNTIME,
							}
						}
					}
				},
			})
		end,
		html = function()
			require('lspconfig').html.setup({
				filetypes = { 'html', 'templ' },
			})
		end,
		htmx = function()
			require('lspconfig').htmx.setup({
				filetypes = { 'html', 'templ' },
			})
		end,
		tailwindcss = function()
			require('lspconfig').tailwindcss.setup({
				filetypes = { "templ", "astro", "javascript", "typescript", "react", "svelte" },
				settings = {
					tailwindCSS = {
						includeLanguages = {
							templ = "html",
						},
					}
				}
			})
		end,
		gopls = function()
			require('lspconfig').gopls.setup()
		end,
		ocamllsp = function()
			require('lspconfig').ocamllsp.setup({
				settings = {
					extendedHover = { enable = true },
					codelens = { enable = true },
					inlayHints = { enable = true },
					syntaxDocumentation = { enable = true },
				},
			})
		end
	},
})

local cmp = require('cmp')

cmp.setup({
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
		diagnostics = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' }, -- For luasnip users.
	}, {
		{ name = 'buffer' },
	}),
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	}),
	matching = { disallow_symbol_nonprefix_matching = false }
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

local servers = {
	lua_ls = {
		settings = {
			Lua = {
				inlayHints = { enable = true },
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
	},
	html = {
		settings = {
			filetypes = { 'html', 'templ' },
		}
	},
	htmx = {
		filetypes = { 'html', 'templ' },
	},
	tailwindcss = {
		filetypes = { "templ", "astro", "javascript", "typescript", "react", "svelte" },
		settings = {
			tailwindCSS = {
				includeLanguages = {
					templ = "html",
				},
			}
		}
	},
	ocamllsp = {
		settings = {
			extendedHover = { enable = true },
			codelens = { enable = true },
			inlayHints = { enable = true },
			syntaxDocumentation = { enable = true },
		},

		filetypes = {
			"ocaml",
			"ocaml.interface",
			"ocaml.menhir",
			"ocaml.cram",
			"ocaml.mlx",
			"ocaml.ocamllex",
			"reason",
		}
	},
	ts_ls = {
		settings = {
			javascript = {
				inlayHints = {
					includeInlayEnumMemberValueHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
					includeInlayParameterNameHintsWhenArgumentMatchesName = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayVariableTypeHints = false,
				},
			},
			typescript = {
				inlayHints = {
					includeInlayEnumMemberValueHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
					includeInlayParameterNameHintsWhenArgumentMatchesName = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayVariableTypeHints = false,
				},
			}
		},
	},
	gopls = {},
	svelte = {},
}

local ensure_installed = {
	"stylua",
	"lua_ls",
}

local servers_to_install = vim.tbl_filter(function(key)
	local t = servers[key]
	if type(t) == "table" then
		return not t.manual_install
	else
		return t
	end
end, vim.tbl_keys(servers))

require('mason').setup({})

vim.list_extend(ensure_installed, servers_to_install)
require("mason-tool-installer").setup { ensure_installed = ensure_installed }

for name, config in pairs(servers) do
	if config == true then
		config = {}
	end
	config = vim.tbl_deep_extend("force", {}, {
		capabilities = capabilities,
	}, config)

	require('lspconfig')[name].setup(config)
end

local disable_semantic_tokens = {
	lua = true,
}

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

vim.api.nvim_create_autocmd('LspAttach', {
	desc = 'LSP actions',
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(args)
		local bufnr = args.buf
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

		if client.server_capabilities.inlayHintProvider then
			vim.lsp.inlay_hint.enable(true)
		end

		local settings = servers[client.name]
		if type(settings) ~= "table" then
			settings = {}
		end

		vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)
		vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)
		vim.keymap.set('i', '<C-space>', vim.lsp.buf.completion)
		vim.keymap.set('n', '<leader>fd', vim.lsp.buf.format)
		vim.keymap.set('n', 'H', vim.lsp.buf.hover)
		vim.keymap.set('n', '<C-H>', vim.lsp.buf.signature_help)
		vim.keymap.set('i', '<C-H>', vim.lsp.buf.signature_help)

		vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition)
		vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration)
		vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation)

		local filetype = vim.bo[bufnr].filetype
		if disable_semantic_tokens[filetype] then
			client.server_capabilities.semanticTokensProvider = nil
		end
		-- Override server capabilities
		if settings.server_capabilities then
			for k, v in pairs(settings.server_capabilities) do
				if v == vim.NIL then
					---@diagnostic disable-next-line: cast-local-type
					v = nil
				end

				client.server_capabilities[k] = v
			end
		end
	end,
})

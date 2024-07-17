require("supermaven-nvim").setup({
	disable_keymaps = true,
	color = "#ffffff",
})

M.expand = function(fallback)
	local luasnip = require('luasnip')
	local suggestion = require('supermaven-nvim.completion_preview')

	if luasnip.expandable() then
		luasnip.expand()
	elseif suggestion.has_suggestion() then
		suggestion.on_accept_suggestion()
	else
		fallback()
	end
end

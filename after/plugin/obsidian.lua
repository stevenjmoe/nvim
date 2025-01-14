require("obsidian").setup({
	workspaces = {
		{
			name = "personal",
			path = "~/obsidian/vaults/personal",
			strict = true,
		},
	},
	notes_dir = "notes",
	daily_notes = {
		folder = "notes/dailies",
	}
})

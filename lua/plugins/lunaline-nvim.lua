local config = function()
	local theme = require("lualine.themes.synthweave")

	-- set bg transparency in all modes (uncomment these if needed)
	-- theme.normal.c.bg = nil
	-- theme.insert.c.bg = nil
	-- theme.visual.c.bg = nil
	-- theme.replace.c.bg = nil
	-- theme.command.c.bg = nil

	require("lualine").setup({
		options = {
			theme = theme,
			globalstatus = true,
		},
		sections = {
			lualine_a = {
				{ 'buffers' },
			},
		},
	})
end

return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	config = config,
}


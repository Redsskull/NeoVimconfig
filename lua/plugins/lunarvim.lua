return {
    "mistweaverco/retro-theme.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        -- First require the theme
        require("retro-theme")
        
        -- Set the colorscheme
        vim.cmd.colorscheme("retro-theme")
        
        -- Override just the comment color to grey after the colorscheme is loaded
        vim.api.nvim_set_hl(0, "Comment", { fg = "#888888", italic = true })
    end
}

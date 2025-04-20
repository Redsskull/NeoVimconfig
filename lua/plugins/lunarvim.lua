-- In ~/.config/nvim/lua/plugins/lunarvim.lua
return {
    "mistweaverco/retro-theme.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        -- Some themes might need to be required/set up before using
        require("retro-theme")
        vim.cmd.colorscheme("retro-theme") -- Try with full name
        -- Or try these alternatives if the above doesn't work:
        -- vim.cmd.colorscheme("retro_theme") 
        -- vim.cmd.colorscheme("retro")
    end
}

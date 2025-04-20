local config = function()
    -- Remove the nightfox-specific theme requirement
    -- local theme = require("lualine.themes.nightfox")
    
    require("lualine").setup({
        options = {
            -- This will make lualine adapt to your retro-theme colorscheme
            theme = "auto",
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
    -- You might need web-devicons for some icons
    dependencies = { "nvim-tree/nvim-web-devicons" }
}

return {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    config = function()
        vim.cmd([[hi NvimTreeNormal guibg=NONE ctermbg=None]])
        require("nvim-tree").setup({
            filters = {
                dotfiles = false,
            },
            on_attach = function(bufnr)
                local api = require("nvim-tree.api")

                local function opts(desc)
                    return { desc = desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                end

                -- Keep default keybindings
                api.config.mappings.default_on_attach(bufnr)

                -- Add our custom keybindings
                vim.keymap.set('n', 'm', api.fs.cut, opts('Cut'))
                vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
            end,
        })
    end,
}

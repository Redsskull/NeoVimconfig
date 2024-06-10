local keymap = vim.keymap

local M = {}


  -- Enable keybinds only when LSP server is available
    M. on_attach = function(client, bufnr)
    -- Keybind options
    local opts = { noremap = true, silent = true, buffer = bufnr }

    keymap.set("n", "<leader>fd", "<cmd>Lspsaga finder<CR>", opts) -- go to definition
    keymap.set("n", "<leader>gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- peek definition
    keymap.set("n", "<leader>gD", "<cmd>Lspsaga goto_definition<CR>", opts) -- go to definition
    keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
    keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
    keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show diagnostics for line
    keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
    keymap.set("n", "<leader>pd", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to prev diagnostic in buffer
    keymap.set("n", "<leader>nd", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
    keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor

    if client.name == "pyright" then
      keymap.set("n", "<leader>oi", "<cmd>PyrightOrganizeImports<CR>", opts) -- organize imports
      keymap.set("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>", opts) -- toggle breakpoint
      keymap.set("n", "<leader>dr", "<cmd>DapContinue<CR>", opts) -- continue/invoke debugger
    end

    if client.name == "tsserver" then
      keymap.set("n", "<leader>oi", "<cmd>TypeScriptOrganizerImports<CR>", opts) -- organize imports
    end
  end

return M

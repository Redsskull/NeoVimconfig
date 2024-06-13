local keymap = vim.keymap

local opts = { noremap = true, silent = true }
--Directory Navigation
keymap.set("n", "<leader>m", ":NvimTreeFocus<CR>", {noremap = true})
keymap.set("n", "<leader>f", ":NvimTreeToggle<CR>", {noremap = true})

-- Pane Navigation 
keymap.set("n", "<C-h>", "<C-w>h", opts) -- Navigate Left
keymap.set("n", "<C-j>", "<C-w>j", opts) -- Navigate Down
keymap.set("n", "<C-k>", "<C-w>k", opts) -- Navigate Up
keymap.set("n", "<C-l>", "<C-w>l", opts) -- Navigate Right

-- Navigate within Vim windows
keymap.set('n', '<C-j>', ':wincmd j<CR>', { noremap = true, silent = true })
keymap.set('n', '<C-k>', ':wincmd k<CR>', { noremap = true, silent = true })
keymap.set('n', '<C-l>', ':wincmd l<CR>', { noremap = true, silent = true })

-- Navigate between Tmux panes
keymap.set('n', '<C-h>', ':TmuxNavigateLeft<CR>', { noremap = true, silent = true })
keymap.set('n', '<C-j>', ':TmuxNavigateDown<CR>', { noremap = true, silent = true })
keymap.set('n', '<C-k>', ':TmuxNavigateUp<CR>', { noremap = true, silent = true })
keymap.set('n', '<C-l>', ':TmuxNavigateRight<CR>', { noremap = true, silent = true })

-- Window Management
keymap.set("n", "<leader>sv", ":vsplit<CR>", opts) -- Split Vertically
keymap.set("n", "<leader>sh", ":split<CR>", opts) -- Split Horizontally
keymap.set("n", "<leader>sm", "MaximizerToggle<CR>", opts) -- Toggle Minimize

-- indenting
keymap.set("v", "<", "<gv")
keymap.set("v",">", ">gv")

-- Comments
vim.api.nvim_set_keymap("n", "<C-\\>", "gcc", { noremap = false })
vim.api.nvim_set_keymap("v", "<C-\\>", "gcc", { noremap = false})



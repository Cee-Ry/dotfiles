-- Leader key
vim.g.mapleader = ' ' -- Space as the leader key

-- Function to open Yazi file manager
local function open_yazi()
  vim.cmd("terminal /usr/bin/yazi")
end

-- Core navigation keymaps
vim.api.nvim_set_keymap('n', '<Leader>w', ':w<CR>', { noremap = true, silent = true }) -- Save file

-- Telescope keymaps
vim.api.nvim_set_keymap('n', '<Leader>f', ':Telescope find_files<CR>', { noremap = true, silent = true }) -- Find files
vim.api.nvim_set_keymap('n', '<Leader>g', ':Telescope live_grep<CR>', { noremap = true, silent = true }) -- Find words

-- File manager (Yazi)
vim.api.nvim_set_keymap('n', '<Leader>n', ':lua require("user.keymaps").open_yazi()<CR>', { noremap = true, silent = true }) -- Open file manager
vim.api.nvim_set_keymap('n', '<C-n>', ':lua require("user.keymaps").open_yazi()<CR>', { noremap = true, silent = true }) -- Open file manager

-- Export function for use in keymaps
return { open_yazi = open_yazi }
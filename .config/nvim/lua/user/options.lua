-- options.lua
-- Variable for easier access to vim options
local set = vim.opt

-- Basic Settings
set.number = true -- Enable line numbers
set.relativenumber = true -- Enable relative line numbers
set.tabstop = 4 -- Number of spaces a tab represents
set.shiftwidth = 4 -- Number of spaces for each indentation
set.expandtab = true -- Convert tabs to spaces
set.smartindent = true -- Automatically indent new lines
set.wrap = true -- Disable line wrapping
set.cursorline = true -- Highlight the current line
set.termguicolors = true -- Enable 24-bit RGB colors
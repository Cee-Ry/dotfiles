-- ~/.config/nvim/lua/config/options.lua

-- Assign vim.opt to a local variable for brevity
local set = vim.opt

-- General settings
set.cursorline = true
set.expandtab = true
set.number = true
set.relativenumber = true
set.shiftwidth = 4
set.smarttab = true
set.splitbelow = true
set.splitright = true
set.swapfile = false
set.tabstop = 4
set.termguicolors = true
set.title = true
set.ttimeoutlen = 0
set.updatetime = 250
set.wildmenu = true
set.wrap = true

-- Autocomplete options
set.completeopt = "noinsert,menuone,noselect"

-- Folding
set.foldmethod = "manual"
set.foldexpr = "nvim_treesitter#foldexpr()"

-- Line break and search
set.ignorecase = true
set.smartcase = true
set.linebreak = true
set.showmatch = true

-- Color and UI
set.colorcolumn = "80"
set.laststatus = 3


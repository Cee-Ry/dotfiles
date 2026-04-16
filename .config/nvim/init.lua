-- Font
vim.opt.guifont = "JetBrainsMono Nerd Font"

-- Basic config
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

-- Tab spacing
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

-- transparency
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "NonText", { bg = "NONE", ctermbg = "NONE" })   

-- Syntax Highlighting
vim.opt.syntax = "on"   
vim.cmd("set filetype=cpp")
vim.cmd("syntax enable")

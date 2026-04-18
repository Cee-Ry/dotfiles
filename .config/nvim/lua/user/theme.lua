-- theme.lua
-- Additional theme configuration for transparency and syntax

-- Ensure syntax highlighting is enabled
vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')

-- Set transparency for various UI elements
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })
vim.api.nvim_set_hl(0, "NonText", { bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#00008B", bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#FFD700", bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "VertSplit", { bg = "NONE", ctermbg = "NONE" })

-- Ensure syntax highlighting groups are visible
vim.api.nvim_set_hl(0, "Comment", { italic = true })
vim.api.nvim_set_hl(0, "String", { italic = false })

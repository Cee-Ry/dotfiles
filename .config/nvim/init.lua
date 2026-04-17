-- Font
vim.opt.guifont = "JetBrainsMono Nerd Font"

-- Initialize core settings first
require('user.options')
require('user.keymaps')

-- Load plugin manager
require('user.plugins')

-- Set up plugins with dependencies (defer LSP setup to ensure plugins are loaded)
require('user.lsp')
require('user.completion') -- Depends on LSP configuration
require('user.telescope') -- Often integrates with LSP

-- Configure UI components last
require('user.theme')
require('user.statusline')

if vim.g.vscode then
    -- VSCode extension
else
    -- ordinary Neovim
end

-- Syntax highlighting and filetype plugins
vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')

-- transparency
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "NonText", { bg = "NONE", ctermbg = "NONE" })   


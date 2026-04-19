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
    -- VS Code handles UI, so skip statusline/theme plugins
    require('user.vscode_keymaps')
else
    -- Full Neovim setup
    require('user.theme')
    require('user.statusline')
end


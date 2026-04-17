-- Dashboard configuration using alpha-nvim
local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- Set header with ASCII art
dashboard.section.header.val = {
  "",
  "",
  "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗  ",
  "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║  ",
  "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║  ",
  "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║  ",
  "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║  ",
  "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝  ",
  "",
  "                    Welcome Back!                      ",
  "",
}

-- Set header highlights
dashboard.section.header.opts.hl = "AlphaHeader"

-- Create menu buttons with shortcuts
dashboard.section.buttons.val = {
  dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
  dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
  dashboard.button("g", "  Find words", ":Telescope live_grep<CR>"),
  dashboard.button("n", "  File manager", ":lua require('user.keymaps').open_yazi()<CR>"),
  dashboard.button("r", "  Recent files", ":Telescope oldfiles<CR>"),
  dashboard.button("q", "  Quit", ":qa<CR>"),
}

-- Customize button highlights
dashboard.section.buttons.opts.hl = "AlphaButtons"
dashboard.section.buttons.opts.hl_shortcut = "AlphaShortcut"

-- Set footer with version info
dashboard.section.footer.val = {
  "",
  "Neovim " .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch,
}
dashboard.section.footer.opts.hl = "AlphaFooter"

-- Configure layout
dashboard.config.layout = {
  { type = "padding", val = 2 },
  dashboard.section.header,
  { type = "padding", val = 2 },
  dashboard.section.buttons,
  { type = "padding", val = 1 },
  dashboard.section.footer,
}

-- Setup highlights
local function setup_highlights()
  local c = require("tokyonight.colors").setup()
  
  vim.api.nvim_set_hl(0, "AlphaHeader", { fg = c.blue, bold = true })
  vim.api.nvim_set_hl(0, "AlphaButtons", { fg = c.cyan })
  vim.api.nvim_set_hl(0, "AlphaShortcut", { fg = c.magenta, bold = true })
  vim.api.nvim_set_hl(0, "AlphaFooter", { fg = c.comment, italic = true })
end

-- Setup and apply alpha
alpha.setup(dashboard.config)

-- Apply highlights after colorscheme is loaded
vim.schedule(function()
  setup_highlights()
end)

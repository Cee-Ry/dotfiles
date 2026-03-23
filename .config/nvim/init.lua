-- By CeasarRyan

-- ============================================================
-- BASIC OPTIONS
-- ============================================================

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.api.nvim_set_hl(0, "LineNr", { fg = "#7aa2f7" })

-- Cursor line
vim.opt.cursorline = true
vim.api.nvim_set_hl(0, "CursorLine",    { bg = "#508ea8" })
vim.api.nvim_set_hl(0, "CursorLineNr",  { fg = "#ffcc00", bold = true })

-- Tabs 4 spaces
vim.opt.tabstop      = 4  -- tab width = 4 spaces
vim.opt.expandtab    = true  -- convert tabs to spaces

-- ============================================================
-- BOOTSTRAP lazy.nvim
-- ============================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ============================================================
-- PLUGINS
-- ============================================================

require("lazy").setup({

  -- ----------------------------------------------------------
  -- Syntax highlighting
  -- ----------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.config").setup({
        ensure_installed = { "cpp", "c" },
        highlight = { enable = true },
      })
    end,
  },

  -- ----------------------------------------------------------
  -- Colorscheme
  -- ----------------------------------------------------------
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- ----------------------------------------------------------
  -- Indent guides
  -- ----------------------------------------------------------
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup({
        scope = { enabled = true },
      })
    end,
  },

  -- ----------------------------------------------------------
  -- File tree
  -- ----------------------------------------------------------
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup()
      vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", {})
    end,
  },

  -- ----------------------------------------------------------
  -- Fuzzy finder
  -- ----------------------------------------------------------
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      require("telescope").setup({
        defaults = { hidden = true },
        pickers  = { find_files = { hidden = true } },
      })
      vim.keymap.set("n", "<C-p>", builtin.find_files, {})
      vim.keymap.set("n", "<C-f>", builtin.live_grep,  {})
    end,
  },

  -- ----------------------------------------------------------
  -- Dashboard / start screen
  -- ----------------------------------------------------------
  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha     = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      -- Header
      dashboard.section.header.val = {
        "                                                     ",
        "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
        "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
        "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
        "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
        "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
        "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
        "                                                     ",
      }

      -- Helper: button with per-button highlights
      local function btn(key, label, cmd)
        local b = dashboard.button(key, label, cmd)
        b.opts.hl          = "AlphaButton"
        b.opts.hl_shortcut = "AlphaShortcut"
        return b
      end

      -- Buttons (Nerd Font v3 icons)
      dashboard.section.buttons.val = {
        btn("e", "󰈔  New file",       ":ene <BAR> startinsert<CR>"),
        btn("f", "󰱼  Find file",       ":Telescope find_files<CR>"),
        btn("r", "󰋚  Recent files",    ":Telescope oldfiles<CR>"),
        btn("g", "󰍉  Live grep",       ":Telescope live_grep<CR>"),
        btn("c", "⚙️ Config",          ":e $MYVIMRC<CR>"),
        btn("q", "󰩈  Quit",            ":qa<CR>"),
      }

      -- Footer: plugin count
      local stats = require("lazy").stats()
      dashboard.section.footer.val     = "⚡ " .. stats.count .. " plugins loaded"
      dashboard.section.footer.opts.hl = "AlphaFooter"

      -- Layout with dividers
      local function divider()
        return {
          type = "text",
          val  = "  ─────────────────────────────────────  ",
          opts = { hl = "AlphaDivider", position = "center" },
        }
      end

      dashboard.config.layout = {
        { type = "padding", val = 8 },
        dashboard.section.header,
        { type = "padding", val = 1 },
        divider(),
        { type = "padding", val = 1 },
        dashboard.section.buttons,
        divider(),
        { type = "padding", val = 1 },
        dashboard.section.footer,
      }

      alpha.setup(dashboard.config)

      -- Move cursor away from buttons on dashboard open
      vim.api.nvim_create_autocmd("User", {
        pattern = "AlphaReady",
        callback = function()
          vim.cmd("setlocal nocursorline")
        end,
      })
      -- Highlight groups
      vim.api.nvim_set_hl(0, "AlphaHeader",   { fg = "#7aa2f7" })           -- blue
      vim.api.nvim_set_hl(0, "AlphaButton",   { fg = "#cba6f7" })           -- mauve
      vim.api.nvim_set_hl(0, "AlphaShortcut", { fg = "#ff9e64", bold = true }) -- orange
      vim.api.nvim_set_hl(0, "AlphaDivider",  { fg = "#313244" })           -- subtle
      vim.api.nvim_set_hl(0, "AlphaFooter",   { fg = "#565f89" })           -- comment grey

      dashboard.section.header.opts.hl = "AlphaHeader"
    end,
  },

})

-- ============================================================
-- TRANSPARENCY  (must stay after colorscheme loads)
-- ============================================================

vim.api.nvim_set_hl(0, "Normal",      { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

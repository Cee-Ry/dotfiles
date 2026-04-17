-- plugins.lua
-- Bootstrap Lazy.nvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  print("Installing lazy.nvim...")
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
  print("Lazy.nvim installed!")
end
vim.opt.rtp:prepend(lazypath)

-- Plugin specifications
return require("lazy").setup({
  -- Essential plugins
  "nvim-lua/plenary.nvim", -- Utility functions (dependency for many plugins)

  -- Treesitter for syntax highlighting (load early)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    priority = 100, -- Load early
    config = function()
      require('nvim-treesitter.config').setup {
        -- Install these parsers by default
        ensure_installed = { 
          "lua", "vim", "vimdoc", "javascript", "cpp", "c", "python", "rust", 
          "go", "html", "css", "json", "yaml", "toml", "markdown", "bash"
        },
        auto_install = true, -- Automatically install missing parsers
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            node_decremental = "grm",
            scope_incremental = "grc",
          },
        },
      }
    end,
  },

  -- Language Server Protocol support
  {
    "neovim/nvim-lspconfig", -- Base LSP configurations
    dependencies = {
      -- Server installation manager
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
  },

  -- Autocompletion system
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
      "hrsh7th/cmp-buffer",   -- Buffer source
      "hrsh7th/cmp-path",     -- Path source
      "L3MON4D3/LuaSnip",     -- Snippet engine
      "saadparwaiz1/cmp_luasnip", -- Snippet source
    },
  },

  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" }
  },

  -- Key binding helper
  {
    "folke/which-key.nvim",
  },

  -- Dashboard/home screen
  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("user.dashboard")
    end,
  },

  -- Theme (load last after all functionality is configured)
  { 
    "folke/tokyonight.nvim",
    priority = 1000, -- Load last
    config = function()
      require("tokyonight").setup({
        style = "night", -- night, storm, moon, day
        transparent = true,
        terminal_colors = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
          sidebars = "transparent",
          floats = "transparent",
        },
        on_highlights = function(hl, c)
          -- Ensure syntax highlighting is visible with transparency
          hl.Normal = { fg = c.fg, bg = "NONE" }
          hl.NormalNC = { fg = c.fg, bg = "NONE" }
          hl.NormalFloat = { bg = "NONE" }
          hl.FloatBorder = { bg = "NONE" }
        end,
      })
      vim.cmd.colorscheme("tokyonight")
    end,
  },
})
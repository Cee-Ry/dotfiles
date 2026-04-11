return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional file icons
  config = function()
    -- nvim-tree requires this to be disabled
    vim.g.loaded_netrw       = 1
    vim.g.loaded_netrwPlugin = 1

    require("nvim-tree").setup({
      view = {
        width = 30,        -- sidebar width
        side  = "left",
      },
      renderer = {
        group_empty = true, -- collapse empty folders into one line
        icons = {
          show = {
            file        = true,
            folder      = true,
            folder_arrow = true,
          },
        },
      },
      filters = {
        dotfiles = false,   -- set to true to hide dotfiles
      },
    })

    -- Toggle the tree with <leader>e  (leader is \ by default)
    vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>",
      { desc = "Toggle file tree" })

    -- Focus the tree without toggling
    vim.keymap.set("n", "<leader>fe", "<cmd>NvimTreeFocus<CR>",
      { desc = "Focus file tree" })
  end,
}

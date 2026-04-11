-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ── Options ────────────────────────────────────────────────────────────────

vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.cursorline     = true

-- ── Transparency ───────────────────────────────────────────────────────────

local function set_transparent()
  vim.api.nvim_set_hl(0, "Normal",      { bg = "none", ctermbg = "none" })
  vim.api.nvim_set_hl(0, "NormalNC",    { bg = "none", ctermbg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none", ctermbg = "none" })
  vim.api.nvim_set_hl(0, "SignColumn",  { bg = "none", ctermbg = "none" })
  vim.api.nvim_set_hl(0, "CursorLine",  { bg = "none", ctermbg = "none", bold = true })
end

vim.api.nvim_create_autocmd("VimEnter",    { callback = set_transparent })
vim.api.nvim_create_autocmd("ColorScheme", { pattern = "*", callback = set_transparent })

-- ── Plugins ────────────────────────────────────────────────────────────────

require("lazy").setup("plugins")

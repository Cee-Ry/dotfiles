-- lua/homepage.lua
-- Startup page for Neovim
-- Load with: require("homepage").open()  (in init.lua)
--
-- Requirements: a Nerd Font-patched terminal font
-- (e.g. JetBrainsMono Nerd Font, FiraCode Nerd Font, etc.)

local M = {}

------------------------------------------------------------------------
-- Nerd Font icons
------------------------------------------------------------------------
local NF = {
  file   = "\xef\x80\x96",   --   nf-fa-file_o
  folder = "\xef\x81\xbc",   --   nf-fa-folder_open
  search = "\xef\x80\x82",   --   nf-fa-search
  recent = "\xef\x87\x9a",   --   nf-fa-history
  config = "\xef\x80\x93",   --   nf-fa-cog
}

------------------------------------------------------------------------
-- ASCII art  (same block-letter style throughout)
------------------------------------------------------------------------

-- NEOVIM
local nvim_art = {
  "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗  ",
  "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║  ",
  "  ██╔██╗ ██║█████╗  ██║   ██║╚██╗ ██╔╝██║██╔████╔██║  ",
  "  ██║╚██╗██║██╔══╝  ██║   ██║ ╚████╔╝ ██║██║╚██╔╝██║  ",
  "  ██║ ╚████║███████╗╚██████╔╝  ╚██╔╝  ██║██║ ╚═╝ ██║  ",
  "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝    ╚═╝   ╚═╝╚═╝     ╚═╝  ",
}

-- CEASAR  (same font)
local ceasar_art = {
  "  ██████╗███████╗ █████╗ ███████╗ █████╗ ██████╗  ",
  " ██╔════╝██╔════╝██╔══██╗██╔════╝██╔══██╗██╔══██╗ ",
  " ██║     █████╗  ███████║███████╗███████║██████╔╝  ",
  " ██║     ██╔══╝  ██╔══██║╚════██║██╔══██║██╔══██╗  ",
  " ╚██████╗███████╗██║  ██║███████║██║  ██║██║  ██║  ",
  "  ╚═════╝╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ",
}

local function center(str, width)
  local w = vim.fn.strdisplaywidth(str)
  local pad = math.max(0, math.floor((width - w) / 2))
  return string.rep(" ", pad) .. str
end

-- Box inner visual column count (between the two border chars).
-- Row byte layout:
--   "│" (3B)  "  " (2B)  icon (3B)  " " (1B)  lbl (14B)  spaces (27B)  key (5B)  "  " (2B)  "│" (3B)
--   = 60 bytes total; visual = 55 cols when icon renders as 2-wide (Nerd Font standard)
local BOX_INNER = 53

local function menu_row(icon, label, key)
  local lbl = label .. string.rep(" ", math.max(0, 14 - #label))
  local k   = string.rep(" ", math.max(0, 5 - #key)) .. key
  return "\xe2\x94\x82  " .. icon .. " " .. lbl .. string.rep(" ", 27) .. k .. "  \xe2\x94\x82"
end

local function make_menu()
  -- U+256D ╭  U+2500 ─  U+256E ╮  U+2570 ╰  U+256F ╯
  local top   = "\xe2\x95\xad" .. string.rep("\xe2\x94\x80", BOX_INNER) .. "\xe2\x95\xae"
  local bot   = "\xe2\x95\xb0" .. string.rep("\xe2\x94\x80", BOX_INNER) .. "\xe2\x95\xaf"
  local blank = "\xe2\x94\x82" .. string.rep(" ", BOX_INNER) .. "\xe2\x94\x82"
  return {
    top,
    blank,
    menu_row(NF.file,   "New File",     "n"),
    menu_row(NF.folder, "Open File",    "o"),
    menu_row(NF.search, "Search File",  "SPC"),
    menu_row(NF.recent, "Recent Files", "r"),
    menu_row(NF.config, "Configure",    "c"),
    blank,
    bot,
  }
end

------------------------------------------------------------------------
-- Page assembly
--
-- Content structure (35 total lines, 1-based in `lines`):
--   [1]     deco_top  "─── ◈ ───"
--   [2]     blank
--   [3-8]   NEOVIM art (6 lines)    offsets.nvim   = 2  → adj = top_pad+2
--   [9]     blank
--   [10]    deco_mid  "────────────"
--   [11]    blank
--   [12-17] CEASAR art (6 lines)    offsets.ceasar = 11 → adj = top_pad+11
--   [18]    blank
--   [19-24] RYAN art (6 lines)      offsets.ryan   = 18 → adj = top_pad+18
--   [25]    blank
--   [26]    blank
--   [27-35] menu box (9 lines)      offsets.menu   = 26 → adj = top_pad+26
------------------------------------------------------------------------

local function build_lines(win_w, win_h)
  local deco_top = "\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80 \xe2\x97\x88 \xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80\xe2\x94\x80"
  local deco_mid = string.rep("\xe2\x94\x80", 60)
  local menu     = make_menu()

  local lines   = {}
  local offsets = {}

  local function push(s) table.insert(lines, center(s, win_w)) end
  local function skip()  table.insert(lines, "") end

  push(deco_top) ; skip()                         -- [1-2]

  offsets.nvim = #lines                            -- = 2
  for _, l in ipairs(nvim_art)    do push(l) end  -- [3-8]

  skip() ; push(deco_mid) ; skip()                -- [9-11]

  offsets.ceasar = #lines                          -- = 11
  for _, l in ipairs(ceasar_art)  do push(l) end  -- [12-17]
  skip()                                           -- [18]

  offsets.ryan = #lines                            -- = 18
  for _, l in ipairs(ryan_art)    do push(l) end  -- [19-24]
  skip() ; skip()                                  -- [25-26]

  offsets.menu = #lines                            -- = 26
  for _, l in ipairs(menu)        do push(l) end  -- [27-35]

  -- vertical centering via top-padding
  local top_pad = math.max(0, math.floor((win_h - #lines) / 2))
  local padded  = {}
  for _ = 1, top_pad do table.insert(padded, "") end
  vim.list_extend(padded, lines)

  -- convert to nvim 0-indexed line numbers
  local adj = {}
  for k, v in pairs(offsets) do adj[k] = v + top_pad end

  return padded, adj
end

------------------------------------------------------------------------
-- Highlights
------------------------------------------------------------------------

local function setup_highlights()
  -- NEOVIM: 6-row gradient, bright lime at top → deep forest at bottom
  vim.api.nvim_set_hl(0, "NvimRow1", { fg = "#C8FFB0", bold = true })
  vim.api.nvim_set_hl(0, "NvimRow2", { fg = "#9EE890", bold = true })
  vim.api.nvim_set_hl(0, "NvimRow3", { fg = "#76CC6E", bold = true })
  vim.api.nvim_set_hl(0, "NvimRow4", { fg = "#4EAA50" })
  vim.api.nvim_set_hl(0, "NvimRow5", { fg = "#2E8838" })
  vim.api.nvim_set_hl(0, "NvimRow6", { fg = "#1A6425" })

  -- Name art: clean off-white block letters
  vim.api.nvim_set_hl(0, "NameArt",  { fg = "#E8E8DC", bold = true })

  -- Decorative divider lines
  vim.api.nvim_set_hl(0, "Divider",  { fg = "#2A5A3A" })

  -- Menu
  vim.api.nvim_set_hl(0, "MenuBox",  { fg = "#2E7A4A" })
  vim.api.nvim_set_hl(0, "MenuText", { fg = "#5A8060" })
  vim.api.nvim_set_hl(0, "MenuKey",  { fg = "#9EE890", bold = true })
end

local nvim_grads = {
  "NvimRow1", "NvimRow2", "NvimRow3",
  "NvimRow4", "NvimRow5", "NvimRow6",
}

local function apply_highlights(buf, o)
  local ns = vim.api.nvim_create_namespace("homepage_hl")
  vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)

  local function hl(grp, row, cs, ce)
    vim.api.nvim_buf_add_highlight(buf, ns, grp, row, cs or 0, ce or -1)
  end

  -- decorative lines
  hl("Divider", o.nvim - 2)        -- deco_top  (2 lines before nvim art)
  hl("Divider", o.nvim + 7)        -- deco_mid  (blank + deco after nvim art)

  -- NEOVIM gradient
  for i, grp in ipairs(nvim_grads) do
    hl(grp, o.nvim + i - 1)
  end

  -- CEASAR + RYAN in matching off-white
  for i = 0, 5 do
    hl("NameArt", o.ceasar + i)
    hl("NameArt", o.ryan   + i)
  end

  -- Menu box
  local ms = o.menu
  hl("MenuBox", ms + 0)   -- ╭─...─╮  border top
  hl("MenuBox", ms + 1)   -- │blank│
  hl("MenuBox", ms + 7)   -- │blank│
  hl("MenuBox", ms + 8)   -- ╰─...─╯  border bot

  -- Item rows: muted text, then re-highlight the key at end
  --
  -- menu_row total byte length = 60:
  --   │(3) + "  "(2) + icon(3) + " "(1) + lbl(14) + spaces(27) + key(5) + "  "(2) + │(3)
  --
  -- key_padded occupies bytes [50 .. 54]  (col_end exclusive = 55)
  for i = 2, 6 do
    local row  = ms + i
    hl("MenuText", row)
    local line = vim.api.nvim_buf_get_lines(buf, row, row + 1, false)[1] or ""
    local len  = #line
    -- "  │" = 5 bytes at end; key_padded = 5 bytes before that
    hl("MenuKey", row, math.max(0, len - 10), len - 5)
  end
end

------------------------------------------------------------------------
-- Key mappings  (active only on the homepage buffer)
------------------------------------------------------------------------

local function set_keymaps(buf)
  local o = { noremap = true, silent = true, buffer = buf }

  -- n → new empty buffer
  vim.keymap.set("n", "n", function()
    vim.cmd("enew")
  end, o)

  -- o → open netrw in cwd
  vim.keymap.set("n", "o", function()
    vim.cmd("e .")
  end, o)

  -- SPC → prompt for filename and :find in cwd
  --       (swap body for Telescope's find_files once you add it)
  vim.keymap.set("n", "<Space>", function()
    vim.ui.input({ prompt = " Search file: " }, function(input)
      if input and input ~= "" then vim.cmd("find " .. input) end
    end)
  end, o)

  -- r → browse recent/old files
  vim.keymap.set("n", "r", function()
    vim.cmd("browse oldfiles")
  end, o)

  -- c → open init.lua
  vim.keymap.set("n", "c", function()
    vim.cmd("e " .. vim.fn.stdpath("config") .. "/init.lua")
  end, o)

  vim.keymap.set("n", "q",     "<Cmd>qa<CR>", o)
  vim.keymap.set("n", "<Esc>", "<Cmd>qa<CR>", o)
end

------------------------------------------------------------------------
-- Entry point
------------------------------------------------------------------------

function M.open()
  -- skip if nvim was opened with a file argument (e.g. nvim somefile.lua)
  if vim.fn.argc() > 0 then return end

  vim.opt.shortmess:append("I")

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_current_buf(buf)

  vim.bo[buf].buftype   = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].swapfile  = false
  vim.bo[buf].filetype  = "homepage"

  local win = vim.api.nvim_get_current_win()
  vim.wo[win].number         = false
  vim.wo[win].relativenumber = false
  vim.wo[win].signcolumn     = "no"
  vim.wo[win].cursorline     = false
  vim.wo[win].cursorcolumn   = false

  setup_highlights()

  local function render()
    local w = vim.api.nvim_win_get_width(win)
    local h = vim.api.nvim_win_get_height(win)
    local padded, offsets = build_lines(w, h)

    vim.bo[buf].modifiable = true
    vim.bo[buf].readonly   = false
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, padded)
    vim.bo[buf].modifiable = false
    vim.bo[buf].readonly   = true

    apply_highlights(buf, offsets)
  end

  render()
  set_keymaps(buf)

  vim.api.nvim_create_autocmd("VimResized", {
    buffer   = buf,
    callback = render,
  })
end

return M

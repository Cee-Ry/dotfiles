-- lsp.lua
-- Wait for lazy.nvim to load all plugins before configuring LSP
vim.defer_fn(function()
  local ok_mason, mason = pcall(require, "mason")
  local ok_mlsc, mason_lspconfig = pcall(require, "mason-lspconfig")
  
  if not ok_mason or not ok_mlsc then
    vim.notify("Failed to load mason modules", vim.log.levels.ERROR)
    return
  end
  
  -- Install Mason first for managing servers
  mason.setup({
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗"
      }
    }
  })

  -- Connect Mason with lspconfig
  mason_lspconfig.setup({
    -- Automatically install these servers
    ensure_installed = {
      "lua_ls",      -- Lua
      -- "pyright",     -- Python
      -- "ts_ls",       -- TypeScript/JavaScript (renamed from tsserver)
      "rust_analyzer", -- Rust
      "gopls",       -- Go
      "clangd",      -- C/C++
    },
    automatic_installation = true,
  })

  -- Set up LSP capabilities (used by completion)
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  -- Check if nvim-cmp is available to enhance capabilities
  local has_cmp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
  if has_cmp then
    capabilities = cmp_lsp.default_capabilities(capabilities)
  end

  -- Function to set up all installed LSP servers
  local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Key mappings
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>lf', function() vim.lsp.buf.format { async = true } end, bufopts)

    -- Log a message when a server attaches
    print(string.format("LSP server '%s' attached to this buffer", client.name))
  end

  -- Get list of installed servers from mason and set them up using vim.lsp.config
  local installed_servers = mason_lspconfig.get_installed_servers()
  
  for _, server_name in ipairs(installed_servers) do
    local config = {
      on_attach = on_attach,
      capabilities = capabilities,
    }
    
    -- Special config for lua_ls
    if server_name == "lua_ls" then
      config.settings = {
        Lua = {
          runtime = { version = 'LuaJIT' },
          diagnostics = { globals = {'vim'} },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = { enable = false },
        },
      }
    end
    
    -- Use the new vim.lsp.config API
    vim.lsp.config(server_name, config)
    -- Enable the server immediately
    vim.lsp.enable(server_name)
  end
end, 100)

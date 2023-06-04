local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

local default_servers = {
  "html",
  "cssls",
  "angularls",
  "bashls",
  "tsserver",
  "jsonls",
  "taplo",
  "eslint",
  "gradle_ls",
  "rust_analyzer",
  "jdtls",
}

for _, lsp in ipairs(default_servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.yamlls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    yaml = {
      keyOrdering = false,
    },
  },
}

lspconfig.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
}

lspconfig.denols.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    deno = {
      enable = true,
      lint = true,
      unstable = true,
      importMap = "./import_map.json",
    },
  },
}

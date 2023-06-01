local M = {}

M.treesitter = {
  ensure_installed = {
    "astro",
    "bash",
    "blueprint",
    "c",
    "cpp",
    "css",
    "dart",
    "diff",
    "dockerfile",
    "git_config",
    "gitignore",
    "go",
    "html",
    "http",
    "java",
    "javascript",
    "jq",
    "jsdoc",
    "json",
    "json5",
    "jsonnet",
    "kotlin",
    "lua",
    "luadoc",
    "markdown",
    "markdown_inline",
    "php",
    "phpdoc",
    "prisma",
    "python",
    "rust",
    "scss",
    "sql",
    "svelte",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "vue",
    "yaml",
  },
  indent = {
    enabled = true,
  },
}

M.mason = {
  ensure_installed = {
    -- Language Servers
    "angular-language-server",
    "lua-language-server",
    "bash-language-server",
    "typescript-language-server",
    "yaml-language-server",
    "groovy-language-server",
    "jdtls",
    "rust-analyzer",
    "html-lsp",
    "css-lsp",
    "json-lsp",
    "taplo",
    "eslint-lsp",

    -- Formatters
    "prettier",
    "stylua",
    "rustfmt",
    "google-java-format",
    "shfmt",
  },
}

M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

return M

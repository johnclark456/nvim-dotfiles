return {
  -- Treesitter grammar (optional but improves highlighting & folding)
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "bzl", "starlark" })
    end,
  },

  -- Formatting via buildifier
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        bzl = { "buildifier" },
        bazel = { "buildifier" },
      },
      formatters = {
        buildifier = {
          command = "buildifier",
          args = { "-" },
          stdin = true,
        },
      },
    },
  },

  -- LSP support via bazel-lsp
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bazel_ls = {
          cmd = { "bazel-lsp" },
          filetypes = { "bzl", "bazel", "starlark" },
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern("WORKSPACE", ".git")(fname)
          end,
        },
      },
    },
  },
}

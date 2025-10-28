-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- lua/plugins/lsp.lua
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          keys = {
            {
              "<leader>h",
              "<cmd>ClangdSwitchSourceHeader<cr>",
              desc = "Switch between source and header",
            },
          },
        },
      },
    },
  },
}

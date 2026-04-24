return {
  -- LSP: extend bashls to cover zsh
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bashls = {
          filetypes = { "sh", "bash", "zsh" },
        },
      },
    },
  },

  -- Formatting: extend shfmt to cover zsh
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        zsh = { "shfmt" },
        bash = { "shfmt" },
        sh = { "shfmt" },
      },
      formatters = {
        shfmt = {
          prepend_args = function(self, ctx)
            local ft = vim.bo[ctx.buf].filetype
            if ft == "zsh" then
              return { "-ln", "zsh", "-i", "2", "-ci" }
            else
              return { "-ln", "bash", "-i", "2", "-ci" }
            end
          end,
        },
      },
    },
  },

  -- Linting: wire shellcheck to zsh
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        zsh = { "zsh" },
        bash = { "shellcheck" },
        sh = { "shellcheck" },
      },
    },
  },
}

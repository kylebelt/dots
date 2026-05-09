return {
  "folke/edgy.nvim",
  opts = {
    animate = {
      enabled = false,
    },
    right = {
      { title = "Aerial", ft = "aerial", pinned = true, open = "AerialOpen" },
      {
        title = "Trouble",
        ft = "trouble",
        filter = function(_buf, win)
          return vim.w[win].trouble and vim.w[win].trouble.position == "right" and not vim.w[win].trouble_preview
        end,
      },
    },
  },
}

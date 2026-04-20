return {
  "m4xshen/hardtime.nvim",
  lazy = false,
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = {
    disable_mouse = false,
    max_count = 7,
  },
  config = function(_, opts)
    require("hardtime").setup(opts)
    Snacks.toggle({
      name = "Hardtime",
      get = function()
        return require("hardtime").is_plugin_enabled
      end,
      set = function()
        require("hardtime").toggle()
      end,
    }):map("<leader>uH")
  end,
}

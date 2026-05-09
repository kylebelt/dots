return {
  "mrjones2014/smart-splits.nvim",
  lazy = false,
  keys = {
    {
      mode = { "i", "n", "v" },
      "<M-h>",
      function()
        require("smart-splits").resize_left()
      end,
      desc = "Resize Left",
    },
    {
      mode = { "i", "n", "v" },
      "<M-j>",
      function()
        require("smart-splits").resize_down()
      end,
      desc = "Resize Down",
    },
    {
      mode = { "i", "n", "v" },
      "<M-k>",
      function()
        require("smart-splits").resize_up()
      end,
      desc = "Resize Up",
    },
    {
      mode = { "i", "n", "v" },
      "<M-l>",
      function()
        require("smart-splits").resize_right()
      end,
      desc = "Resize Right",
    },
    {
      mode = { "i", "n", "v" },
      "<C-h>",
      function()
        require("smart-splits").move_cursor_left()
      end,
      desc = "Move to Left Window",
    },
    {
      mode = { "i", "n", "v" },
      "<C-j>",
      function()
        require("smart-splits").move_cursor_down()
      end,
      desc = "Move to Bottom Window",
    },
    {
      mode = { "i", "n", "v" },
      "<C-k>",
      function()
        require("smart-splits").move_cursor_up()
      end,
      desc = "Move to Top Window",
    },
    {
      mode = { "i", "n", "v" },
      "<C-l>",
      function()
        require("smart-splits").move_cursor_right()
      end,
      desc = "Move to Right Window",
    },
  },
}

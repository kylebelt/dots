return {
  "folke/todo-comments.nvim",
  keys = {
    { "[t", false },
    { "]t", false },
    {
      "[zt",
      function()
        require("todo-comments").jump_prev()
      end,
      desc = "Previous Todo Comment",
    },
    {
      "]zt",
      function()
        require("todo-comments").jump_next()
      end,
      desc = "Next Todo Comment",
    },
  },
  opts = {
    keywords = {
      SECTION = {
        icon = "󰚟 ",
        color = "#ff75a0",
      },
      colors = {
        section = { "#ff75a0" },
      },
    },
  },
}

vim.g.trouble_lualine = false

return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local c = opts.sections.lualine_c
      for i = #c, 1, -1 do
        if type(c[i]) == "table" and c[i][1] == "aerial" then
          table.remove(c, i)
        end
      end
    end,
  },
}

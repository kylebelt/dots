-- Persists and restores colorscheme selection across sessions.
-- Keybind: <leader>uC — opens Snacks colorscheme picker (filters built-ins, sorts alphabetically)

local data = vim.fn.stdpath("data")
local cs_file = data .. "/colorscheme"
local vimruntime = vim.env.VIMRUNTIME

local function write_file(path, value)
  local f = io.open(path, "w")
  if f then
    f:write(value)
    f:close()
  end
end

local function read_file(path, default)
  local f = io.open(path, "r")
  if not f then
    return default
  end
  local v = f:read("*l")
  f:close()
  return v or default
end

return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        vim.cmd("colorscheme " .. read_file(cs_file, "tokyonight"))
      end,
    },
  },

  {
    "theme-picker",
    virtual = true,
    config = function()
      vim.keymap.set("n", "<leader>uC", function()
        Snacks.picker.colorschemes({
          finder = function()
            local items = require("snacks.picker.source.vim").colorschemes()
            items = vim.tbl_filter(function(item)
              return not vim.startswith(item.file, vimruntime)
            end, items)
            table.sort(items, function(a, b)
              return a.text < b.text
            end)
            return items
          end,
          confirm = function(picker, item)
            picker:close()
            if not item then
              return
            end
            picker.preview.state.colorscheme = nil
            vim.schedule(function()
              write_file(cs_file, item.text)
              vim.cmd("colorscheme " .. item.text)
            end)
          end,
        })
      end, { desc = "Colorschemes" })
    end,
  },
}

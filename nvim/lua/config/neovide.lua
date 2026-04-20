if vim.g.neovide then
  local function save()
    vim.cmd.write()
  end
  local function copy()
    vim.cmd([[normal! "+y]])
  end
  local function paste()
    vim.api.nvim_paste(vim.fn.getreg("+"), true, -1)
  end

  vim.o.guifont = "IoskeleyMono Nerd Font:h15"
  vim.g.neovide_show_border = false
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_theme = "bg_color"

  -- Enable copy/paste
  vim.keymap.set({ "n", "i", "v" }, "<D-s>", save, { desc = "Save Neovide" })
  vim.keymap.set("v", "<D-c>", copy, { silent = true, desc = "Copy Neovide" })
  vim.keymap.set({ "n", "i", "v", "c", "t" }, "<D-v>", paste, { silent = true, desc = "Paste Neovide" })

  -- Set
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      if vim.g.transparent_enabled then
        vim.cmd("TransparentDisable")
        vim.g.neovide_opacity = vim.g.neovide_transparent_opacity
        vim.g.neovide_normal_opacity = vim.g.neovide_transparent_opacity
        vim.g.neovide_window_blurred = true
      end
    end,
  })

  -- Example: Clean up on quit
  vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
      if vim.g.neovide_opacity ~= 1 then
        vim.cmd("TransparentEnable")
      end
    end,
  })
end

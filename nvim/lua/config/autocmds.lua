-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Set spell check and wrapping only for selected filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "markdown",
    "markdown.mdx",
    "text",
    "gitcommit",
    "plaintex",
    "typst",
    "tex",
    "latex",
    "rst",
    "asciidoc",
    "org",
    "norg",
    "mail",
  },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.wrap = true
  end,
})

-- Sync yanks (not deletes/changes) to system clipboard
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    if vim.v.event.operator == "y" then
      vim.fn.setreg("+", vim.v.event.regcontents, vim.v.event.regtype)
    end
  end,
})

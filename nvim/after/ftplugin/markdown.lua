-- Pandoc conversion keymap
vim.keymap.set("n", "<leader>cP", function()
  -- Validade dependencies
  local deps = {
    { cmd = "pandoc", install = "brew install pandoc" },
    { cmd = "tectonic", install = "brew install tectonic" },
    { cmd = "pdflatex", install = "brew install basictex" },
  }
  for _, dep in ipairs(deps) do
    if vim.fn.executable(dep.cmd) ~= 1 then
      vim.notify(dep.cmd .. " not found! Install with: " .. dep.install, vim.log.levels.ERROR)
      return
    end
  end

  local file = vim.fn.expand("%:p")

  -- Sets up fallback in case template is not found
  local defaults = vim.fn.expand("~/.local/share/pandoc/defaults/md_to_pdf.yaml")
  local cmd_base = vim.fn.filereadable(defaults) == 1 and { "pandoc", "-d", "md_to_pdf" }
    or { "pandoc", "--pdf-engine=tectonic" }

  -- Conversion function
  local function run(input, out, tmp)
    vim.notify("Exporting to PDF...", vim.log.levels.INFO)
    local cmd = vim.list_extend(vim.list_extend({}, cmd_base), { input, "-o", out })
    vim.system(cmd, { text = true }, function(obj)
      vim.schedule(function()
        if tmp then
          os.remove(tmp)
        end
        if obj.code ~= 0 then
          vim.notify(obj.stderr, vim.log.levels.ERROR)
        else
          vim.ui.open(out)
        end
      end)
    end)
  end

  if file == "" then
    -- If buffer is not named, ask for a name and perform export without saving current buffer to file
    vim.ui.input({ prompt = "PDF Name: " }, function(name)
      if not name or name == "" then
        return
      end
      if not name:match("%.pdf$") then
        name = name .. ".pdf"
      end
      local tmp = vim.fn.tempname() .. ".md"
      local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
      local f = io.open(tmp, "w")
      if not f then
        vim.notify("Failed to create temp file", vim.log.levels.ERROR)
        return
      end
      f:write(table.concat(lines, "\n"))
      f:close()
      run(tmp, name, tmp)
    end)
  else
    -- Call conversion to current buffer
    run(file, vim.fn.expand("%:p:r") .. ".pdf")
  end
end, { buffer = true, desc = "Export to PDF" })

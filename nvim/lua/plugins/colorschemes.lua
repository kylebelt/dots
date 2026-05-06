-- Load only the current scheme, lazy load the rest
local current = (function()
  local f = io.open(vim.fn.stdpath("data") .. "/colorscheme", "r")
  if not f then
    return "tokyonight"
  end
  local v = f:read("*l")
  f:close()
  return v or "tokyonight"
end)()

local function is_lazy(plugin_name)
  local handle = vim.uv.fs_scandir(vim.fn.stdpath("data") .. "/lazy/" .. plugin_name .. "/colors")
  if not handle then
    return true
  end
  while true do
    local name = vim.uv.fs_scandir_next(handle)
    if not name then
      return true
    end
    if name:gsub("%.lua$", ""):gsub("%.vim$", "") == current then
      return false
    end
  end
end

-- Changes colorscheme styles
local function add_style(group, style)
  local hl = vim.api.nvim_get_hl(0, { name = group })
  for k, v in pairs(style) do
    hl[k] = v
  end
  vim.api.nvim_set_hl(0, group, hl)
end

return {
  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    opts = {
      exclude_groups = {
        "CursorLine",
        "CursorLineNr",
        "NormalFloat",
      },
    },
  },

  {
    "ember-theme/nvim",
    name = "ember",
    lazy = is_lazy("ember"),
    priority = 1000,
  },

  {
    "tiagovla/tokyodark.nvim",
    name = "tokyodark",
    lazy = is_lazy("tokyodark"),
    priority = 1000,
  },

  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = is_lazy("rose-pine"),
    priority = 1000,
  },

  {
    "Mofiqul/dracula.nvim",
    name = "dracula",
    lazy = is_lazy("dracula"),
    priority = 1000,
  },

  {
    "shaunsingh/nord.nvim",
    name = "nord",
    lazy = is_lazy("nord"),
    priority = 1000,
  },

  {
    "sainnhe/gruvbox-material",
    name = "gruvbox-material",
    lazy = is_lazy("gruvbox-material"),
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_enable_italic = true
      vim.g.gruvbox_material_statusline_style = "default" -- default/mix/original
      vim.g.gruvbox_material_float_style = "brigit" -- bright/dim/blend
    end,
  },

  {
    "sainnhe/edge",
    name = "edge",
    lazy = is_lazy("edge"),
    priority = 1000,
    config = function()
      vim.g.edge_enable_italic = true
      vim.g.edge_style = "aura" -- default/aura/neon
      vim.g.edge_float_style = "bright" -- brigt/dim/blend
      vim.g.edge_better_performance = 1
    end,
  },

  {
    "sainnhe/everforest",
    name = "everforest",
    lazy = is_lazy("everforest"),
    priority = 1000,
    config = function()
      vim.g.everforest_enable_italic = true
      vim.g.everforest_float_style = "bright" --bright/dim/blend
    end,
  },

  {
    "sainnhe/sonokai",
    name = "sonokai",
    lazy = is_lazy("sonokai"),
    priority = 1000,
    config = function()
      vim.g.sonokai_style = "default" -- default/atlantis/andromeda/shusia/maia/espresso
      vim.g.sonokai_float_style = "bright" --bright/dim/blend
      vim.g.sonokai_enable_italic = true
    end,
  },

  {
    "shatur/neovim-ayu",
    name = "ayu",
    lazy = is_lazy("ayu"),
    priority = 1000,
  },

  {
    "EdenEast/nightfox.nvim",
    name = "nightfox",
    lazy = is_lazy("nightfox"),
    priority = 1000,
    opts = {
      options = {
        styles = {
          comments = "italic",
          keywords = "bold",
          types = "italic,bold",
          variables = "bold",
          constants = "bold",
          functions = "italic",
          operators = "bold",
          strings = "italic",
        },
      },
    },
  },

  {
    "savq/melange-nvim",
    name = "melange",
    lazy = is_lazy("melange"),
  },

  {
    "wtfox/jellybeans.nvim",
    name = "jellybeans",
    lazy = is_lazy("jellybeans"),
    priority = 1000,
  },

  {
    "Mofiqul/vscode.nvim",
    name = "vscode",
    lazy = is_lazy("vscode"),
    priority = 1000,
  },

  {
    "dgox16/oldworld.nvim",
    name = "oldworld",
    lazy = is_lazy("oldworld"),
    priority = 1000,
  },

  {
    "uloco/bluloco.nvim",
    name = "bluloco",
    lazy = is_lazy("bluloco"),
    priority = 1000,
    dependencies = { "rktjmp/lush.nvim" },
    opts = {
      style = "dark",
      italics = true,
    },
  },

  {
    "miikanissi/modus-themes.nvim",
    name = "modus-themes",
    lazy = is_lazy("modus-themes"),
    priority = 1000,
    opts = {
      style = "modus_operandi",
      dim_inactive = true,
      hide_inactive_statusline = false,
    },
  },

  {
    "https://gitlab.com/shmerl/neogotham",
    name = "neogotham",
    lazy = is_lazy("neogotham"),
    priority = 1000, -- to load before other plugins
  },

  {
    "bluz71/vim-moonfly-colors",
    name = "moonfly",
    lazy = is_lazy("moonfly"),
    priority = 1000,
    config = function()
      vim.g.moonflyUnderlineMatchParen = true
    end,
  },

  {
    "ptdewey/darkearth-nvim",
    name = "darkearth",
    lazy = is_lazy("darkearth"),
    priority = 1000,
  },

  {
    "scottmckendry/cyberdream.nvim",
    name = "cyberdream",
    lazy = is_lazy("cyberdream"),
    priority = 1000,
    opts = {
      theme = "dark", -- auto/dark/light
      italic_comments = true,
    },
  },

  {
    "olivercederborg/poimandres.nvim",
    name = "poimandres",
    lazy = is_lazy("poimandres"),
    priority = 1000,
  },

  {
    "rebelot/kanagawa.nvim",
    name = "kanagawa",
    lazy = is_lazy("kanagawa"),
    priority = 1000,
    opts = {
      theme = "wave", -- wave/lotus/dragon
      undercurl = true,
      dimInactive = true,
    },
  },

  {
    "olimorris/onedarkpro.nvim",
    name = "onedarkpro",
    lazy = is_lazy("onedarkpro"),
    priority = 1000, -- Ensure it loads first
  },

  {
    "vague-theme/vague.nvim",
    name = "vague",
    lazy = is_lazy("vague"),
    priority = 1000,
  },

  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = is_lazy("github-theme"),
    priority = 1000, -- make sure to load this before all the other start plugins
  },

  {
    "craftzdog/solarized-osaka.nvim",
    name = "solarized-osaka",
    lazy = is_lazy("solarized-osaka"),
    priority = 1000,
  },

  {
    "marko-cerovac/material.nvim",
    name = "material",
    lazy = is_lazy("material"),
    priority = 1000,
  },

  {
    "AlexvZyl/nordic.nvim",
    name = "nordic",
    lazy = is_lazy("nordic"),
    priority = 1000,
  },

  {
    "akinsho/horizon.nvim",
    name = "horizon",
    lazy = is_lazy("horizon"),
    version = "*",
  },

  {
    "NTBBloodbath/doom-one.nvim",
    name = "doom-one",
    lazy = is_lazy("doom-one"),
  },

  {
    "bluz71/vim-nightfly-colors",
    name = "nightfly",
    lazy = is_lazy("nightfly"),
    priority = 1000,
    config = function()
      vim.g.nightflyWinSeparator = 2
      vim.g.nightflyCursorColor = true

      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "nightfly",
        callback = function()
          add_style("LineNr", { bg = "#01111e" })
          add_style("SignColumn", { bg = "#01111e" })
          add_style("FoldColumn", { bg = "#01111e" })
          add_style("CursorLineNr", { bg = "#01111e" })
        end,
      })
    end,
  },

  {
    "oxfist/night-owl.nvim",
    name = "night-owl",
    lazy = is_lazy("night-owl"),
    priority = 1000,
  },
}

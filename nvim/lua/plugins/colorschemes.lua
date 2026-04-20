local ttoggle = vim.g.transparent_enabled

-- Unset theme transparency if using neovide, but set neovide transparency
-- To avoid black, transparent bg
-- if vim.g.neovide and ttoggle then
--   ttoggle = false
--   vim.cmd("TransparentDisable")
--
--   vim.g.neovide_opacity = 0.7
--   vim.g.neovide_normal_opacity = 0.7
--   vim.g.neovide_window_blurred = true
-- end

return {
  {
    "xiyaowong/transparent.nvim",
    config = function()
      require("transparent").setup({
        exclude_groups = { "CursorLine", "CursorLineNr" },
      })
    end,
  },

  {
    "folke/tokyonight.nvim",
    -- opts = {
    --   transparent = ttoggle,
    --   styles = {
    --     sidebars = ttoggle and "transparent" or "dark",
    --     floats = ttoggle and "transparent" or "dark",
    --   },
    -- },
  },

  {
    "catppuccin/nvim",
    -- opts = {
    --   transparent_background = ttoggle,
    --   styles = {
    --     sidebars = ttoggle and "transparent" or "dark",
    --     floats = ttoggle and "transparent" or "dark",
    --   },
    -- },
  },

  {
    "ember-theme/nvim",
    name = "ember",
    lazy = false,
    priority = 1000,
    -- config = function()
    --   require("ember").setup({
    --     transparent = ttoggle,
    --   })
    -- end,
  },

  {
    "tiagovla/tokyodark.nvim",
    name = "tokyodark",
    lazy = false,
    priority = 1000,
    -- config = function()
    --   require("tokyodark").setup({
    --     transparent_background = ttoggle,
    --   })
    -- end,
  },

  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    -- config = function()
    --   require("rose-pine").setup({
    --     styles = {
    --       transparency = ttoggle,
    --     },
    --   })
    -- end,
  },

  {
    "Mofiqul/dracula.nvim",
    name = "dracula",
    lazy = false,
    priority = 1000,
    -- config = function()
    --   require("dracula").setup({
    --     transparent_bg = ttoggle,
    --     overrides = ttoggle and {
    --       NormalFloat = { bg = "NONE" },
    --       FloatBorder = { bg = "NONE" },
    --       NvimTreeNormal = { bg = "NONE" },
    --       NeoTreeNormal = { bg = "NONE" },
    --     } or {},
    --   })
    -- end,
  },

  {
    "shaunsingh/nord.nvim",
    name = "nord",
    lazy = true,
    priority = 1000,
    -- config = function()
    --   vim.g.nord_disable_background = ttoggle
    --   vim.g.nord_cursorline_transparent = ttoggle
    --   require("nord").set()
    -- end,
  },

  {
    "sainnhe/gruvbox-material",
    name = "gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      -- vim.g.gruvbox_material_transparent_background = ttoggle and 1 or 0
      vim.g.gruvbox_material_enable_italic = true
      vim.g.gruvbox_material_statusline_style = "default" -- default/mix/original
      vim.g.gruvbox_material_float_style = "brigit" -- bright/dim/blend
    end,
  },

  {
    "sainnhe/edge",
    name = "edge",
    lazy = false,
    priority = 1000,
    config = function()
      -- vim.g.edge_transparent_background = ttoggle and 1 or 0
      vim.g.edge_enable_italic = true
      vim.g.edge_style = "aura" -- default/aura/neon
      vim.g.edge_float_style = "bright" -- brigt/dim/blend
      vim.g.edge_better_performance = 1
    end,
  },

  {
    "sainnhe/everforest",
    lazy = false,
    priority = 1000,
    config = function()
      -- vim.g.everforest_transparent_background = ttoggle and 1 or 0
      vim.g.everforest_enable_italic = true
      vim.g.everforest_float_style = "bright" --bright/dim/blend
    end,
  },

  {
    "sainnhe/sonokai",
    lazy = false,
    priority = 1000,
    config = function()
      -- vim.g.sonokai_transparent_background = ttoggle and 1 or 0
      vim.g.sonokai_style = "default" -- default/atlantis/andromeda/shusia/maia/espresso
      vim.g.sonokai_float_style = "bright" --bright/dim/blend
      vim.g.sonokai_enable_italic = true
    end,
  },

  {
    "shatur/neovim-ayu",
    name = "ayu",
    lazy = false,
    priority = 1000,
    -- config = function()
    --   if ttoggle then
    --     require("ayu").setup({
    --       overrides = {
    --         Normal = { bg = "None" },
    --         NormalFloat = { bg = "none" },
    --         -- ColorColumn = { bg = "None" },
    --         SignColumn = { bg = "None" },
    --         Folded = { bg = "None" },
    --         FoldColumn = { bg = "None" },
    --         CursorLine = { bg = "None" },
    --         CursorColumn = { bg = "None" },
    --         VertSplit = { bg = "None" },
    --       },
    --     })
    --   end
    -- end,
  },

  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("nightfox").setup({
        options = {
          -- transparent = ttoggle,
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
      })
    end,
  },
  {
    "savq/melange-nvim",
  },

  {
    "wtfox/jellybeans.nvim",
    lazy = false,
    priority = 1000,
    -- opts = {
    --   transparent = ttoggle,
    -- },
  },

  {
    "Mofiqul/vscode.nvim",
    lazy = false,
    priority = 1000,
    -- config = function()
    --   require("vscode").setup({
    --     transparent = ttoggle,
    --   })
    -- end,
  },

  {
    "dgox16/oldworld.nvim",
    lazy = false,
    priority = 1000,
    -- config = function()
    --   if ttoggle then
    --     require("oldworld").setup({
    --       variant = "oled",
    --       styles = {
    --         booleans = { bold = true },
    --         functions = { italic = true },
    --         comments = { italic = true },
    --       },
    --       highlight_overrides = {
    --         Normal = { bg = "NONE" },
    --         NormalNC = { bg = "NONE" },
    --         CursorLine = { bg = "#222128" },
    --       },
    --     })
    --   else
    --     require("oldworld").setup({
    --       variant = "default", -- default/oled/cooler
    --     })
    --   end
    -- end,
  },

  {
    "uloco/bluloco.nvim",
    lazy = false,
    priority = 1000,
    dependencies = { "rktjmp/lush.nvim" },
    config = function()
      require("bluloco").setup({
        style = "dark",
        -- transparent = ttoggle,
        italics = true,
      })
    end,
  },

  {
    "miikanissi/modus-themes.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("modus-themes").setup({
        style = "modus_operandi",
        -- transparent = ttoggle,
        dim_inactive = true,
        hide_inactive_statusline = false,
      })
    end,
  },

  {
    "https://gitlab.com/shmerl/neogotham",
    lazy = false, -- to make sure it's loaded on startup
    priority = 1000, -- to load before other plugins
    config = function()
      require("neogotham").setup({})
    end,
  },

  {
    "bluz71/vim-moonfly-colors",
    name = "moonfly",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.moonflyUnderlineMatchParen = true
      -- vim.g.moonflyTransparent = ttoggle
    end,
  },

  {
    "ptdewey/darkearth-nvim",
    lazy = false,
    priority = 1000,
  },

  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("cyberdream").setup({
        theme = "dark", -- auto/dark/light
        -- transparent = ttoggle,
        italic_comments = true,
      })
    end,
  },

  {
    "olivercederborg/poimandres.nvim",
    lazy = false,
    priority = 1000,
    -- config = function()
    --   require("poimandres").setup({
    --     disable_background = ttoggle,
    --   })
    -- end,
  },

  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        theme = "wave", -- wave/lotus/dragon
        -- transparent = ttoggle,
        undercurl = true,
        dimInactive = true,
      })
    end,
  },

  {
    "olimorris/onedarkpro.nvim",
    name = "onedarkpro",
    lazy = false,
    priority = 1000, -- Ensure it loads first
    -- config = function()
    --   require("onedarkpro").setup({
    --     options = {
    --       transparency = ttoggle,
    --       lualine_transparency = ttoggle,
    --     },
    --   })
    -- end,
  },

  {
    "vague-theme/vague.nvim",
    name = "vague",
    lazy = false,
    priority = 1000,
    -- config = function()
    --   require("vague").setup({
    --     transparent = ttoggle,
    --   })
    -- end,
  },

  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    -- config = function()
    --   require("github-theme").setup({
    --     options = {
    --       transparent = ttoggle,
    --     },
    --   })
    -- end,
  },

  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    -- config = function()
    --   ---@diagnostic disable-next-line: missing-fields
    --   require("solarized-osaka").setup({
    --     transparent = ttoggle,
    --   })
    -- end,
  },

  {
    "marko-cerovac/material.nvim",
    lazy = false,
    priority = 1000,
    -- config = function()
    --   require("material").setup({
    --     disable = {
    --       background = ttoggle,
    --     },
    --   })
    -- end,
  },

  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
    priority = 1000,
    -- config = function()
    --   ---@diagnostic disable-next-line: missing-fields
    --   require("nordic").setup({
    --     transparent = {
    --       bg = ttoggle,
    --       float = ttoggle,
    --     },
    --   })
    -- end,
  },

  {
    "akinsho/horizon.nvim",
    version = "*",
  },

  {
    "NTBBloodbath/doom-one.nvim",
  },
}

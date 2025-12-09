-- UI plugins
return {
  -- Colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = false,
        custom_highlights = function(colors)
          return {
            -- Pitch black background
            Normal = { bg = "#000000", fg = "#f8f6f0" },
            NormalFloat = { bg = "#000000", fg = "#f8f6f0" },
            NormalNC = { bg = "#000000", fg = "#f8f6f0" },
            SignColumn = { bg = "#000000" },
            
            -- Borders
            FloatBorder = { fg = "#a5a9b4", bg = "#000000" },
            WinSeparator = { fg = "#a5a9b4" },
            
            -- UI elements with theme colors
            CursorLine = { bg = "#0a0a0a" },
            Visual = { bg = "#1a1a1a" },
            
            -- Primary accent
            Keyword = { fg = "#d4af37", style = { "bold" } },
            Function = { fg = "#d4af37" },
            
            -- Success/Info/Error
            DiagnosticOk = { fg = "#50c878" },
            DiagnosticHint = { fg = "#0f52ba" },
            DiagnosticError = { fg = "#b00000" },
            DiagnosticWarn = { fg = "#ffa500" },
            
            -- Statusline
            StatusLine = { bg = "#000000", fg = "#f8f6f0" },
            StatusLineNC = { bg = "#000000", fg = "#a5a9b4" },
          }
        end,
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- Icons
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        theme = "auto",
        component_separators = { left = "|", right = "|" },
        section_separators = { left = "", right = "" },
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = { "filename" },
        lualine_x = {
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = { error = " ", warn = " ", info = " ", hint = " " },
          },
          "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },

  -- Better UI for inputs/selections
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {
      input = {
        border = "rounded",
        win_options = {
          winblend = 0,
        },
      },
      select = {
        backend = { "telescope", "builtin" },
        builtin = {
          border = "rounded",
          win_options = {
            winblend = 0,
          },
        },
      },
    },
  },
}

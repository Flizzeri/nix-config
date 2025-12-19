-- ╭──────────────────────────────────────────────────────────────────────────╮
-- │                                  UI                                      │
-- │              Gradient Pills: magenta → purple → indigo → cyan            │
-- ╰──────────────────────────────────────────────────────────────────────────╯

return {
  -- ── Lualine ───────────────────────────────────────────────────────────────
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
      -- Gradient colors matching starship
      local colors = {
        bg = "#000000",
        fg = "#c0caf5",
        silver = "#a9b1d6",
        darkgray = "#1a1b26",
        gray = "#3b4261",
        -- Gradient stops
        magenta = "#bb9af7",
        purple = "#9d7cd8",
        indigo = "#7aa2f7",
        cyan = "#7dcfff",
        -- Accent for errors
        red = "#f7768e",
      }

      -- Theme using the gradient
      local theme = {
        normal = {
          a = { fg = colors.darkgray, bg = colors.magenta, gui = "bold" },
          b = { fg = colors.darkgray, bg = colors.purple },
          c = { fg = colors.silver, bg = colors.bg },
        },
        insert = {
          a = { fg = colors.darkgray, bg = colors.cyan, gui = "bold" },
          b = { fg = colors.darkgray, bg = colors.indigo },
        },
        visual = {
          a = { fg = colors.darkgray, bg = colors.purple, gui = "bold" },
          b = { fg = colors.darkgray, bg = colors.magenta },
        },
        replace = {
          a = { fg = colors.darkgray, bg = colors.red, gui = "bold" },
          b = { fg = colors.darkgray, bg = colors.purple },
        },
        command = {
          a = { fg = colors.darkgray, bg = colors.indigo, gui = "bold" },
          b = { fg = colors.darkgray, bg = colors.purple },
        },
        inactive = {
          a = { fg = colors.gray, bg = colors.bg },
          b = { fg = colors.gray, bg = colors.bg },
          c = { fg = colors.gray, bg = colors.bg },
        },
      }

      return {
        options = {
          theme = theme,
          globalstatus = true,
          disabled_filetypes = {
            statusline = { "dashboard", "alpha", "starter" },
          },
          component_separators = "",
          section_separators = { left = "", right = "" },
        },
        sections = {
          -- Left: Mode (magenta) → Branch (purple) → Diff
          lualine_a = {
            {
              "mode",
              fmt = function(str)
                return str:sub(1, 3)
              end,
              separator = { left = "", right = "" },
              padding = { left = 1, right = 1 },
            },
          },
          lualine_b = {
            {
              "branch",
              icon = "",
              color = { fg = colors.darkgray, bg = colors.purple },
              separator = { left = "", right = "" },
              padding = { left = 1, right = 1 },
            },
            {
              "diff",
              symbols = { added = "+ ", modified = "~ ", removed = "- " },
              diff_color = {
                added = { fg = colors.cyan },
                modified = { fg = colors.indigo },
                removed = { fg = colors.red },
              },
              separator = { left = "", right = "" },
              padding = { left = 1, right = 1 },
            },
          },
          lualine_c = {
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              symbols = { error = " ", warn = " ", info = " ", hint = " " },
              diagnostics_color = {
                error = { fg = colors.red },
                warn = { fg = colors.magenta },
                info = { fg = colors.indigo },
                hint = { fg = colors.cyan },
              },
              padding = { left = 1, right = 1 },
            },
            { "%=", padding = 0 },
            {
              "filename",
              path = 1,
              symbols = { modified = " ●", readonly = " ", unnamed = "[No Name]", newfile = " " },
              color = { fg = colors.silver },
              padding = { left = 1, right = 1 },
            },
          },
          -- Right: LSP → Filetype (indigo) → Location (cyan)
          lualine_x = {
            {
              function()
                local clients = vim.lsp.get_clients({ bufnr = 0 })
                if next(clients) == nil then return "" end
                local names = {}
                for _, client in ipairs(clients) do
                  table.insert(names, client.name)
                end
                return " " .. table.concat(names, ", ")
              end,
              color = { fg = colors.purple },
              padding = { left = 1, right = 1 },
            },
          },
          lualine_y = {
            {
              "filetype",
              icon_only = false,
              color = { fg = colors.darkgray, bg = colors.indigo },
              separator = { left = "", right = "" },
              padding = { left = 1, right = 1 },
            },
          },
          lualine_z = {
            {
              "location",
              color = { fg = colors.darkgray, bg = colors.cyan, gui = "bold" },
              separator = { left = "", right = "" },
              padding = { left = 1, right = 1 },
            },
          },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        -- Tabline with gradient pills
        tabline = {
          lualine_a = {
            {
              "buffers",
              show_filename_only = true,
              hide_filename_extension = false,
              show_modified_status = true,
              mode = 2,
              max_length = vim.o.columns * 2 / 3,
              symbols = { modified = " ●", alternate_file = "", directory = "" },
              buffers_color = {
                active = { fg = colors.darkgray, bg = colors.indigo, gui = "bold" },
                inactive = { fg = colors.gray, bg = colors.darkgray },
              },
              separator = { left = "", right = "" },
              padding = { left = 1, right = 1 },
            },
          },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {
            {
              "tabs",
              mode = 0,
              tabs_color = {
                active = { fg = colors.darkgray, bg = colors.purple, gui = "bold" },
                inactive = { fg = colors.gray, bg = colors.darkgray },
              },
              separator = { left = "", right = "" },
              padding = { left = 1, right = 1 },
            },
          },
        },
        extensions = { "lazy", "quickfix" },
      }
    end,
  },

  -- ── Noice ─────────────────────────────────────────────────────────────────
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      cmdline = {
        enabled = true,
        view = "cmdline_popup",
        format = {
          cmdline = { pattern = "^:", icon = "", lang = "vim" },
          search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
          filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
          lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
          help = { pattern = "^:%s*he?l?p?%s+", icon = "󰋖" },
        },
      },
      messages = {
        enabled = true,
        view = "notify",
        view_error = "notify",
        view_warn = "notify",
        view_history = "messages",
        view_search = "virtualtext",
      },
      popupmenu = {
        enabled = true,
        backend = "nui",
      },
      lsp = {
        progress = { enabled = true, view = "mini" },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        hover = { enabled = true },
        signature = { enabled = false },
      },
      presets = {
        bottom_search = false,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
        lsp_doc_border = true,
      },
      views = {
        cmdline_popup = {
          border = { style = "rounded", padding = { 0, 1 } },
          win_options = {
            winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
          },
        },
      },
      routes = {
        { filter = { event = "msg_show", kind = "", find = "written" }, opts = { skip = true } },
        { filter = { event = "msg_show", kind = "search_count" }, opts = { skip = true } },
      },
    },
    keys = {
      { "<leader>snl", function() require("noice").cmd("last") end, desc = "Last message" },
      { "<leader>snh", function() require("noice").cmd("history") end, desc = "Message history" },
      { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss all" },
    },
  },

  -- ── Notify ────────────────────────────────────────────────────────────────
  {
    "rcarriga/nvim-notify",
    lazy = true,
    opts = {
      timeout = 3000,
      max_height = function() return math.floor(vim.o.lines * 0.75) end,
      max_width = function() return math.floor(vim.o.columns * 0.75) end,
      background_colour = "#000000",
      render = "wrapped-compact",
      stages = "fade_in_slide_out",
      top_down = true,
    },
    init = function()
      vim.notify = require("notify")
    end,
  },

  -- ── Dressing ──────────────────────────────────────────────────────────────
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
    opts = {
      input = {
        enabled = true,
        border = "rounded",
        relative = "cursor",
        win_options = {
          winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
        },
      },
      select = {
        enabled = true,
        backend = { "telescope", "builtin" },
        builtin = {
          border = "rounded",
          win_options = {
            winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
          },
        },
      },
    },
  },

  -- ── Web Devicons ──────────────────────────────────────────────────────────
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    opts = {},
  },
}

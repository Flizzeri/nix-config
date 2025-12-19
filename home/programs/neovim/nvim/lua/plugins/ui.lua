-- ╭──────────────────────────────────────────────────────────────────────────╮
-- │                                  UI                                      │
-- ╰──────────────────────────────────────────────────────────────────────────╯

return {
  -- ── Lualine ───────────────────────────────────────────────────────────────
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
      local colors = {
        bg = "#0a0a0f",
        fg = "#c0caf5",
        blue = "#7aa2f7",
        cyan = "#7dcfff",
        green = "#9ece6a",
        magenta = "#bb9af7",
        orange = "#ff9e64",
        red = "#f7768e",
        yellow = "#e0af68",
        gray = "#3b4261",
        dark = "#16161e",
      }

      -- Segment separators for outlined/filled look
      local separators = {
        left = "",
        right = "",
        component_left = "",
        component_right = "",
      }

      local theme = {
        normal = {
          a = { fg = colors.bg, bg = colors.blue, gui = "bold" },
          b = { fg = colors.blue, bg = colors.dark },
          c = { fg = colors.fg, bg = colors.bg },
        },
        insert = {
          a = { fg = colors.bg, bg = colors.green, gui = "bold" },
          b = { fg = colors.green, bg = colors.dark },
        },
        visual = {
          a = { fg = colors.bg, bg = colors.magenta, gui = "bold" },
          b = { fg = colors.magenta, bg = colors.dark },
        },
        replace = {
          a = { fg = colors.bg, bg = colors.red, gui = "bold" },
          b = { fg = colors.red, bg = colors.dark },
        },
        command = {
          a = { fg = colors.bg, bg = colors.yellow, gui = "bold" },
          b = { fg = colors.yellow, bg = colors.dark },
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
            winbar = {},
          },
          component_separators = { left = "", right = "" },
          section_separators = { left = separators.left, right = separators.right },
        },
        sections = {
          lualine_a = {
            {
              "mode",
              fmt = function(str)
                return str:sub(1, 3)
              end,
              separator = { left = "", right = separators.left },
              padding = { left = 1, right = 1 },
            },
          },
          lualine_b = {
            {
              "branch",
              icon = "",
              padding = { left = 1, right = 1 },
            },
            {
              "diff",
              symbols = {
                added = " ",
                modified = " ",
                removed = " ",
              },
              colored = true,
              diff_color = {
                added = { fg = colors.green },
                modified = { fg = colors.blue },
                removed = { fg = colors.red },
              },
              padding = { left = 1, right = 1 },
            },
          },
          lualine_c = {
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              symbols = {
                error = " ",
                warn = " ",
                info = " ",
                hint = " ",
              },
              diagnostics_color = {
                error = { fg = colors.red },
                warn = { fg = colors.yellow },
                info = { fg = colors.blue },
                hint = { fg = colors.cyan },
              },
              padding = { left = 1, right = 1 },
            },
            { "%=", padding = 0 }, -- Center divider
            {
              "filename",
              path = 1, -- Relative path
              symbols = {
                modified = " ●",
                readonly = " ",
                unnamed = "[No Name]",
                newfile = " ",
              },
              padding = { left = 1, right = 1 },
            },
          },
          lualine_x = {
            {
              -- Show macro recording
              function()
                local recording_register = vim.fn.reg_recording()
                if recording_register == "" then
                  return ""
                else
                  return "󰑊 " .. recording_register
                end
              end,
              color = { fg = colors.orange },
              padding = { left = 1, right = 1 },
            },
            {
              -- LSP server name
              function()
                local clients = vim.lsp.get_clients({ bufnr = 0 })
                if next(clients) == nil then
                  return ""
                end
                local names = {}
                for _, client in ipairs(clients) do
                  table.insert(names, client.name)
                end
                return " " .. table.concat(names, ", ")
              end,
              color = { fg = colors.cyan },
              padding = { left = 1, right = 1 },
            },
          },
          lualine_y = {
            {
              "filetype",
              icon_only = false,
              padding = { left = 1, right = 1 },
            },
            {
              "encoding",
              fmt = function(str)
                return str:upper()
              end,
              padding = { left = 1, right = 1 },
            },
          },
          lualine_z = {
            {
              "location",
              separator = { left = separators.right, right = "" },
              padding = { left = 1, right = 1 },
            },
            {
              "progress",
              separator = { left = "", right = "" },
              padding = { left = 0, right = 1 },
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
        tabline = {
          lualine_a = {
            {
              "buffers",
              show_filename_only = true,
              hide_filename_extension = false,
              show_modified_status = true,
              mode = 2, -- Show buffer name + index
              max_length = vim.o.columns * 2 / 3,
              filetype_names = {
                TelescopePrompt = "Telescope",
                lazy = "Lazy",
              },
              symbols = {
                modified = " ●",
                alternate_file = "",
                directory = "",
              },
              buffers_color = {
                active = { fg = colors.cyan, bg = colors.dark, gui = "bold" },
                inactive = { fg = colors.gray, bg = colors.bg },
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
              mode = 0, -- Only tab number
              tabs_color = {
                active = { fg = colors.bg, bg = colors.magenta, gui = "bold" },
                inactive = { fg = colors.gray, bg = colors.dark },
              },
              separator = { left = separators.right, right = "" },
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
        opts = {},
        format = {
          cmdline = { pattern = "^:", icon = "", lang = "vim" },
          search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
          filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
          lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
          help = { pattern = "^:%s*he?l?p?%s+", icon = "󰋖" },
          input = {},
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
        kind_icons = {},
      },
      redirect = {
        view = "popup",
        filter = { event = "msg_show" },
      },
      commands = {
        history = {
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {
            any = {
              { event = "notify" },
              { error = true },
              { warning = true },
              { event = "msg_show", kind = { "" } },
              { event = "lsp", kind = "message" },
            },
          },
        },
        last = {
          view = "popup",
          opts = { enter = true, format = "details" },
          filter = {
            any = {
              { event = "notify" },
              { error = true },
              { warning = true },
              { event = "msg_show", kind = { "" } },
              { event = "lsp", kind = "message" },
            },
          },
          filter_opts = { count = 1 },
        },
        errors = {
          view = "popup",
          opts = { enter = true, format = "details" },
          filter = { error = true },
          filter_opts = { reverse = true },
        },
      },
      notify = {
        enabled = true,
        view = "notify",
      },
      lsp = {
        progress = {
          enabled = true,
          format = "lsp_progress",
          format_done = "lsp_progress_done",
          throttle = 1000 / 30,
          view = "mini",
        },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        hover = {
          enabled = true,
          silent = false,
          view = nil,
          opts = {},
        },
        signature = {
          enabled = false, -- Using lsp_signature.nvim instead
        },
        message = {
          enabled = true,
          view = "notify",
          opts = {},
        },
        documentation = {
          view = "hover",
          opts = {
            lang = "markdown",
            replace = true,
            render = "plain",
            format = { "{message}" },
            win_options = { concealcursor = "n", conceallevel = 3 },
          },
        },
      },
      markdown = {
        hover = {
          ["|(%S-)|"] = vim.cmd.help,
          ["%[.-%]%((%S-)%)"] = require("noice.util").open,
        },
        highlights = {
          ["|%S-|"] = "@text.reference",
          ["@%S+"] = "@parameter",
          ["^%s*(Parameters:)"] = "@text.title",
          ["^%s*(Return:)"] = "@text.title",
          ["^%s*(See also:)"] = "@text.title",
          ["{%S-}"] = "@parameter",
        },
      },
      health = {
        checker = true,
      },
      smart_move = {
        enabled = true,
        excluded_filetypes = { "cmp_menu", "cmp_docs", "notify" },
      },
      presets = {
        bottom_search = false,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
        lsp_doc_border = true,
      },
      throttle = 1000 / 30,
      views = {
        cmdline_popup = {
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
          filter_options = {},
          win_options = {
            winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
          },
        },
        popupmenu = {
          relative = "editor",
          position = {
            row = 8,
            col = "50%",
          },
          size = {
            width = 60,
            height = 10,
          },
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
          win_options = {
            winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
          },
        },
      },
      routes = {
        -- Hide "written" messages
        {
          filter = {
            event = "msg_show",
            kind = "",
            find = "written",
          },
          opts = { skip = true },
        },
        -- Hide search count messages
        {
          filter = {
            event = "msg_show",
            kind = "search_count",
          },
          opts = { skip = true },
        },
      },
      status = {},
      format = {},
    },
    keys = {
      { "<leader>sn", "", desc = "+Noice" },
      { "<leader>snl", function() require("noice").cmd("last") end, desc = "Last message" },
      { "<leader>snh", function() require("noice").cmd("history") end, desc = "Message history" },
      { "<leader>sna", function() require("noice").cmd("all") end, desc = "All messages" },
      { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss all" },
      { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll forward", mode = {"i", "n", "s"} },
      { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll backward", mode = {"i", "n", "s"}},
    },
  },

  -- ── Notify ────────────────────────────────────────────────────────────────
  {
    "rcarriga/nvim-notify",
    lazy = true,
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      background_colour = "#000000",
      render = "wrapped-compact",
      stages = "fade_in_slide_out",
      top_down = true,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
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
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
    opts = {
      input = {
        enabled = true,
        default_prompt = "Input:",
        title_pos = "left",
        insert_only = true,
        start_in_insert = true,
        border = "rounded",
        relative = "cursor",
        prefer_width = 40,
        width = nil,
        max_width = { 140, 0.9 },
        min_width = { 20, 0.2 },
        buf_options = {},
        win_options = {
          wrap = false,
          list = true,
          listchars = "precedes:…,extends:…",
          sidescrolloff = 0,
          winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
        },
        mappings = {
          n = {
            ["<Esc>"] = "Close",
            ["<CR>"] = "Confirm",
          },
          i = {
            ["<C-c>"] = "Close",
            ["<CR>"] = "Confirm",
            ["<Up>"] = "HistoryPrev",
            ["<Down>"] = "HistoryNext",
          },
        },
      },
      select = {
        enabled = true,
        backend = { "telescope", "builtin", "nui" },
        trim_prompt = true,
        telescope = nil,
        builtin = {
          show_numbers = true,
          border = "rounded",
          relative = "editor",
          buf_options = {},
          win_options = {
            cursorline = true,
            cursorlineopt = "both",
            winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
          },
          width = nil,
          max_width = { 140, 0.8 },
          min_width = { 40, 0.2 },
          height = nil,
          max_height = 0.9,
          min_height = { 10, 0.2 },
          mappings = {
            ["<Esc>"] = "Close",
            ["<C-c>"] = "Close",
            ["<CR>"] = "Confirm",
          },
        },
        format_item_override = {},
        get_config = nil,
      },
    },
  },

  -- ── Web Devicons ──────────────────────────────────────────────────────────
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    opts = {
      override = {
        default_icon = {
          icon = "󰈙",
          color = "#6d8086",
          cterm_color = "66",
          name = "Default",
        },
      },
    },
  },
}

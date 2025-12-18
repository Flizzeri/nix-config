-- ╭──────────────────────────────────────────────────────────╮
-- │                      UI PLUGINS                          │
-- ╰──────────────────────────────────────────────────────────╯

return {
  -- ── dressing.nvim ───────────────────────────────────────────
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
        default_prompt = "❯ ",
        title_pos = "left",
        insert_only = true,
        start_in_insert = true,
        border = "rounded",
        relative = "cursor",
        prefer_width = 40,
        width = nil,
        max_width = { 140, 0.9 },
        min_width = { 20, 0.2 },
        win_options = {
          wrap = false,
          list = true,
          listchars = "precedes:…,extends:…",
          sidescrolloff = 0,
          winhighlight = "Normal:Normal,NormalNC:Normal,FloatBorder:FloatBorder",
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
        backend = { "telescope", "builtin" },
        trim_prompt = true,
        telescope = nil,
        builtin = {
          show_numbers = true,
          border = "rounded",
          relative = "editor",
          win_options = {
            cursorline = true,
            cursorlineopt = "both",
            winhighlight = "Normal:Normal,NormalNC:Normal,FloatBorder:FloatBorder",
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
      },
    },
  },
  
  -- ── noice.nvim ──────────────────────────────────────────────
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
          cmdline = { pattern = "^:", icon = " ", lang = "vim" },
          search_down = { kind = "search", pattern = "^/", icon = "  ", lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon = "  ", lang = "regex" },
          filter = { pattern = "^:%s*!", icon = " $", lang = "bash" },
          lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = " ", lang = "lua" },
          help = { pattern = "^:%s*he?l?p?%s+", icon = " 󰋖" },
          input = { view = "cmdline_input", icon = " 󰥻 " },
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
      presets = {
        bottom_search = false,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
        lsp_doc_border = true,
      },
      views = {
        cmdline_popup = {
          position = {
            row = 5,
            col = "50%",
          },
          size = {
            width = 60,
            height = "auto",
          },
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
          filter_options = {},
          win_options = {
            winhighlight = {
              Normal = "NoiceCmdlinePopup",
              FloatBorder = "NoiceCmdlinePopupBorder",
            },
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
            winhighlight = {
              Normal = "NoicePopupmenu",
              FloatBorder = "NoicePopupmenuBorder",
            },
          },
        },
        mini = {
          win_options = {
            winblend = 0,
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
        -- Route long messages to split
        {
          filter = {
            event = "msg_show",
            min_height = 20,
          },
          view = "split",
        },
      },
    },
    keys = {
      { "<leader>sn", "", desc = "+noice" },
      {
        "<S-Enter>",
        function() require("noice").redirect(vim.fn.getcmdline()) end,
        mode = "c",
        desc = "Redirect cmdline",
      },
      {
        "<leader>snl",
        function() require("noice").cmd("last") end,
        desc = "Noice last message",
      },
      {
        "<leader>snh",
        function() require("noice").cmd("history") end,
        desc = "Noice history",
      },
      {
        "<leader>sna",
        function() require("noice").cmd("all") end,
        desc = "Noice all",
      },
      {
        "<leader>snd",
        function() require("noice").cmd("dismiss") end,
        desc = "Dismiss all",
      },
      {
        "<leader>snt",
        function() require("noice").cmd("pick") end,
        desc = "Noice picker",
      },
      {
        "<C-f>",
        function()
          if not require("noice.lsp").scroll(4) then
            return "<C-f>"
          end
        end,
        silent = true,
        expr = true,
        desc = "Scroll forward",
        mode = { "i", "n", "s" },
      },
      {
        "<C-b>",
        function()
          if not require("noice.lsp").scroll(-4) then
            return "<C-b>"
          end
        end,
        silent = true,
        expr = true,
        desc = "Scroll backward",
        mode = { "i", "n", "s" },
      },
    },
    config = function(_, opts)
      require("noice").setup(opts)
      
      -- Configure nvim-notify
      require("notify").setup({
        background_colour = "#000000",
        fps = 30,
        icons = {
          DEBUG = " ",
          ERROR = " ",
          INFO = " ",
          TRACE = " ",
          WARN = " ",
        },
        level = 2,
        minimum_width = 50,
        max_width = 80,
        max_height = 10,
        render = "wrapped-compact",
        stages = "fade",
        time_formats = {
          notification = "%H:%M",
          notification_history = "%FT%T",
        },
        timeout = 3000,
        top_down = true,
      })
    end,
  },
  
  -- ── lualine.nvim ────────────────────────────────────────────
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        vim.o.statusline = " "
      else
        vim.o.laststatus = 0
      end
    end,
    opts = function()
      local c = require("core.colorscheme").colors
      
      -- ── Segmented/Outlined Bar Theme ────────────────────────
      local obsidian_theme = {
        normal = {
          a = { fg = c.bg, bg = c.blue, gui = "bold" },
          b = { fg = c.fg, bg = c.bg_highlight },
          c = { fg = c.fg_dim, bg = c.bg_alt },
        },
        insert = {
          a = { fg = c.bg, bg = c.teal, gui = "bold" },
          b = { fg = c.fg, bg = c.bg_highlight },
          c = { fg = c.fg_dim, bg = c.bg_alt },
        },
        visual = {
          a = { fg = c.bg, bg = c.magenta, gui = "bold" },
          b = { fg = c.fg, bg = c.bg_highlight },
          c = { fg = c.fg_dim, bg = c.bg_alt },
        },
        replace = {
          a = { fg = c.bg, bg = c.red, gui = "bold" },
          b = { fg = c.fg, bg = c.bg_highlight },
          c = { fg = c.fg_dim, bg = c.bg_alt },
        },
        command = {
          a = { fg = c.bg, bg = c.yellow, gui = "bold" },
          b = { fg = c.fg, bg = c.bg_highlight },
          c = { fg = c.fg_dim, bg = c.bg_alt },
        },
        terminal = {
          a = { fg = c.bg, bg = c.green, gui = "bold" },
          b = { fg = c.fg, bg = c.bg_highlight },
          c = { fg = c.fg_dim, bg = c.bg_alt },
        },
        inactive = {
          a = { fg = c.fg_dark, bg = c.bg_alt },
          b = { fg = c.fg_dark, bg = c.bg_alt },
          c = { fg = c.fg_dark, bg = c.bg_alt },
        },
      }
      
      -- ── Mode Icons ──────────────────────────────────────────
      local mode_map = {
        ["NORMAL"] = "",
        ["O-PENDING"] = "",
        ["INSERT"] = "",
        ["VISUAL"] = "󰈈",
        ["V-BLOCK"] = "󰈈",
        ["V-LINE"] = "󰈈",
        ["V-REPLACE"] = "󰈈",
        ["REPLACE"] = "",
        ["COMMAND"] = "",
        ["SHELL"] = "",
        ["TERMINAL"] = "",
        ["EX"] = "",
        ["S-BLOCK"] = "󰈈",
        ["S-LINE"] = "󰈈",
        ["SELECT"] = "󰈈",
        ["CONFIRM"] = "",
        ["MORE"] = "",
      }
      
      return {
        options = {
          theme = obsidian_theme,
          globalstatus = true,
          disabled_filetypes = {
            statusline = { "dashboard", "alpha", "starter" },
          },
          component_separators = { left = "│", right = "│" },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = {
            {
              "mode",
              fmt = function(str)
                return mode_map[str] or str:sub(1, 1)
              end,
              separator = { left = "", right = "" },
              padding = { left = 1, right = 1 },
            },
          },
          lualine_b = {
            {
              "branch",
              icon = "",
              separator = { left = "", right = "" },
              padding = { left = 1, right = 1 },
            },
            {
              "diff",
              symbols = {
                added = " ",
                modified = " ",
                removed = " ",
              },
              diff_color = {
                added = { fg = c.git_add },
                modified = { fg = c.git_change },
                removed = { fg = c.git_delete },
              },
              separator = { left = "", right = "" },
              padding = { left = 1, right = 1 },
            },
          },
          lualine_c = {
            {
              "diagnostics",
              symbols = {
                error = " ",
                warn = " ",
                info = " ",
                hint = " ",
              },
              separator = { left = "", right = "" },
              padding = { left = 1, right = 1 },
            },
            { "%=" }, -- Center spacing
            {
              "filename",
              file_status = true,
              newfile_status = true,
              path = 1, -- Relative path
              symbols = {
                modified = " ●",
                readonly = " ",
                unnamed = "[No Name]",
                newfile = " 󰎔",
              },
              separator = { left = "", right = "" },
              padding = { left = 1, right = 1 },
            },
          },
          lualine_x = {
            {
              function()
                local msg = ""
                local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
                local clients = vim.lsp.get_clients()
                if next(clients) == nil then
                  return msg
                end
                for _, client in ipairs(clients) do
                  local filetypes = client.config.filetypes
                  if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                    return " " .. client.name
                  end
                end
                return msg
              end,
              separator = { left = "", right = "" },
              padding = { left = 1, right = 1 },
            },
          },
          lualine_y = {
            {
              "filetype",
              colored = true,
              icon_only = false,
              separator = { left = "", right = "" },
              padding = { left = 1, right = 1 },
            },
            {
              "encoding",
              fmt = function(str)
                return str:upper()
              end,
              separator = { left = "", right = "" },
              padding = { left = 1, right = 1 },
            },
          },
          lualine_z = {
            {
              "location",
              separator = { left = "", right = "" },
              padding = { left = 1, right = 1 },
            },
            {
              "progress",
              separator = { left = "", right = "" },
              padding = { left = 1, right = 1 },
            },
          },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {
            {
              "filename",
              path = 1,
            },
          },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = { "lazy", "quickfix", "man" },
      }
    end,
  },
}

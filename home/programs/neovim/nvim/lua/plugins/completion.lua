-- ╭──────────────────────────────────────────────────────────────────────────╮
-- │                             Completion                                   │
-- ╰──────────────────────────────────────────────────────────────────────────╯

return {
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        dependencies = {
          {
            "rafamadriz/friendly-snippets",
            config = function()
              require("luasnip.loaders.from_vscode").lazy_load()
            end,
          },
        },
        opts = {
          history = true,
          delete_check_events = "TextChanged",
          region_check_events = "CursorMoved",
        },
      },
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      -- Kind icons with nerd font
      local kind_icons = {
        Text = "󰉿",
        Method = "󰆧",
        Function = "󰊕",
        Constructor = "",
        Field = "󰜢",
        Variable = "󰀫",
        Class = "󰠱",
        Interface = "",
        Module = "",
        Property = "󰜢",
        Unit = "󰑭",
        Value = "󰎠",
        Enum = "",
        Keyword = "󰌋",
        Snippet = "",
        Color = "󰏘",
        File = "󰈙",
        Reference = "󰈇",
        Folder = "󰉋",
        EnumMember = "",
        Constant = "󰏿",
        Struct = "󰙅",
        Event = "",
        Operator = "󰆕",
        TypeParameter = "󰊄",
      }

      -- Check if there are words before cursor
      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      cmp.setup({
        enabled = function()
          -- Disable in comments (optional, remove if you want completion in comments)
          local context = require("cmp.config.context")
          if vim.api.nvim_get_mode().mode == "c" then
            return true
          else
            return not context.in_treesitter_capture("comment")
              and not context.in_syntax_group("Comment")
          end
        end,

        preselect = cmp.PreselectMode.None,

        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        window = {
          completion = cmp.config.window.bordered({
            border = "rounded",
            winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
            col_offset = -3,
            side_padding = 1,
            scrollbar = true,
          }),
          documentation = cmp.config.window.bordered({
            border = "rounded",
            winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
            max_width = 80,
            max_height = 20,
          }),
        },

        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            -- Kind icon
            vim_item.kind = string.format("%s", kind_icons[vim_item.kind] or "")

            -- Source indicator
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip = "[Snip]",
              buffer = "[Buf]",
              path = "[Path]",
            })[entry.source.name]

            -- Truncate long items
            local max_width = 40
            if #vim_item.abbr > max_width then
              vim_item.abbr = vim_item.abbr:sub(1, max_width - 1) .. "…"
            end

            return vim_item
          end,
        },

        mapping = cmp.mapping.preset.insert({
          -- Scroll docs
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),

          -- Trigger completion
          ["<C-Space>"] = cmp.mapping.complete(),

          -- Cancel
          ["<C-e>"] = cmp.mapping.abort(),

          -- Confirm selection
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false, -- Only confirm explicitly selected items
          }),

          -- Tab to cycle through completions and expand snippets
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),

          -- Navigate snippet placeholders
          ["<C-j>"] = cmp.mapping(function()
            if luasnip.jumpable(1) then
              luasnip.jump(1)
            end
          end, { "i", "s" }),

          ["<C-k>"] = cmp.mapping(function()
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { "i", "s" }),
        }),

        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip", priority = 750 },
          { name = "path", priority = 500 },
        }, {
          {
            name = "buffer",
            priority = 250,
            option = {
              -- Only show buffer completions from visible buffers
              get_bufnrs = function()
                local bufs = {}
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                  bufs[vim.api.nvim_win_get_buf(win)] = true
                end
                return vim.tbl_keys(bufs)
              end,
            },
          },
        }),

        sorting = {
          priority_weight = 2,
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },

        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },

        performance = {
          debounce = 60,
          throttle = 30,
          fetching_timeout = 500,
          confirm_resolve_timeout = 80,
          async_budget = 1,
          max_view_entries = 50,
        },
      })

      -- Cmdline completion for search
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      -- Cmdline completion for commands
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          {
            name = "cmdline",
            option = {
              ignore_cmds = { "Man", "!" },
            },
          },
        }),
      })

      -- Ghost text highlight
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
    end,
  },
}

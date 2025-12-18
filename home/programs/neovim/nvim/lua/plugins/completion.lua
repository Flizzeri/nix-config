-- ╭──────────────────────────────────────────────────────────╮
-- │                   COMPLETION                             │
-- ╰──────────────────────────────────────────────────────────╯

return {
  -- ── nvim-cmp ────────────────────────────────────────────────
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "ray-x/lsp_signature.nvim",
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        dependencies = {
          "rafamadriz/friendly-snippets",
        },
        config = function()
          local luasnip = require("luasnip")
          
          luasnip.config.setup({
            history = true,
            delete_check_events = "TextChanged",
            region_check_events = "CursorMoved",
          })
          
          -- Load friendly-snippets
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      
      -- ── Kind Icons ────────────────────────────────────────────
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
        TypeParameter = "",
        Copilot = "",
      }
      
      -- ── Source Labels ─────────────────────────────────────────
      local source_names = {
        nvim_lsp = "[LSP]",
        luasnip = "[Snip]",
        buffer = "[Buf]",
        path = "[Path]",
        cmdline = "[Cmd]",
      }
      
      -- ── Window Borders ────────────────────────────────────────
      local border = {
        { "╭", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╮", "FloatBorder" },
        { "│", "FloatBorder" },
        { "╯", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╰", "FloatBorder" },
        { "│", "FloatBorder" },
      }
      
      -- ── Has Words Before ──────────────────────────────────────
      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end
      
      cmp.setup({
        -- ── Snippet Engine ────────────────────────────────────────
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        
        -- ── Completion Behavior ───────────────────────────────────
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        
        -- ── Preselect ─────────────────────────────────────────────
        preselect = cmp.PreselectMode.Item,
        
        -- ── Window Styling ────────────────────────────────────────
        window = {
          completion = {
            border = border,
            winhighlight = "Normal:CmpDocumentation,FloatBorder:CmpDocumentationBorder,CursorLine:PmenuSel,Search:None",
            scrollbar = true,
            col_offset = -3,
            side_padding = 1,
          },
          documentation = {
            border = border,
            winhighlight = "Normal:CmpDocumentation,FloatBorder:CmpDocumentationBorder",
            max_width = 80,
            max_height = 20,
          },
        },
        
        -- ── Formatting ────────────────────────────────────────────
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            -- Kind icon
            vim_item.kind = string.format("%s", kind_icons[vim_item.kind] or "")
            
            -- Source label
            vim_item.menu = source_names[entry.source.name] or string.format("[%s]", entry.source.name)
            
            -- Truncate long items
            local max_width = 40
            if #vim_item.abbr > max_width then
              vim_item.abbr = vim_item.abbr:sub(1, max_width - 1) .. "…"
            end
            
            return vim_item
          end,
        },
        
        -- ── Sorting ───────────────────────────────────────────────
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
        
        -- ── Key Mappings ──────────────────────────────────────────
        mapping = cmp.mapping.preset.insert({
          -- Navigation
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
          ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
          
          -- Scroll documentation
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          
          -- Toggle completion
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          
          -- Confirm selection
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          }),
          ["<S-CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
          
          -- Tab / Shift-Tab for navigation and snippet expansion
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
        }),
        
        -- ── Sources ───────────────────────────────────────────────
        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 1000, max_item_count = 20 },
          { name = "luasnip", priority = 750, max_item_count = 5 },
          { name = "path", priority = 500 },
        }, {
          { name = "buffer", priority = 250, max_item_count = 5, keyword_length = 3 },
        }),
        
        -- ── Experimental ──────────────────────────────────────────
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
      })
      
      -- ── Cmdline : Completion ────────────────────────────────────
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
        formatting = {
          fields = { "abbr" },
        },
      })
      
      -- ── Cmdline / Completion ────────────────────────────────────
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
        formatting = {
          fields = { "abbr" },
        },
      })
      
      -- ── LSP Signature ───────────────────────────────────────────
      require("lsp_signature").setup({
        bind = true,
        handler_opts = {
          border = "rounded",
        },
        floating_window = true,
        floating_window_above_cur_line = true,
        hint_enable = false, -- Virtual text hint
        hint_prefix = " ",
        hi_parameter = "LspSignatureActiveParameter",
        max_height = 12,
        max_width = 80,
        wrap = true,
        fix_pos = false,
        close_timeout = 4000,
        toggle_key = "<C-k>",
        toggle_key_flip_floatwin_setting = true,
        select_signature_key = "<M-n>",
        move_cursor_key = nil,
        zindex = 200,
        transparency = nil,
        timer_interval = 200,
        extra_trigger_chars = {},
        auto_close_after = nil,
      })
    end,
  },
}

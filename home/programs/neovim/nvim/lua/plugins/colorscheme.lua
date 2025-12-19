-- ╭──────────────────────────────────────────────────────────────────────────╮
-- │                            Colorscheme                                   │
-- ╰──────────────────────────────────────────────────────────────────────────╯

return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      transparent = true,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        sidebars = "transparent",
        floats = "transparent",
      },
      sidebars = { "qf", "help", "terminal" },
      on_colors = function(colors)
        -- Slightly warmer blue accent
        colors.blue = "#7aa2f7"
        colors.cyan = "#7dcfff"
        colors.magenta = "#bb9af7"
        colors.green = "#9ece6a"
        colors.orange = "#ff9e64"
        colors.red = "#f7768e"
        colors.yellow = "#e0af68"
        -- Pitch black backgrounds
        colors.bg = "#000000"
        colors.bg_dark = "#000000"
        colors.bg_float = "#0a0a0f"
        colors.bg_popup = "#0a0a0f"
        colors.bg_sidebar = "#000000"
        colors.bg_statusline = "#0a0a0f"
        -- Softer foreground
        colors.fg = "#c0caf5"
        colors.fg_dark = "#a9b1d6"
        colors.fg_gutter = "#3b4261"
        -- Border color
        colors.border = "#3b4261"
      end,
      on_highlights = function(hl, c)
        -- ── General UI ──────────────────────────────────────────────────────
        hl.Normal = { fg = c.fg, bg = "NONE" }
        hl.NormalFloat = { fg = c.fg, bg = c.bg_float }
        hl.FloatBorder = { fg = c.blue, bg = c.bg_float }
        hl.FloatTitle = { fg = c.cyan, bg = c.bg_float, bold = true }
        hl.WinSeparator = { fg = c.border }
        hl.VertSplit = { fg = c.border }
        hl.CursorLine = { bg = "#101018" }
        hl.CursorLineNr = { fg = c.cyan, bold = true }
        hl.LineNr = { fg = c.fg_gutter }
        hl.Visual = { bg = "#283457" }
        hl.Search = { fg = c.black, bg = c.yellow }
        hl.IncSearch = { fg = c.black, bg = c.orange }
        
        -- ── Pmenu (completion menu) ─────────────────────────────────────────
        hl.Pmenu = { fg = c.fg, bg = c.bg_popup }
        hl.PmenuSel = { fg = c.cyan, bg = "#1a1b26", bold = true }
        hl.PmenuSbar = { bg = "#15161e" }
        hl.PmenuThumb = { bg = c.blue }
        
        -- ── Diagnostics ─────────────────────────────────────────────────────
        hl.DiagnosticError = { fg = c.red }
        hl.DiagnosticWarn = { fg = c.yellow }
        hl.DiagnosticInfo = { fg = c.blue }
        hl.DiagnosticHint = { fg = c.cyan }
        hl.DiagnosticVirtualTextError = { fg = c.red, bg = "#1a1018" }
        hl.DiagnosticVirtualTextWarn = { fg = c.yellow, bg = "#1a1810" }
        hl.DiagnosticVirtualTextInfo = { fg = c.blue, bg = "#101820" }
        hl.DiagnosticVirtualTextHint = { fg = c.cyan, bg = "#101a20" }
        
        -- ── Telescope ───────────────────────────────────────────────────────
        hl.TelescopeNormal = { fg = c.fg, bg = c.bg_float }
        hl.TelescopeBorder = { fg = c.blue, bg = c.bg_float }
        hl.TelescopePromptNormal = { fg = c.fg, bg = "#0f0f14" }
        hl.TelescopePromptBorder = { fg = c.cyan, bg = "#0f0f14" }
        hl.TelescopePromptTitle = { fg = c.black, bg = c.cyan, bold = true }
        hl.TelescopePreviewNormal = { fg = c.fg, bg = c.bg_float }
        hl.TelescopePreviewBorder = { fg = c.blue, bg = c.bg_float }
        hl.TelescopePreviewTitle = { fg = c.black, bg = c.blue, bold = true }
        hl.TelescopeResultsNormal = { fg = c.fg, bg = c.bg_float }
        hl.TelescopeResultsBorder = { fg = c.blue, bg = c.bg_float }
        hl.TelescopeResultsTitle = { fg = c.black, bg = c.magenta, bold = true }
        hl.TelescopeSelection = { fg = c.cyan, bg = "#1a1b26", bold = true }
        hl.TelescopeMatching = { fg = c.orange, bold = true }
        
        -- ── Git Signs ───────────────────────────────────────────────────────
        hl.GitSignsAdd = { fg = c.green }
        hl.GitSignsChange = { fg = c.blue }
        hl.GitSignsDelete = { fg = c.red }
        
        -- ── Noice & Notify ──────────────────────────────────────────────────
        hl.NoiceCmdlinePopup = { fg = c.fg, bg = c.bg_float }
        hl.NoiceCmdlinePopupBorder = { fg = c.blue, bg = c.bg_float }
        hl.NoiceCmdlineIcon = { fg = c.cyan }
        hl.NotifyBackground = { bg = c.bg_float }
        
        -- ── LSP ─────────────────────────────────────────────────────────────
        hl.LspReferenceText = { bg = "#1f2335" }
        hl.LspReferenceRead = { bg = "#1f2335" }
        hl.LspReferenceWrite = { bg = "#1f2335" }
        hl.LspSignatureActiveParameter = { fg = c.orange, italic = true, bold = true }
        hl.LspInlayHint = { fg = "#545c7e", italic = true }
        
        -- ── Cmp ─────────────────────────────────────────────────────────────
        hl.CmpItemAbbrMatch = { fg = c.cyan, bold = true }
        hl.CmpItemAbbrMatchFuzzy = { fg = c.cyan, bold = true }
        hl.CmpItemKindDefault = { fg = c.fg_dark }
        hl.CmpItemKindKeyword = { fg = c.magenta }
        hl.CmpItemKindVariable = { fg = c.blue }
        hl.CmpItemKindConstant = { fg = c.blue }
        hl.CmpItemKindReference = { fg = c.blue }
        hl.CmpItemKindValue = { fg = c.blue }
        hl.CmpItemKindFunction = { fg = c.magenta }
        hl.CmpItemKindMethod = { fg = c.magenta }
        hl.CmpItemKindConstructor = { fg = c.magenta }
        hl.CmpItemKindClass = { fg = c.yellow }
        hl.CmpItemKindInterface = { fg = c.yellow }
        hl.CmpItemKindStruct = { fg = c.yellow }
        hl.CmpItemKindEvent = { fg = c.yellow }
        hl.CmpItemKindEnum = { fg = c.yellow }
        hl.CmpItemKindUnit = { fg = c.yellow }
        hl.CmpItemKindModule = { fg = c.yellow }
        hl.CmpItemKindProperty = { fg = c.green }
        hl.CmpItemKindField = { fg = c.green }
        hl.CmpItemKindTypeParameter = { fg = c.green }
        hl.CmpItemKindEnumMember = { fg = c.cyan }
        hl.CmpItemKindOperator = { fg = c.cyan }
        hl.CmpItemKindSnippet = { fg = c.orange }
        hl.CmpItemKindText = { fg = c.fg_dark }
        hl.CmpItemKindFile = { fg = c.fg_dark }
        hl.CmpItemKindFolder = { fg = c.fg_dark }
        hl.CmpItemMenu = { fg = c.fg_gutter, italic = true }
        
        -- ── Indent & Whitespace ─────────────────────────────────────────────
        hl.IndentBlanklineChar = { fg = "#1f2335" }
        hl.IblIndent = { fg = "#1f2335" }
        hl.IblScope = { fg = c.blue }
        
        -- ── Tabs ────────────────────────────────────────────────────────────
        hl.TabLine = { fg = c.fg_gutter, bg = "NONE" }
        hl.TabLineFill = { bg = "NONE" }
        hl.TabLineSel = { fg = c.cyan, bg = "#1a1b26", bold = true }
      end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight")
    end,
  },
}

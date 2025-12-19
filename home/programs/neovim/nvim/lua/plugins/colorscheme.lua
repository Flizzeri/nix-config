-- ╭──────────────────────────────────────────────────────────────────────────╮
-- │                            Colorscheme                                   │
-- │              Gradient: magenta → purple → indigo → cyan                  │
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
        -- Gradient palette
        colors.magenta = "#bb9af7"
        colors.purple = "#9d7cd8"
        colors.blue = "#7aa2f7"    -- indigo
        colors.cyan = "#7dcfff"
        
        -- Supporting colors
        colors.red = "#f7768e"
        colors.orange = "#ff9e64"
        colors.yellow = "#e0af68"
        colors.green = "#9ece6a"
        
        -- Pitch black backgrounds
        colors.bg = "#000000"
        colors.bg_dark = "#000000"
        colors.bg_float = "#0a0a0f"
        colors.bg_popup = "#0a0a0f"
        colors.bg_sidebar = "#000000"
        colors.bg_statusline = "#0a0a0f"
        
        -- Foreground
        colors.fg = "#c0caf5"
        colors.fg_dark = "#a9b1d6"
        colors.fg_gutter = "#3b4261"
        
        -- Border using purple from gradient
        colors.border = "#9d7cd8"
      end,
      on_highlights = function(hl, c)
        -- ── General UI ──────────────────────────────────────────────────────
        hl.Normal = { fg = c.fg, bg = "NONE" }
        hl.NormalFloat = { fg = c.fg, bg = c.bg_float }
        hl.FloatBorder = { fg = c.purple, bg = c.bg_float }
        hl.FloatTitle = { fg = c.cyan, bg = c.bg_float, bold = true }
        hl.WinSeparator = { fg = c.purple }
        hl.VertSplit = { fg = c.purple }
        hl.CursorLine = { bg = "#101018" }
        hl.CursorLineNr = { fg = c.magenta, bold = true }
        hl.LineNr = { fg = c.fg_gutter }
        hl.Visual = { bg = "#2d2a45" }
        hl.Search = { fg = c.bg, bg = c.cyan }
        hl.IncSearch = { fg = c.bg, bg = c.magenta }
        
        -- ── Pmenu (completion menu) ─────────────────────────────────────────
        hl.Pmenu = { fg = c.fg, bg = c.bg_popup }
        hl.PmenuSel = { fg = c.bg, bg = c.purple, bold = true }
        hl.PmenuSbar = { bg = "#15161e" }
        hl.PmenuThumb = { bg = c.magenta }
        
        -- ── Diagnostics (gradient: red → magenta → purple → cyan) ───────────
        hl.DiagnosticError = { fg = c.red }
        hl.DiagnosticWarn = { fg = c.magenta }
        hl.DiagnosticInfo = { fg = c.blue }
        hl.DiagnosticHint = { fg = c.cyan }
        hl.DiagnosticVirtualTextError = { fg = c.red, bg = "#1a1018" }
        hl.DiagnosticVirtualTextWarn = { fg = c.magenta, bg = "#1a1020" }
        hl.DiagnosticVirtualTextInfo = { fg = c.blue, bg = "#101825" }
        hl.DiagnosticVirtualTextHint = { fg = c.cyan, bg = "#101a22" }
        
        -- ── Telescope ───────────────────────────────────────────────────────
        hl.TelescopeNormal = { fg = c.fg, bg = c.bg_float }
        hl.TelescopeBorder = { fg = c.purple, bg = c.bg_float }
        hl.TelescopePromptNormal = { fg = c.fg, bg = "#0f0f14" }
        hl.TelescopePromptBorder = { fg = c.magenta, bg = "#0f0f14" }
        hl.TelescopePromptTitle = { fg = c.bg, bg = c.magenta, bold = true }
        hl.TelescopePreviewNormal = { fg = c.fg, bg = c.bg_float }
        hl.TelescopePreviewBorder = { fg = c.blue, bg = c.bg_float }
        hl.TelescopePreviewTitle = { fg = c.bg, bg = c.blue, bold = true }
        hl.TelescopeResultsNormal = { fg = c.fg, bg = c.bg_float }
        hl.TelescopeResultsBorder = { fg = c.purple, bg = c.bg_float }
        hl.TelescopeResultsTitle = { fg = c.bg, bg = c.purple, bold = true }
        hl.TelescopeSelection = { fg = c.cyan, bg = "#1a1b26", bold = true }
        hl.TelescopeMatching = { fg = c.magenta, bold = true }
        
        -- ── Git Signs (gradient) ────────────────────────────────────────────
        hl.GitSignsAdd = { fg = c.cyan }
        hl.GitSignsChange = { fg = c.purple }
        hl.GitSignsDelete = { fg = c.red }
        
        -- ── Noice & Notify ──────────────────────────────────────────────────
        hl.NoiceCmdlinePopup = { fg = c.fg, bg = c.bg_float }
        hl.NoiceCmdlinePopupBorder = { fg = c.purple, bg = c.bg_float }
        hl.NoiceCmdlineIcon = { fg = c.magenta }
        hl.NotifyBackground = { bg = c.bg_float }
        
        -- ── LSP ─────────────────────────────────────────────────────────────
        hl.LspReferenceText = { bg = "#1f1f30" }
        hl.LspReferenceRead = { bg = "#1f1f30" }
        hl.LspReferenceWrite = { bg = "#1f1f30" }
        hl.LspSignatureActiveParameter = { fg = c.magenta, italic = true, bold = true }
        hl.LspInlayHint = { fg = "#545c7e", italic = true }
        
        -- ── Cmp (using gradient for kinds) ──────────────────────────────────
        hl.CmpItemAbbrMatch = { fg = c.magenta, bold = true }
        hl.CmpItemAbbrMatchFuzzy = { fg = c.magenta, bold = true }
        hl.CmpItemKindDefault = { fg = c.fg_dark }
        hl.CmpItemKindKeyword = { fg = c.magenta }
        hl.CmpItemKindVariable = { fg = c.blue }
        hl.CmpItemKindConstant = { fg = c.blue }
        hl.CmpItemKindReference = { fg = c.blue }
        hl.CmpItemKindValue = { fg = c.blue }
        hl.CmpItemKindFunction = { fg = c.purple }
        hl.CmpItemKindMethod = { fg = c.purple }
        hl.CmpItemKindConstructor = { fg = c.purple }
        hl.CmpItemKindClass = { fg = c.magenta }
        hl.CmpItemKindInterface = { fg = c.magenta }
        hl.CmpItemKindStruct = { fg = c.magenta }
        hl.CmpItemKindEvent = { fg = c.purple }
        hl.CmpItemKindEnum = { fg = c.magenta }
        hl.CmpItemKindUnit = { fg = c.blue }
        hl.CmpItemKindModule = { fg = c.purple }
        hl.CmpItemKindProperty = { fg = c.cyan }
        hl.CmpItemKindField = { fg = c.cyan }
        hl.CmpItemKindTypeParameter = { fg = c.blue }
        hl.CmpItemKindEnumMember = { fg = c.cyan }
        hl.CmpItemKindOperator = { fg = c.purple }
        hl.CmpItemKindSnippet = { fg = c.magenta }
        hl.CmpItemKindText = { fg = c.fg_dark }
        hl.CmpItemKindFile = { fg = c.fg_dark }
        hl.CmpItemKindFolder = { fg = c.fg_dark }
        hl.CmpItemMenu = { fg = c.fg_gutter, italic = true }
        
        -- ── Indent & Whitespace ─────────────────────────────────────────────
        hl.IndentBlanklineChar = { fg = "#1f1f30" }
        hl.IblIndent = { fg = "#1f1f30" }
        hl.IblScope = { fg = c.purple }
        
        -- ── Tabs ────────────────────────────────────────────────────────────
        hl.TabLine = { fg = c.fg_gutter, bg = "NONE" }
        hl.TabLineFill = { bg = "NONE" }
        hl.TabLineSel = { fg = c.bg, bg = c.purple, bold = true }
      end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight")
    end,
  },
}

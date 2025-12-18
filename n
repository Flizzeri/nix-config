-- ╭──────────────────────────────────────────────────────────╮
-- │              OBSIDIAN COLORSCHEME                        │
-- │         Pitch Black • Refined Accents • Borders          │
-- ╰──────────────────────────────────────────────────────────╯

local M = {}

-- ── Color Palette ───────────────────────────────────────────
M.colors = {
  -- Base
  bg = "#000000",           -- Pitch black
  bg_alt = "#0a0a0a",       -- Slightly lighter for contrast
  bg_highlight = "#111111", -- Selection/current line
  bg_visual = "#1a1a2e",    -- Visual selection
  bg_popup = "#0d0d0d",     -- Popups and floats
  
  -- Borders & UI
  border = "#2a2a3a",       -- Subtle border
  border_active = "#4a4a5a",-- Active border
  gutter = "#1a1a1a",       -- Line number background
  
  -- Foreground
  fg = "#c8c8d0",           -- Primary text
  fg_dim = "#6a6a7a",       -- Dimmed text
  fg_dark = "#4a4a5a",      -- Comments, line numbers
  fg_bright = "#e8e8f0",    -- Bright text
  
  -- Accents (muted, cohesive palette)
  blue = "#7aa2f7",         -- Keywords, functions
  cyan = "#7dcfff",         -- Types, constants
  teal = "#73daca",         -- Strings
  green = "#9ece6a",        -- Success, added
  yellow = "#e0af68",       -- Warnings, changed
  orange = "#ff9e64",       -- Numbers, parameters
  red = "#f7768e",          -- Errors, deleted
  magenta = "#bb9af7",      -- Special, operators
  purple = "#9d7cd8",       -- Preprocessor
  
  -- Git
  git_add = "#449dab",
  git_change = "#6183bb",
  git_delete = "#914c54",
  
  -- Diagnostic
  error = "#db4b4b",
  warn = "#e0af68",
  info = "#0db9d7",
  hint = "#1abc9c",
}

function M.setup()
  local c = M.colors
  
  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end
  
  vim.g.colors_name = "obsidian"
  vim.o.termguicolors = true
  
  local hl = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end
  
  -- ── Editor ──────────────────────────────────────────────────
  hl("Normal", { fg = c.fg, bg = c.bg })
  hl("NormalNC", { fg = c.fg, bg = c.bg })
  hl("NormalFloat", { fg = c.fg, bg = c.bg_popup })
  hl("FloatBorder", { fg = c.border, bg = c.bg_popup })
  hl("FloatTitle", { fg = c.cyan, bg = c.bg_popup, bold = true })
  hl("Cursor", { fg = c.bg, bg = c.fg })
  hl("CursorLine", { bg = c.bg_highlight })
  hl("CursorLineNr", { fg = c.fg_bright, bold = true })
  hl("LineNr", { fg = c.fg_dark })
  hl("SignColumn", { bg = c.bg })
  hl("VertSplit", { fg = c.border })
  hl("WinSeparator", { fg = c.border })
  hl("ColorColumn", { bg = c.bg_alt })
  hl("Folded", { fg = c.fg_dim, bg = c.bg_alt })
  hl("FoldColumn", { fg = c.fg_dark, bg = c.bg })
  hl("MatchParen", { fg = c.yellow, bold = true, underline = true })
  hl("Visual", { bg = c.bg_visual })
  hl("VisualNOS", { bg = c.bg_visual })
  hl("Search", { fg = c.bg, bg = c.yellow })
  hl("IncSearch", { fg = c.bg, bg = c.orange })
  hl("CurSearch", { fg = c.bg, bg = c.orange })
  hl("Substitute", { fg = c.bg, bg = c.red })
  hl("NonText", { fg = c.fg_dark })
  hl("SpecialKey", { fg = c.fg_dark })
  hl("Whitespace", { fg = c.border })
  hl("EndOfBuffer", { fg = c.bg })
  hl("Directory", { fg = c.blue })
  hl("Title", { fg = c.cyan, bold = true })
  hl("Question", { fg = c.green })
  hl("MoreMsg", { fg = c.green })
  hl("ModeMsg", { fg = c.fg_dim })
  hl("ErrorMsg", { fg = c.error })
  hl("WarningMsg", { fg = c.warn })
  
  -- ── Popup Menu ──────────────────────────────────────────────
  hl("Pmenu", { fg = c.fg, bg = c.bg_popup })
  hl("PmenuSel", { fg = c.fg_bright, bg = c.bg_visual })
  hl("PmenuSbar", { bg = c.bg_alt })
  hl("PmenuThumb", { bg = c.border_active })
  hl("PmenuKind", { fg = c.cyan, bg = c.bg_popup })
  hl("PmenuKindSel", { fg = c.cyan, bg = c.bg_visual })
  hl("PmenuExtra", { fg = c.fg_dim, bg = c.bg_popup })
  hl("PmenuExtraSel", { fg = c.fg_dim, bg = c.bg_visual })
  
  -- ── Tabs ────────────────────────────────────────────────────
  hl("TabLine", { fg = c.fg_dim, bg = c.bg_alt })
  hl("TabLineSel", { fg = c.fg_bright, bg = c.bg })
  hl("TabLineFill", { bg = c.bg_alt })
  
  -- ── Statusline ──────────────────────────────────────────────
  hl("StatusLine", { fg = c.fg, bg = c.bg_alt })
  hl("StatusLineNC", { fg = c.fg_dark, bg = c.bg_alt })
  hl("WildMenu", { fg = c.bg, bg = c.blue })
  
  -- ── Diff ────────────────────────────────────────────────────
  hl("DiffAdd", { bg = "#1a2b1a" })
  hl("DiffChange", { bg = "#1a1a2b" })
  hl("DiffDelete", { bg = "#2b1a1a" })
  hl("DiffText", { bg = "#2a2a4a" })
  hl("diffAdded", { fg = c.git_add })
  hl("diffRemoved", { fg = c.git_delete })
  hl("diffChanged", { fg = c.git_change })
  
  -- ── Spelling ────────────────────────────────────────────────
  hl("SpellBad", { sp = c.error, undercurl = true })
  hl("SpellCap", { sp = c.warn, undercurl = true })
  hl("SpellLocal", { sp = c.info, undercurl = true })
  hl("SpellRare", { sp = c.hint, undercurl = true })
  
  -- ── Syntax ──────────────────────────────────────────────────
  hl("Comment", { fg = c.fg_dark, italic = true })
  hl("Constant", { fg = c.orange })
  hl("String", { fg = c.teal })
  hl("Character", { fg = c.teal })
  hl("Number", { fg = c.orange })
  hl("Boolean", { fg = c.orange })
  hl("Float", { fg = c.orange })
  hl("Identifier", { fg = c.fg })
  hl("Function", { fg = c.blue })
  hl("Statement", { fg = c.magenta })
  hl("Conditional", { fg = c.magenta })
  hl("Repeat", { fg = c.magenta })
  hl("Label", { fg = c.magenta })
  hl("Operator", { fg = c.fg_bright })
  hl("Keyword", { fg = c.magenta })
  hl("Exception", { fg = c.magenta })
  hl("PreProc", { fg = c.purple })
  hl("Include", { fg = c.purple })
  hl("Define", { fg = c.purple })
  hl("Macro", { fg = c.purple })
  hl("PreCondit", { fg = c.purple })
  hl("Type", { fg = c.cyan })
  hl("StorageClass", { fg = c.cyan })
  hl("Structure", { fg = c.cyan })
  hl("Typedef", { fg = c.cyan })
  hl("Special", { fg = c.yellow })
  hl("SpecialChar", { fg = c.yellow })
  hl("Tag", { fg = c.blue })
  hl("Delimiter", { fg = c.fg_dim })
  hl("SpecialComment", { fg = c.fg_dim })
  hl("Debug", { fg = c.orange })
  hl("Underlined", { underline = true })
  hl("Ignore", { fg = c.fg_dark })
  hl("Error", { fg = c.error })
  hl("Todo", { fg = c.bg, bg = c.yellow, bold = true })
  
  -- ── Treesitter ──────────────────────────────────────────────
  hl("@variable", { fg = c.fg })
  hl("@variable.builtin", { fg = c.red })
  hl("@variable.parameter", { fg = c.orange })
  hl("@variable.member", { fg = c.fg })
  hl("@constant", { fg = c.orange })
  hl("@constant.builtin", { fg = c.orange })
  hl("@constant.macro", { fg = c.purple })
  hl("@module", { fg = c.cyan })
  hl("@module.builtin", { fg = c.cyan })
  hl("@label", { fg = c.magenta })
  hl("@string", { fg = c.teal })
  hl("@string.documentation", { fg = c.teal })
  hl("@string.regexp", { fg = c.yellow })
  hl("@string.escape", { fg = c.yellow })
  hl("@string.special", { fg = c.yellow })
  hl("@string.special.symbol", { fg = c.cyan })
  hl("@string.special.url", { fg = c.blue, underline = true })
  hl("@character", { fg = c.teal })
  hl("@character.special", { fg = c.yellow })
  hl("@boolean", { fg = c.orange })
  hl("@number", { fg = c.orange })
  hl("@number.float", { fg = c.orange })
  hl("@type", { fg = c.cyan })
  hl("@type.builtin", { fg = c.cyan })
  hl("@type.qualifier", { fg = c.magenta })
  hl("@type.definition", { fg = c.cyan })
  hl("@attribute", { fg = c.purple })
  hl("@attribute.builtin", { fg = c.purple })
  hl("@property", { fg = c.fg })
  hl("@function", { fg = c.blue })
  hl("@function.builtin", { fg = c.blue })
  hl("@function.call", { fg = c.blue })
  hl("@function.macro", { fg = c.purple })
  hl("@function.method", { fg = c.blue })
  hl("@function.method.call", { fg = c.blue })
  hl("@constructor", { fg = c.cyan })
  hl("@operator", { fg = c.fg_bright })
  hl("@keyword", { fg = c.magenta })
  hl("@keyword.coroutine", { fg = c.magenta })
  hl("@keyword.function", { fg = c.magenta })
  hl("@keyword.operator", { fg = c.magenta })
  hl("@keyword.import", { fg = c.purple })
  hl("@keyword.type", { fg = c.magenta })
  hl("@keyword.modifier", { fg = c.magenta })
  hl("@keyword.repeat", { fg = c.magenta })
  hl("@keyword.return", { fg = c.magenta })
  hl("@keyword.debug", { fg = c.orange })
  hl("@keyword.exception", { fg = c.magenta })
  hl("@keyword.conditional", { fg = c.magenta })
  hl("@keyword.conditional.ternary", { fg = c.magenta })
  hl("@keyword.directive", { fg = c.purple })
  hl("@keyword.directive.define", { fg = c.purple })
  hl("@punctuation.delimiter", { fg = c.fg_dim })
  hl("@punctuation.bracket", { fg = c.fg_dim })
  hl("@punctuation.special", { fg = c.fg_dim })
  hl("@comment", { fg = c.fg_dark, italic = true })
  hl("@comment.documentation", { fg = c.fg_dark, italic = true })
  hl("@comment.error", { fg = c.error })
  hl("@comment.warning", { fg = c.warn })
  hl("@comment.todo", { fg = c.bg, bg = c.yellow })
  hl("@comment.note", { fg = c.bg, bg = c.info })
  hl("@markup.strong", { bold = true })
  hl("@markup.italic", { italic = true })
  hl("@markup.strikethrough", { strikethrough = true })
  hl("@markup.underline", { underline = true })
  hl("@markup.heading", { fg = c.cyan, bold = true })
  hl("@markup.quote", { fg = c.fg_dim, italic = true })
  hl("@markup.math", { fg = c.cyan })
  hl("@markup.link", { fg = c.blue, underline = true })
  hl("@markup.link.label", { fg = c.blue })
  hl("@markup.link.url", { fg = c.blue, underline = true })
  hl("@markup.raw", { fg = c.teal })
  hl("@markup.raw.block", { fg = c.teal })
  hl("@markup.list", { fg = c.magenta })
  hl("@markup.list.checked", { fg = c.green })
  hl("@markup.list.unchecked", { fg = c.fg_dim })
  hl("@diff.plus", { fg = c.git_add })
  hl("@diff.minus", { fg = c.git_delete })
  hl("@diff.delta", { fg = c.git_change })
  hl("@tag", { fg = c.blue })
  hl("@tag.attribute", { fg = c.cyan })
  hl("@tag.delimiter", { fg = c.fg_dim })
  
  -- ── LSP ─────────────────────────────────────────────────────
  hl("LspReferenceText", { bg = c.bg_highlight })
  hl("LspReferenceRead", { bg = c.bg_highlight })
  hl("LspReferenceWrite", { bg = c.bg_highlight })
  hl("LspSignatureActiveParameter", { fg = c.orange, bold = true })
  hl("LspCodeLens", { fg = c.fg_dark })
  hl("LspCodeLensSeparator", { fg = c.border })
  hl("LspInlayHint", { fg = c.fg_dark, bg = c.bg_alt, italic = true })
  
  -- ── Diagnostics ─────────────────────────────────────────────
  hl("DiagnosticError", { fg = c.error })
  hl("DiagnosticWarn", { fg = c.warn })
  hl("DiagnosticInfo", { fg = c.info })
  hl("DiagnosticHint", { fg = c.hint })
  hl("DiagnosticOk", { fg = c.green })
  hl("DiagnosticVirtualTextError", { fg = c.error, bg = "#1a0a0a" })
  hl("DiagnosticVirtualTextWarn", { fg = c.warn, bg = "#1a1a0a" })
  hl("DiagnosticVirtualTextInfo", { fg = c.info, bg = "#0a1a1a" })
  hl("DiagnosticVirtualTextHint", { fg = c.hint, bg = "#0a1a0a" })
  hl("DiagnosticUnderlineError", { sp = c.error, undercurl = true })
  hl("DiagnosticUnderlineWarn", { sp = c.warn, undercurl = true })
  hl("DiagnosticUnderlineInfo", { sp = c.info, undercurl = true })
  hl("DiagnosticUnderlineHint", { sp = c.hint, undercurl = true })
  hl("DiagnosticFloatingError", { fg = c.error })
  hl("DiagnosticFloatingWarn", { fg = c.warn })
  hl("DiagnosticFloatingInfo", { fg = c.info })
  hl("DiagnosticFloatingHint", { fg = c.hint })
  hl("DiagnosticSignError", { fg = c.error })
  hl("DiagnosticSignWarn", { fg = c.warn })
  hl("DiagnosticSignInfo", { fg = c.info })
  hl("DiagnosticSignHint", { fg = c.hint })
  
  -- ── Completion (nvim-cmp) ───────────────────────────────────
  hl("CmpItemAbbr", { fg = c.fg })
  hl("CmpItemAbbrDeprecated", { fg = c.fg_dark, strikethrough = true })
  hl("CmpItemAbbrMatch", { fg = c.blue, bold = true })
  hl("CmpItemAbbrMatchFuzzy", { fg = c.blue, bold = true })
  hl("CmpItemKind", { fg = c.cyan })
  hl("CmpItemMenu", { fg = c.fg_dim })
  hl("CmpItemKindDefault", { fg = c.fg_dim })
  hl("CmpItemKindKeyword", { fg = c.magenta })
  hl("CmpItemKindVariable", { fg = c.fg })
  hl("CmpItemKindConstant", { fg = c.orange })
  hl("CmpItemKindReference", { fg = c.fg })
  hl("CmpItemKindValue", { fg = c.orange })
  hl("CmpItemKindFunction", { fg = c.blue })
  hl("CmpItemKindMethod", { fg = c.blue })
  hl("CmpItemKindConstructor", { fg = c.cyan })
  hl("CmpItemKindClass", { fg = c.cyan })
  hl("CmpItemKindInterface", { fg = c.cyan })
  hl("CmpItemKindStruct", { fg = c.cyan })
  hl("CmpItemKindEvent", { fg = c.yellow })
  hl("CmpItemKindEnum", { fg = c.cyan })
  hl("CmpItemKindUnit", { fg = c.orange })
  hl("CmpItemKindModule", { fg = c.cyan })
  hl("CmpItemKindProperty", { fg = c.fg })
  hl("CmpItemKindField", { fg = c.fg })
  hl("CmpItemKindTypeParameter", { fg = c.cyan })
  hl("CmpItemKindEnumMember", { fg = c.cyan })
  hl("CmpItemKindOperator", { fg = c.fg_bright })
  hl("CmpItemKindSnippet", { fg = c.yellow })
  hl("CmpItemKindText", { fg = c.fg })
  hl("CmpItemKindFile", { fg = c.blue })
  hl("CmpItemKindFolder", { fg = c.blue })
  hl("CmpItemKindColor", { fg = c.magenta })
  hl("CmpItemKindCopilot", { fg = c.teal })
  
  -- CMP Ghost Text
  hl("CmpGhostText", { fg = c.fg_dark, italic = true })
  
  -- CMP Documentation Window
  hl("CmpDocumentation", { fg = c.fg, bg = c.bg_popup })
  hl("CmpDocumentationBorder", { fg = c.border, bg = c.bg_popup })
  
  -- ── Telescope ───────────────────────────────────────────────
  hl("TelescopeNormal", { fg = c.fg, bg = c.bg_popup })
  hl("TelescopeBorder", { fg = c.border, bg = c.bg_popup })
  hl("TelescopeTitle", { fg = c.cyan, bold = true })
  hl("TelescopePromptNormal", { fg = c.fg, bg = c.bg_popup })
  hl("TelescopePromptBorder", { fg = c.border, bg = c.bg_popup })
  hl("TelescopePromptTitle", { fg = c.bg, bg = c.blue, bold = true })
  hl("TelescopePromptPrefix", { fg = c.blue })
  hl("TelescopePromptCounter", { fg = c.fg_dim })
  hl("TelescopeResultsNormal", { fg = c.fg, bg = c.bg_popup })
  hl("TelescopeResultsBorder", { fg = c.border, bg = c.bg_popup })
  hl("TelescopeResultsTitle", { fg = c.cyan, bold = true })
  hl("TelescopePreviewNormal", { fg = c.fg, bg = c.bg_popup })
  hl("TelescopePreviewBorder", { fg = c.border, bg = c.bg_popup })
  hl("TelescopePreviewTitle", { fg = c.cyan, bold = true })
  hl("TelescopeMatching", { fg = c.blue, bold = true })
  hl("TelescopeSelection", { fg = c.fg_bright, bg = c.bg_visual })
  hl("TelescopeSelectionCaret", { fg = c.cyan, bg = c.bg_visual })
  hl("TelescopeMultiIcon", { fg = c.cyan })
  hl("TelescopeMultiSelection", { bg = c.bg_visual })
  
  -- ── Gitsigns ────────────────────────────────────────────────
  hl("GitSignsAdd", { fg = c.git_add })
  hl("GitSignsChange", { fg = c.git_change })
  hl("GitSignsDelete", { fg = c.git_delete })
  hl("GitSignsAddNr", { fg = c.git_add })
  hl("GitSignsChangeNr", { fg = c.git_change })
  hl("GitSignsDeleteNr", { fg = c.git_delete })
  hl("GitSignsAddLn", { bg = "#1a2b1a" })
  hl("GitSignsChangeLn", { bg = "#1a1a2b" })
  hl("GitSignsDeleteLn", { bg = "#2b1a1a" })
  hl("GitSignsAddInline", { bg = "#1a3b1a" })
  hl("GitSignsChangeInline", { bg = "#1a1a3b" })
  hl("GitSignsDeleteInline", { bg = "#3b1a1a" })
  hl("GitSignsCurrentLineBlame", { fg = c.fg_dark, italic = true })
  
  -- ── Noice ───────────────────────────────────────────────────
  hl("NoiceCmdline", { fg = c.fg, bg = c.bg_popup })
  hl("NoiceCmdlinePopup", { fg = c.fg, bg = c.bg_popup })
  hl("NoiceCmdlinePopupBorder", { fg = c.border, bg = c.bg_popup })
  hl("NoiceCmdlinePopupTitle", { fg = c.cyan, bold = true })
  hl("NoiceCmdlineIcon", { fg = c.blue })
  hl("NoiceCmdlineIconSearch", { fg = c.yellow })
  hl("NoiceConfirm", { fg = c.fg, bg = c.bg_popup })
  hl("NoiceConfirmBorder", { fg = c.border, bg = c.bg_popup })
  hl("NoiceFormatConfirm", { fg = c.fg, bg = c.bg_popup })
  hl("NoiceFormatConfirmDefault", { fg = c.cyan, bold = true })
  hl("NoiceMini", { fg = c.fg, bg = c.bg_popup })
  hl("NoicePopup", { fg = c.fg, bg = c.bg_popup })
  hl("NoicePopupBorder", { fg = c.border, bg = c.bg_popup })
  hl("NoicePopupmenu", { fg = c.fg, bg = c.bg_popup })
  hl("NoicePopupmenuBorder", { fg = c.border, bg = c.bg_popup })
  hl("NoicePopupmenuMatch", { fg = c.blue, bold = true })
  hl("NoicePopupmenuSelected", { bg = c.bg_visual })
  hl("NoiceScrollbar", { bg = c.bg_alt })
  hl("NoiceScrollbarThumb", { bg = c.border_active })
  hl("NoiceSplit", { fg = c.fg, bg = c.bg_popup })
  hl("NoiceSplitBorder", { fg = c.border, bg = c.bg_popup })
  hl("NoiceVirtualText", { fg = c.cyan })
  hl("NoiceLspProgressTitle", { fg = c.fg })
  hl("NoiceLspProgressClient", { fg = c.blue })
  hl("NoiceLspProgressSpinner", { fg = c.cyan })
  hl("NoiceFormatProgressDone", { fg = c.bg, bg = c.blue })
  hl("NoiceFormatProgressTodo", { fg = c.fg_dim, bg = c.bg_alt })
  
  -- ── Lualine (custom groups) ─────────────────────────────────
  hl("LualineNormalA", { fg = c.bg, bg = c.blue, bold = true })
  hl("LualineNormalB", { fg = c.fg, bg = c.bg_highlight })
  hl("LualineNormalC", { fg = c.fg_dim, bg = c.bg_alt })
  hl("LualineInsertA", { fg = c.bg, bg = c.teal, bold = true })
  hl("LualineVisualA", { fg = c.bg, bg = c.magenta, bold = true })
  hl("LualineReplaceA", { fg = c.bg, bg = c.red, bold = true })
  hl("LualineCommandA", { fg = c.bg, bg = c.yellow, bold = true })
  hl("LualineTerminalA", { fg = c.bg, bg = c.green, bold = true })
  
  -- ── Notify ──────────────────────────────────────────────────
  hl("NotifyERRORBorder", { fg = c.error })
  hl("NotifyWARNBorder", { fg = c.warn })
  hl("NotifyINFOBorder", { fg = c.info })
  hl("NotifyDEBUGBorder", { fg = c.fg_dim })
  hl("NotifyTRACEBorder", { fg = c.purple })
  hl("NotifyERRORIcon", { fg = c.error })
  hl("NotifyWARNIcon", { fg = c.warn })
  hl("NotifyINFOIcon", { fg = c.info })
  hl("NotifyDEBUGIcon", { fg = c.fg_dim })
  hl("NotifyTRACEIcon", { fg = c.purple })
  hl("NotifyERRORTitle", { fg = c.error })
  hl("NotifyWARNTitle", { fg = c.warn })
  hl("NotifyINFOTitle", { fg = c.info })
  hl("NotifyDEBUGTitle", { fg = c.fg_dim })
  hl("NotifyTRACETitle", { fg = c.purple })
  hl("NotifyERRORBody", { fg = c.fg })
  hl("NotifyWARNBody", { fg = c.fg })
  hl("NotifyINFOBody", { fg = c.fg })
  hl("NotifyDEBUGBody", { fg = c.fg })
  hl("NotifyTRACEBody", { fg = c.fg })
  hl("NotifyBackground", { bg = c.bg_popup })
  
  -- ── Which-Key ───────────────────────────────────────────────
  hl("WhichKey", { fg = c.cyan })
  hl("WhichKeyGroup", { fg = c.blue })
  hl("WhichKeyDesc", { fg = c.fg })
  hl("WhichKeySeperator", { fg = c.fg_dark })
  hl("WhichKeySeparator", { fg = c.fg_dark })
  hl("WhichKeyFloat", { bg = c.bg_popup })
  hl("WhichKeyBorder", { fg = c.border, bg = c.bg_popup })
  hl("WhichKeyValue", { fg = c.fg_dim })
  
  -- ── Lazy ────────────────────────────────────────────────────
  hl("LazyNormal", { fg = c.fg, bg = c.bg_popup })
  hl("LazyButton", { fg = c.fg, bg = c.bg_alt })
  hl("LazyButtonActive", { fg = c.bg, bg = c.blue, bold = true })
  hl("LazyH1", { fg = c.bg, bg = c.blue, bold = true })
  hl("LazyH2", { fg = c.cyan, bold = true })
  hl("LazySpecial", { fg = c.cyan })
  hl("LazyProgressDone", { fg = c.blue })
  hl("LazyProgressTodo", { fg = c.fg_dark })
  
  -- ── Indent Guides (if used) ─────────────────────────────────
  hl("IndentBlanklineChar", { fg = c.border })
  hl("IndentBlanklineContextChar", { fg = c.border_active })
  hl("IblIndent", { fg = c.border })
  hl("IblScope", { fg = c.border_active })
  
  -- ── Mini (if used) ──────────────────────────────────────────
  hl("MiniIndentscopeSymbol", { fg = c.border_active })
  
  -- ── Semantic Tokens ─────────────────────────────────────────
  hl("@lsp.type.class", { link = "Type" })
  hl("@lsp.type.comment", { link = "Comment" })
  hl("@lsp.type.decorator", { link = "@attribute" })
  hl("@lsp.type.enum", { link = "Type" })
  hl("@lsp.type.enumMember", { link = "Constant" })
  hl("@lsp.type.function", { link = "Function" })
  hl("@lsp.type.interface", { link = "Type" })
  hl("@lsp.type.keyword", { link = "Keyword" })
  hl("@lsp.type.macro", { link = "Macro" })
  hl("@lsp.type.method", { link = "Function" })
  hl("@lsp.type.namespace", { link = "@module" })
  hl("@lsp.type.number", { link = "Number" })
  hl("@lsp.type.operator", { link = "Operator" })
  hl("@lsp.type.parameter", { link = "@variable.parameter" })
  hl("@lsp.type.property", { link = "@property" })
  hl("@lsp.type.string", { link = "String" })
  hl("@lsp.type.struct", { link = "Type" })
  hl("@lsp.type.type", { link = "Type" })
  hl("@lsp.type.typeParameter", { link = "Type" })
  hl("@lsp.type.variable", { link = "@variable" })
  hl("@lsp.typemod.function.defaultLibrary", { link = "Function" })
  hl("@lsp.typemod.variable.defaultLibrary", { link = "@variable.builtin" })
  hl("@lsp.typemod.variable.readonly", { link = "Constant" })
  hl("@lsp.typemod.string.static", { link = "String" })
  hl("@lsp.typemod.keyword.documentation", { link = "Special" })
  
  -- ── Treesitter Context ──────────────────────────────────────
  hl("TreesitterContext", { bg = c.bg_alt })
  hl("TreesitterContextLineNumber", { fg = c.fg_dark, bg = c.bg_alt })
  hl("TreesitterContextSeparator", { fg = c.border })
  hl("TreesitterContextBottom", { sp = c.border, underline = true })
  
  -- ── Navic / Winbar ──────────────────────────────────────────
  hl("NavicText", { fg = c.fg })
  hl("NavicSeparator", { fg = c.fg_dark })
  hl("NavicIconsFile", { fg = c.blue })
  hl("NavicIconsModule", { fg = c.cyan })
  hl("NavicIconsNamespace", { fg = c.cyan })
  hl("NavicIconsPackage", { fg = c.cyan })
  hl("NavicIconsClass", { fg = c.cyan })
  hl("NavicIconsMethod", { fg = c.blue })
  hl("NavicIconsProperty", { fg = c.fg })
  hl("NavicIconsField", { fg = c.fg })
  hl("NavicIconsConstructor", { fg = c.cyan })
  hl("NavicIconsEnum", { fg = c.cyan })
  hl("NavicIconsInterface", { fg = c.cyan })
  hl("NavicIconsFunction", { fg = c.blue })
  hl("NavicIconsVariable", { fg = c.fg })
  hl("NavicIconsConstant", { fg = c.orange })
  hl("NavicIconsString", { fg = c.teal })
  hl("NavicIconsNumber", { fg = c.orange })
  hl("NavicIconsBoolean", { fg = c.orange })
  hl("NavicIconsArray", { fg = c.cyan })
  hl("NavicIconsObject", { fg = c.cyan })
  hl("NavicIconsKey", { fg = c.magenta })
  hl("NavicIconsNull", { fg = c.orange })
  hl("NavicIconsEnumMember", { fg = c.cyan })
  hl("NavicIconsStruct", { fg = c.cyan })
  hl("NavicIconsEvent", { fg = c.yellow })
  hl("NavicIconsOperator", { fg = c.fg_bright })
  hl("NavicIconsTypeParameter", { fg = c.cyan })
  
  -- ── Window separators for zellij consistency ────────────────
  hl("WinSeparator", { fg = c.border, bg = c.bg })
  
  return c
end

return M

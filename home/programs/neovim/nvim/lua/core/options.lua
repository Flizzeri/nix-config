-- ╭──────────────────────────────────────────────────────────╮
-- │                     CORE OPTIONS                         │
-- ╰──────────────────────────────────────────────────────────╯

local opt = vim.opt

-- ── Appearance ──────────────────────────────────────────────
opt.termguicolors = true
opt.background = "dark"
opt.pumblend = 10           -- Popup menu transparency
opt.winblend = 10           -- Floating window transparency
opt.pumheight = 12          -- Max popup menu height
opt.cmdheight = 0           -- Hide command line when not in use
opt.showmode = false        -- Mode shown in lualine
opt.signcolumn = "yes:1"    -- Always show sign column
opt.cursorline = true       -- Highlight current line
opt.number = true           -- Line numbers
opt.relativenumber = true   -- Relative line numbers
opt.numberwidth = 3         -- Gutter width
opt.laststatus = 3          -- Global statusline
opt.fillchars = {
  eob = " ",                -- Hide ~ on empty lines
  fold = " ",
  foldopen = "",
  foldclose = "",
  foldsep = " ",
  diff = "╱",
  vert = "│",
  horiz = "─",
  horizup = "┴",
  horizdown = "┬",
  vertleft = "┤",
  vertright = "├",
  verthoriz = "┼",
}
opt.list = true
opt.listchars = {
  tab = "  ",
  trail = "·",
  extends = "›",
  precedes = "‹",
  nbsp = "␣",
}

-- ── Behavior ────────────────────────────────────────────────
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.virtualedit = "block"
opt.confirm = true
opt.updatetime = 200
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.writebackup = false
opt.swapfile = false

-- ── Search ──────────────────────────────────────────────────
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"

-- ── Indentation ─────────────────────────────────────────────
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true
opt.shiftround = true

-- ── Splits & Windows ────────────────────────────────────────
opt.splitbelow = true
opt.splitright = true
opt.splitkeep = "screen"
opt.equalalways = false

-- ── Wrapping ────────────────────────────────────────────────
opt.wrap = false
opt.linebreak = true
opt.breakindent = true
opt.showbreak = "↪ "

-- ── Completion ──────────────────────────────────────────────
opt.completeopt = { "menu", "menuone", "noselect" }
opt.shortmess:append({ W = true, I = true, c = true, C = true })

-- ── Folding ─────────────────────────────────────────────────
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldtext = ""

-- ── Scrolling ───────────────────────────────────────────────
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.smoothscroll = true

-- ── Session ─────────────────────────────────────────────────
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }

-- ── Spell ───────────────────────────────────────────────────
opt.spelllang = { "en" }
opt.spelloptions:append("camel")

-- ── Disable providers ───────────────────────────────────────
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

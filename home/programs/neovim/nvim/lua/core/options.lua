-- ╭──────────────────────────────────────────────────────────────────────────╮
-- │                               Options                                    │
-- ╰──────────────────────────────────────────────────────────────────────────╯

local opt = vim.opt
local g = vim.g

-- Leader keys (must be set before lazy)
g.mapleader = " "
g.maplocalleader = "\\"

-- ── UI ──────────────────────────────────────────────────────────────────────
opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.showmode = false          -- Shown in lualine
opt.cmdheight = 0             -- Hide cmdline when not in use
opt.laststatus = 3            -- Global statusline
opt.pumheight = 12            -- Popup menu height
opt.pumblend = 10             -- Popup menu transparency
opt.winblend = 10             -- Floating window transparency
opt.fillchars = {
  eob = " ",                  -- Hide ~ on empty lines
  fold = " ",
  foldopen = " ",
  foldclose = " ",
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

-- ── Editing ─────────────────────────────────────────────────────────────────
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true
opt.wrap = false
opt.linebreak = true
opt.breakindent = true
opt.virtualedit = "block"     -- Block selection past EOL

-- ── Search ──────────────────────────────────────────────────────────────────
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- ── Splits ──────────────────────────────────────────────────────────────────
opt.splitbelow = true
opt.splitright = true
opt.splitkeep = "screen"

-- ── Completion ──────────────────────────────────────────────────────────────
opt.completeopt = { "menu", "menuone", "noselect" }
opt.shortmess:append("c")     -- Don't show completion messages

-- ── Files & Backup ──────────────────────────────────────────────────────────
opt.undofile = true
opt.undolevels = 10000
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.autoread = true

-- ── Performance ─────────────────────────────────────────────────────────────
opt.updatetime = 200
opt.timeoutlen = 300
opt.redrawtime = 1500
opt.lazyredraw = false

-- ── Misc ────────────────────────────────────────────────────────────────────
opt.clipboard = "unnamedplus"
opt.mouse = "a"
opt.conceallevel = 2
opt.confirm = true
opt.spelllang = { "en" }

-- Disable some builtin providers
g.loaded_python3_provider = 0
g.loaded_ruby_provider = 0
g.loaded_perl_provider = 0
g.loaded_node_provider = 0

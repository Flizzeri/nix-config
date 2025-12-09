-- Core options
local opt = vim.opt

-- UI
opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Indentation
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Performance
opt.updatetime = 200
opt.timeoutlen = 400

-- Persistence
opt.undofile = true
opt.swapfile = false
opt.backup = false

-- Misc
opt.clipboard = "unnamedplus"
opt.completeopt = "menu,menuone,noselect"
opt.mouse = "a"

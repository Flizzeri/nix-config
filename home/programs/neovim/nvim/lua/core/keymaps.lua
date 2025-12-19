-- ╭──────────────────────────────────────────────────────────────────────────╮
-- │                               Keymaps                                    │
-- ╰──────────────────────────────────────────────────────────────────────────╯

local map = vim.keymap.set
local opts = { silent = true }

-- ── General ─────────────────────────────────────────────────────────────────
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
map("n", "<leader>Q", "<cmd>qa!<CR>", { desc = "Force quit all" })

-- Better escape
map("i", "jk", "<Esc>", opts)
map("i", "kj", "<Esc>", opts)

-- ── Navigation ──────────────────────────────────────────────────────────────
-- Move between windows
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Resize windows
map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase height" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase width" })

-- Navigate buffers
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })
map("n", "<leader>bD", "<cmd>bdelete!<CR>", { desc = "Force delete buffer" })

-- ── Editing ─────────────────────────────────────────────────────────────────
-- Move lines
map("n", "<A-j>", "<cmd>m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<CR>==", { desc = "Move line up" })
map("i", "<A-j>", "<Esc><cmd>m .+1<CR>==gi", { desc = "Move line down" })
map("i", "<A-k>", "<Esc><cmd>m .-2<CR>==gi", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Better indenting
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Duplicate line
map("n", "<leader>d", "<cmd>t.<CR>", { desc = "Duplicate line" })
map("v", "<leader>d", "y'>p", { desc = "Duplicate selection" })

-- Join lines without moving cursor
map("n", "J", "mzJ`z", opts)

-- Keep cursor centered
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)

-- Don't yank on paste in visual mode
map("v", "p", '"_dP', opts)

-- ── Diagnostics ─────────────────────────────────────────────────────────────
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic" })
map("n", "<leader>xl", vim.diagnostic.setloclist, { desc = "Diagnostics to loclist" })

-- ── Quickfix ────────────────────────────────────────────────────────────────
map("n", "[q", "<cmd>cprev<CR>zz", { desc = "Previous quickfix" })
map("n", "]q", "<cmd>cnext<CR>zz", { desc = "Next quickfix" })
map("n", "<leader>xq", "<cmd>copen<CR>", { desc = "Open quickfix" })

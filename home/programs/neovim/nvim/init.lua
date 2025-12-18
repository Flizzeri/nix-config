-- ╭──────────────────────────────────────────────────────────╮
-- │                    NEOVIM CONFIG                         │
-- │            Polished • Minimal • Cohesive                 │
-- ╰──────────────────────────────────────────────────────────╯

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Leader keys (must be set before lazy)
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Core options
require("core.options")
require("core.keymaps")
require("core.autocmds")

-- Plugin manager
require("lazy").setup("plugins", {
  defaults = { lazy = true },
  install = { colorscheme = { "obsidian" } },
  checker = { enabled = false },
  change_detection = { notify = false },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip", "matchit", "matchparen", "netrwPlugin",
        "tarPlugin", "tohtml", "tutor", "zipPlugin",
      },
    },
  },
  ui = {
    border = "rounded",
    title = " 󰒲 Lazy ",
    backdrop = 100,
  },
})

-- Load colorscheme after plugins
vim.cmd.colorscheme("obsidian")

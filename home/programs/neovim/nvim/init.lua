-- ╭──────────────────────────────────────────────────────────────────────────╮
-- │                              Neovim Config                               │
-- │                        Clean • Polished • Minimal                        │
-- ╰──────────────────────────────────────────────────────────────────────────╯

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

-- Load core settings first
require("core.options")
require("core.keymaps")
require("core.autocmds")

-- Initialize plugins
require("lazy").setup("plugins", {
  defaults = { lazy = false },
  install = { colorscheme = { "tokyonight" } },
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
    backdrop = 100,
  },
})

-- ╭──────────────────────────────────────────────────────────╮
-- │                     AUTOCOMMANDS                         │
-- ╰──────────────────────────────────────────────────────────╯

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- ── Highlight on Yank ───────────────────────────────────────
autocmd("TextYankPost", {
  group = augroup("YankHighlight", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
})

-- ── Restore Cursor Position ─────────────────────────────────
autocmd("BufReadPost", {
  group = augroup("RestoreCursor", { clear = true }),
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- ── Resize Splits on Window Resize ──────────────────────────
autocmd("VimResized", {
  group = augroup("ResizeSplits", { clear = true }),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- ── Close Certain Filetypes with q ──────────────────────────
autocmd("FileType", {
  group = augroup("CloseWithQ", { clear = true }),
  pattern = {
    "help", "lspinfo", "notify", "qf", "query",
    "checkhealth", "neotest-output", "neotest-output-panel",
    "neotest-summary", "startuptime", "gitsigns-blame",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<CR>", {
      buffer = event.buf,
      silent = true,
      desc = "Close buffer",
    })
  end,
})

-- ── Auto Create Directories ─────────────────────────────────
autocmd("BufWritePre", {
  group = augroup("AutoCreateDir", { clear = true }),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- ── Check for External File Changes ─────────────────────────
autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("CheckTime", { clear = true }),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- ── Wrap & Spell in Text Files ──────────────────────────────
autocmd("FileType", {
  group = augroup("WrapSpell", { clear = true }),
  pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- ── Fix Conceallevel for JSON ───────────────────────────────
autocmd("FileType", {
  group = augroup("JsonConceal", { clear = true }),
  pattern = { "json", "jsonc", "json5" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

-- ── Disable New Line Comments ───────────────────────────────
autocmd("BufEnter", {
  group = augroup("NoAutoComment", { clear = true }),
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- ── Large File Handling ─────────────────────────────────────
autocmd("BufReadPre", {
  group = augroup("LargeFile", { clear = true }),
  callback = function(args)
    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
    if ok and stats and stats.size > 1024 * 1024 then -- 1MB
      vim.b[args.buf].large_file = true
      vim.opt_local.spell = false
      vim.opt_local.swapfile = false
      vim.opt_local.undofile = false
      vim.opt_local.breakindent = false
      vim.opt_local.colorcolumn = ""
      vim.opt_local.statuscolumn = ""
      vim.opt_local.signcolumn = "no"
      vim.opt_local.foldmethod = "manual"
      vim.opt_local.syntax = ""
    end
  end,
})

-- ── Terminal Settings ───────────────────────────────────────
autocmd("TermOpen", {
  group = augroup("TerminalSettings", { clear = true }),
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.opt_local.statuscolumn = ""
    vim.cmd("startinsert")
  end,
})

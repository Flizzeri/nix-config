-- ╭──────────────────────────────────────────────────────────────────────────╮
-- │                             Autocommands                                 │
-- ╰──────────────────────────────────────────────────────────────────────────╯

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- ── General Settings ────────────────────────────────────────────────────────
local general = augroup("userGeneral", { clear = true })

-- Highlight on yank
autocmd("TextYankPost", {
  group = general,
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 150 })
  end,
})

-- Restore cursor position
autocmd("BufReadPost", {
  group = general,
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Auto-resize splits on window resize
autocmd("VimResized", {
  group = general,
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- Close some filetypes with <q>
autocmd("FileType", {
  group = general,
  pattern = {
    "qf", "help", "man", "notify", "lspinfo", "checkhealth",
    "startuptime", "tsplayground", "PlenaryTestPopup",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true })
  end,
})

-- ── File-specific Settings ──────────────────────────────────────────────────
local filetype = augroup("UserFileType", { clear = true })

-- Set wrap and spell for text files
autocmd("FileType", {
  group = filetype,
  pattern = { "markdown", "text", "gitcommit" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Disable diagnostics in node_modules
autocmd({ "BufRead", "BufNewFile" }, {
  group = filetype,
  pattern = "*/node_modules/*",
  callback = function()
    vim.diagnostic.enable(false)
  end,
})

-- ── LSP Attach ──────────────────────────────────────────────────────────────
local lsp_group = augroup("UserLspAttach", { clear = true })

autocmd("LspAttach", {
  group = lsp_group,
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then return end

    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
    end

    -- Navigation
    map("n", "gd", vim.lsp.buf.definition, "Go to definition")
    map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
    map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
    map("n", "gr", vim.lsp.buf.references, "Go to references")
    map("n", "gy", vim.lsp.buf.type_definition, "Go to type definition")

    -- Documentation
    map("n", "K", vim.lsp.buf.hover, "Hover documentation")
    map({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, "Signature help")

    -- Actions
    map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
    map("v", "<leader>ca", vim.lsp.buf.code_action, "Code action")
    map("n", "<leader>cr", vim.lsp.buf.rename, "Rename symbol")
    map("n", "<leader>cf", function()
      require("conform").format({ bufnr = bufnr, async = true, lsp_fallback = true })
    end, "Format buffer")

    -- Workspace
    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
    map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
    map("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "List workspace folders")

    -- Inlay hints (if supported)
    if client.supports_method("textDocument/inlayHint") then
      map("n", "<leader>ch", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
      end, "Toggle inlay hints")
    end

    -- Code lens (if supported)
    if client.supports_method("textDocument/codeLens") then
      map("n", "<leader>cl", vim.lsp.codelens.run, "Run code lens")
      autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
        buffer = bufnr,
        callback = vim.lsp.codelens.refresh,
      })
    end
  end,
})

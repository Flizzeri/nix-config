-- ╭──────────────────────────────────────────────────────────────────────────╮
-- │                         Formatting & Linting                             │
-- ╰──────────────────────────────────────────────────────────────────────────╯

return {
  -- ── Formatting ────────────────────────────────────────────────────────────
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = { "n", "v" },
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_format", "ruff_fix" },
        rust = { "rustfmt" },
        go = { "gofumpt", "goimports" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
        jsonc = { "prettierd", "prettier", stop_after_first = true },
        yaml = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
        scss = { "prettierd", "prettier", stop_after_first = true },
        markdown = { "prettierd", "prettier", stop_after_first = true },
        nix = { "nixfmt" },
        sh = { "shfmt" },
        bash = { "shfmt" },
        toml = { "taplo" },
        ["_"] = { "trim_whitespace" },
      },
      format_on_save = function(bufnr)
        -- Disable for certain filetypes
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return
        end
        -- Disable for large files
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
        if ok and stats and stats.size > max_filesize then
          return
        end
        return {
          timeout_ms = 3000,
          lsp_fallback = true,
        }
      end,
      notify_on_error = true,
    },
  },

  -- ── Linting ───────────────────────────────────────────────────────────────
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        python = { "ruff" },
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        sh = { "shellcheck" },
        bash = { "shellcheck" },
        nix = { "statix" },
        yaml = { "yamllint" },
        dockerfile = { "hadolint" },
        markdown = { "markdownlint" },
      }

      -- Create autocommand to run linters
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          -- Only lint if the buffer is modifiable and has a filetype
          local buf = vim.api.nvim_get_current_buf()
          if vim.bo[buf].modifiable and vim.bo[buf].filetype ~= "" then
            lint.try_lint()
          end
        end,
      })

      -- Manual lint command
      vim.keymap.set("n", "<leader>ll", function()
        lint.try_lint()
      end, { desc = "Trigger linting" })
    end,
  },
}

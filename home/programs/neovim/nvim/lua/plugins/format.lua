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
					require("conform").format({
						async = true,
						lsp_fallback = true,
					})
				end,
				mode = { "n", "v" },
				desc = "Format buffer",
			},
		},

		opts = {
			formatters = {
				pg_format = {
					command = "pg_format",
					args = { "-" },
					stdin = true,
				},
			},

			formatters_by_ft = {
				lua = { "stylua" },

				python = { "ruff_format", "ruff_fix" },

				rust = { "rustfmt" },

				go = { "gofumpt", "goimports" },

				-- JS/TS ecosystem
				javascript = {
					"biome",
					"prettierd",
					"prettier",
					stop_after_first = true,
				},

				javascriptreact = {
					"biome",
					"prettierd",
					"prettier",
					stop_after_first = true,
				},

				typescript = {
					"biome",
					"prettierd",
					"prettier",
					stop_after_first = true,
				},

				typescriptreact = {
					"biome",
					"prettierd",
					"prettier",
					stop_after_first = true,
				},

				json = {
					"biome",
					"prettierd",
					"prettier",
					stop_after_first = true,
				},

				jsonc = {
					"biome",
					"prettierd",
					"prettier",
					stop_after_first = true,
				},

				css = {
					"biome",
					"prettierd",
					"prettier",
					stop_after_first = true,
				},

				scss = {
					"biome",
					"prettierd",
					"prettier",
					stop_after_first = true,
				},

				html = {
					"biome",
					"prettierd",
					"prettier",
					stop_after_first = true,
				},

				markdown = {
					"biome",
					"prettierd",
					"prettier",
					stop_after_first = true,
				},

				yaml = { "prettierd", "prettier", stop_after_first = true },

				nix = { "nixfmt" },

				sh = { "shfmt" },
				bash = { "shfmt" },

				sql = { "pg_format" },

				toml = { "taplo" },

				["_"] = { "trim_whitespace" },
			},

			format_on_save = function(bufnr)
				local disable_filetypes = {
					c = true,
					cpp = true,
				}

				if disable_filetypes[vim.bo[bufnr].filetype] then
					return
				end

				local max_filesize = 100 * 1024
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
			local has_biome = vim.fn.executable("biome") == 1

			lint.linters_by_ft = {

				lua = { "luacheck" },

				python = { "ruff" },

				javascript = has_biome and { "biomejs" } or { "eslint_d" },
				javascriptreact = has_biome and { "biomejs" } or { "eslint_d" },
				typescript = has_biome and { "biomejs" } or { "eslint_d" },
				typescriptreact = has_biome and { "biomejs" } or { "eslint_d" },

				sh = { "shellcheck" },
				bash = { "shellcheck" },

				nix = { "statix" },

				yaml = { "yamllint" },

				dockerfile = { "hadolint" },

				markdown = { "markdownlint" },
			}

			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,

				callback = function()
					local buf = vim.api.nvim_get_current_buf()

					if vim.bo[buf].modifiable and vim.bo[buf].filetype ~= "" then
						lint.try_lint()
					end
				end,
			})

			vim.keymap.set("n", "<leader>ll", function()
				lint.try_lint()
			end, { desc = "Trigger linting" })
		end,
	},
}

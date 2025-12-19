-- ╭──────────────────────────────────────────────────────────────────────────╮
-- │                              Telescope                                   │
-- ╰──────────────────────────────────────────────────────────────────────────╯

return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
    },
    keys = {
      -- Files
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope git_files<CR>", desc = "Find git files" },
      { "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Recent files" },

      -- Search
      { "<leader>sg", "<cmd>Telescope live_grep<CR>", desc = "Grep" },
      { "<leader>sw", "<cmd>Telescope grep_string<CR>", desc = "Grep word under cursor" },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Search buffer" },

      -- Git
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Git commits" },
      { "<leader>gb", "<cmd>Telescope git_branches<CR>", desc = "Git branches" },
      { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Git status" },

      -- LSP
      { "<leader>ss", "<cmd>Telescope lsp_document_symbols<CR>", desc = "Document symbols" },
      { "<leader>sS", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", desc = "Workspace symbols" },

      -- Vim
      { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help" },
      { "<leader>fk", "<cmd>Telescope keymaps<CR>", desc = "Keymaps" },
      { "<leader>fc", "<cmd>Telescope commands<CR>", desc = "Commands" },
      { "<leader>fd", "<cmd>Telescope diagnostics<CR>", desc = "Diagnostics" },
      { "<leader>f:", "<cmd>Telescope command_history<CR>", desc = "Command history" },
      { "<leader>fm", "<cmd>Telescope marks<CR>", desc = "Marks" },
      { "<leader>fR", "<cmd>Telescope resume<CR>", desc = "Resume last search" },

      -- Quick access
      { "<leader><leader>", "<cmd>Telescope find_files<CR>", desc = "Find files" },
      { "<leader>/", "<cmd>Telescope live_grep<CR>", desc = "Grep" },
      { "<leader>,", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
    },
    opts = function()
      local actions = require("telescope.actions")

      return {
        defaults = {
          prompt_prefix = "   ",
          selection_caret = "  ",
          entry_prefix = "   ",
          multi_icon = " + ",

          -- Layout
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
              results_width = 0.8,
            },
            vertical = {
              mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },

          -- Appearance
          sorting_strategy = "ascending",
          winblend = 0,
          borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          color_devicons = true,
          set_env = { ["COLORTERM"] = "truecolor" },

          -- File ignore patterns
          file_ignore_patterns = {
            "%.git/",
            "node_modules/",
            "%.cache/",
            "%.o$",
            "%.a$",
            "%.out$",
            "%.class$",
            "%.pdf$",
            "%.mkv$",
            "%.mp4$",
            "%.zip$",
            "target/",
            "dist/",
            "build/",
          },

          -- Mappings
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
              ["<C-c>"] = actions.close,
              ["<CR>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,
              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
            },
            n = {
              ["j"] = actions.move_selection_next,
              ["k"] = actions.move_selection_previous,
              ["q"] = actions.close,
              ["<Esc>"] = actions.close,
              ["<CR>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,
              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
              ["gg"] = actions.move_to_top,
              ["G"] = actions.move_to_bottom,
            },
          },

          -- Path display
          path_display = { "truncate" },

          -- Preview
          preview = {
            treesitter = true,
          },

          -- Vimgrep arguments
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
            "--glob=!.git/",
          },
        },

        pickers = {
          find_files = {
            hidden = true,
            find_command = { "fd", "--type", "f", "--strip-cwd-prefix", "--hidden", "--exclude", ".git" },
          },
          git_files = {
            show_untracked = true,
          },
          buffers = {
            sort_mru = true,
            sort_lastused = true,
            ignore_current_buffer = true,
            mappings = {
              i = {
                ["<C-d>"] = actions.delete_buffer,
              },
              n = {
                ["d"] = actions.delete_buffer,
              },
            },
          },
          live_grep = {
            additional_args = function()
              return { "--hidden", "--glob=!.git/" }
            end,
          },
          help_tags = {
            mappings = {
              i = {
                ["<CR>"] = actions.select_vertical,
              },
            },
          },
        },

        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      }
    end,
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)

      -- Load extensions
      pcall(telescope.load_extension, "fzf")
    end,
  },
}

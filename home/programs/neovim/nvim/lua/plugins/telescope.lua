-- ╭──────────────────────────────────────────────────────────╮
-- │                     TELESCOPE                            │
-- ╰──────────────────────────────────────────────────────────╯

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
      { "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Recent files" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
      
      -- Search
      { "<leader>sg", "<cmd>Telescope live_grep<CR>", desc = "Grep (live)" },
      { "<leader>sw", "<cmd>Telescope grep_string<CR>", desc = "Grep word under cursor" },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Search buffer" },
      
      -- Git
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Git commits" },
      { "<leader>gC", "<cmd>Telescope git_bcommits<CR>", desc = "Git buffer commits" },
      { "<leader>gb", "<cmd>Telescope git_branches<CR>", desc = "Git branches" },
      { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Git status" },
      
      -- LSP
      { "<leader>ss", "<cmd>Telescope lsp_document_symbols<CR>", desc = "Document symbols" },
      { "<leader>sS", "<cmd>Telescope lsp_workspace_symbols<CR>", desc = "Workspace symbols" },
      
      -- Misc
      { "<leader>:", "<cmd>Telescope command_history<CR>", desc = "Command history" },
      { "<leader>/", "<cmd>Telescope search_history<CR>", desc = "Search history" },
      { "<leader>sh", "<cmd>Telescope help_tags<CR>", desc = "Help pages" },
      { "<leader>sk", "<cmd>Telescope keymaps<CR>", desc = "Keymaps" },
      { "<leader>sm", "<cmd>Telescope marks<CR>", desc = "Marks" },
      { "<leader>sr", "<cmd>Telescope registers<CR>", desc = "Registers" },
      { "<leader>sR", "<cmd>Telescope resume<CR>", desc = "Resume last search" },
      { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<CR>", desc = "Document diagnostics" },
      { "<leader>sD", "<cmd>Telescope diagnostics<CR>", desc = "Workspace diagnostics" },
      { "<leader>sc", "<cmd>Telescope colorscheme<CR>", desc = "Colorschemes" },
      { "<leader>sH", "<cmd>Telescope highlights<CR>", desc = "Highlights" },
      { "<leader>so", "<cmd>Telescope vim_options<CR>", desc = "Vim options" },
      { "<leader>sa", "<cmd>Telescope autocommands<CR>", desc = "Autocommands" },
      
      -- Config files
      {
        "<leader>fc",
        function()
          require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
        end,
        desc = "Config files",
      },
    },
    opts = function()
      local actions = require("telescope.actions")
      local layout = require("telescope.actions.layout")
      
      return {
        defaults = {
          prompt_prefix = "   ",
          selection_caret = "  ",
          entry_prefix = "  ",
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
          
          sorting_strategy = "ascending",
          
          -- Appearance
          border = true,
          borderchars = {
            prompt = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            results = { "─", "│", "─", "│", "╭", "╮", "┤", "├" },
            preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          },
          
          winblend = 0,
          
          results_title = false,
          
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
            "__pycache__/",
            "%.pyc$",
            "target/",
            "%.lock$",
          },
          
          -- Behavior
          path_display = { "truncate" },
          dynamic_preview_title = true,
          
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
          
          -- Mappings
          mappings = {
            i = {
              ["<C-n>"] = actions.move_selection_next,
              ["<C-p>"] = actions.move_selection_previous,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<Down>"] = actions.move_selection_next,
              ["<Up>"] = actions.move_selection_previous,
              
              ["<CR>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,
              
              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,
              ["<C-f>"] = actions.preview_scrolling_right,
              ["<C-b>"] = actions.preview_scrolling_left,
              
              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              
              ["<C-l>"] = actions.complete_tag,
              ["<C-/>"] = actions.which_key,
              ["<C-_>"] = actions.which_key,
              
              ["<C-w>"] = { "<C-S-w>", type = "command" },
              
              ["<Esc>"] = actions.close,
              ["<C-c>"] = actions.close,
              
              ["<M-p>"] = layout.toggle_preview,
            },
            n = {
              ["<Esc>"] = actions.close,
              ["q"] = actions.close,
              ["<CR>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,
              
              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              
              ["j"] = actions.move_selection_next,
              ["k"] = actions.move_selection_previous,
              ["H"] = actions.move_to_top,
              ["M"] = actions.move_to_middle,
              ["L"] = actions.move_to_bottom,
              
              ["gg"] = actions.move_to_top,
              ["G"] = actions.move_to_bottom,
              
              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,
              
              ["<M-p>"] = layout.toggle_preview,
              ["?"] = actions.which_key,
            },
          },
        },
        
        pickers = {
          find_files = {
            hidden = true,
            find_command = { "fd", "--type", "f", "--strip-cwd-prefix", "--hidden", "--follow", "--exclude", ".git" },
          },
          live_grep = {
            additional_args = function()
              return { "--hidden" }
            end,
          },
          buffers = {
            sort_lastused = true,
            sort_mru = true,
            ignore_current_buffer = true,
            mappings = {
              i = {
                ["<C-d>"] = actions.delete_buffer,
              },
              n = {
                ["dd"] = actions.delete_buffer,
              },
            },
          },
          git_commits = {
            mappings = {
              i = {
                ["<C-o>"] = function(prompt_bufnr)
                  local selection = require("telescope.actions.state").get_selected_entry()
                  actions.close(prompt_bufnr)
                  vim.cmd("DiffviewOpen " .. selection.value .. "^!")
                end,
              },
            },
          },
          lsp_references = {
            show_line = false,
          },
          lsp_definitions = {
            show_line = false,
          },
          lsp_implementations = {
            show_line = false,
          },
          lsp_type_definitions = {
            show_line = false,
          },
          diagnostics = {
            line_width = "full",
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
      pcall(telescope.load_extension, "noice")
    end,
  },
}

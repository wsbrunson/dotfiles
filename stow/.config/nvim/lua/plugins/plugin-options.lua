-- Plugin configuration overrides
return {
  -- Configure Telescope with better defaults and hidden file toggle
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- Override default find_files to NOT show hidden by default
      {
        "<leader>ff",
        function()
          require("telescope.builtin").find_files()
        end,
        desc = "Find Files",
      },
      -- Add new keybinding to find ALL files including hidden/ignored
      {
        "<leader>fA",
        function()
          require("telescope.builtin").find_files({
            hidden = true,
            no_ignore = true,
            no_ignore_parent = true,
          })
        end,
        desc = "Find All Files (including hidden)",
      },
    },
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },

  -- Configure snacks.nvim file explorer
  -- Note: In the file explorer, you can toggle hidden files with 'H' or '.'
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      opts.dashboard = opts.dashboard or {}
      return opts
    end,
  },
}

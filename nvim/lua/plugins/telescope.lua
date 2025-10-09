return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  event = "VeryLazy",
  opts = {},
  keys = {
    {
      "<leader>f",
      function()
        require("telescope.builtin").find_files()
      end,
    },
    {
      "<leader>g",
      function()
        require("telescope.builtin").live_grep()
      end,
    },
  },
}

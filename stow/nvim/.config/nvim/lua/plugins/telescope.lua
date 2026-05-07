return {
  "nvim-telescope/telescope.nvim",
  enabled = true,
  opts = {
    defaults = {
      file_ignore_patterns = {
        "node_modules",
        "%.git/",
        "dist/",
        "build/",
      },
    },
  },
}

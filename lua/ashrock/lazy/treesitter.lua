return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "javascript", "typescript", "lua", "astro", "tsx", "json", "markdown"
      },

      sync_install = false,
      auto_install = true,

      indent = {
        enable = true
      },
      highlight = {
        enable = true,
        disable = { "astro" },
      },
    })
  end
}

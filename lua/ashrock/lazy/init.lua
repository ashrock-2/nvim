return {
  "nvim-lua/plenary.nvim",
  'tpope/vim-fugitive',
  'prettier/vim-prettier',
  { 'windwp/nvim-ts-autotag', config = true },
  "theprimeagen/vim-be-good",
  "sainnhe/gruvbox-material",
  "yorumicolors/yorumi.nvim",
  "rebelot/kanagawa.nvim",
  "folke/tokyonight.nvim",
  "scottmckendry/cyberdream.nvim",
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
  { 'glacambre/firenvim',     build = ":call firenvim#install(0)" },
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      keymaps = {
        ["<C-p>"] = false,
      },
      watch_for_changes = true
    },
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  },
  {
  "sphamba/smear-cursor.nvim",
    opts = {},
  }
}

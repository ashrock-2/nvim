return {
  "nvim-lua/plenary.nvim",
  'tpope/vim-fugitive',
  'prettier/vim-prettier',
  { 'windwp/nvim-ts-autotag', config = true },
  "theprimeagen/vim-be-good",
  {
    "yorumicolors/yorumi.nvim",
    config = function()
      vim.cmd("colorscheme yorumi")
    end
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
  "junegunn/goyo.vim"
}

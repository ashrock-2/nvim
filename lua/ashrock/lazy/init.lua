return {
  "nvim-lua/plenary.nvim",
  'tpope/vim-fugitive',
  'prettier/vim-prettier',
  { 'm4xshen/autoclose.nvim', config = true },
  {
    "yorumicolors/yorumi.nvim",
    config = function()
      vim.cmd("colorscheme yorumi")
    end
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" }
  }
}

return {
    "nvim-lua/plenary.nvim",
    'tpope/vim-fugitive',
    {
        "yorumicolors/yorumi.nvim",
        config = function()
            vim.cmd("colorscheme yorumi")
        end
    },
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        "nvim-treesitter/nvim-treesitter", build = ":TSUpdate"
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" }
    }
}


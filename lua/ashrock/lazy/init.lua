return {
    "nvim-lua/plenary.nvim",
    "yorumicolors/yorumi.nvim",
    'tpope/vim-fugitive',
    -- 'neovim/nvim-lspconfig',
    -- 'williamboman/mason.nvim',
    -- 'williamboman/mason-lspconfig.nvim',
    -- 'hrsh7th/nvim-cmp',
    -- 'hrsh7th/cmp-nvim-lsp',
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        "nvim-treesitter/nvim-treesitter", build = ":TSUpdate"
    },
    -- {
    --     'VonHeikemen/lsp-zero.nvim', branch = 'v4.x'
    -- },
}


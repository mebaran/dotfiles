require('paq') {
    'savq/paq-nvim',
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',

     -- LSP Support
    'williamboman/nvim-lsp-installer',
    'VonHeikemen/lsp-zero.nvim',
    'neovim/nvim-lspconfig',

    -- Autocompletion
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lua',

    -- Snippets
    'L3MON4D3/LuaSnip',
    'rafamadriz/friendly-snippets',

    -- Languages
    'jose-elias-alvarez/null-ls.nvim',
    'mfussenegger/nvim-jdtls',

    -- Git
    'lewis6991/gitsigns.nvim',
    'TimUntersberger/neogit',

    -- Tpope
    'tpope/vim-vinegar',
    'tpope/vim-unimpaired',

    --Telescope
    'nvim-telescope/telescope.nvim',
    {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },

    --Utils
    'numToStr/Comment.nvim',
    'lukas-reineke/indent-blankline.nvim',
    'voldikss/vim-floaterm',

    -- Status bar
    'feline-nvim/feline.nvim',
    -- Themes
    {'rose-pine/neovim', as='rose-pine'},
    {'folke/tokyonight.nvim', branch='main'},
}

-- Custom setups
require('plugins.telescope_setup')
require('plugins.feline_setup')
require('plugins.null_ls_setup')

-- Standard setups
require('gitsigns').setup()
require('neogit').setup()
require('indent_blankline').setup()
require('Comment').setup()

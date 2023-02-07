require('paq') {
    'savq/paq-nvim',
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'kyazdani42/nvim-web-devicons',

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
    'ionide/ionide-vim',

    -- Git
    'lewis6991/gitsigns.nvim',
    'TimUntersberger/neogit',
    'sindrets/diffview.nvim',

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
    'tversteeg/registers.nvim',
    "windwp/nvim-autopairs",
    "windwp/nvim-ts-autotag",

    -- Status bar
    'nvim-lualine/lualine.nvim',

    -- Themes
    {'rose-pine/neovim', as='rose-pine'},
    {'folke/tokyonight.nvim', branch='main'},
    {"catppuccin/nvim", as="catppuccin"},
}

-- Standard setups
require('neogit').setup()
require('indent_blankline').setup()
require('Comment').setup()
require('catppuccin').setup()
require('nvim-autopairs').setup()
require('nvim-ts-autotag').setup()
require('registers').setup()

-- Custom setups
require('plugins.lsp_setup')
require('plugins.telescope_setup')
require('plugins.lualine_setup')
require('plugins.null_ls_setup')
require('plugins.ionide_setup')
require('plugins.gitsigns_setup')
require('plugins.floaterm_setup')

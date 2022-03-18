-- Install packer
local install_path = vim.fn.stdpath 'data' ..
                         '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' ..
                       install_path)
end

vim.api.nvim_exec([[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]], false)

local use = require('packer').use
require('packer').startup(function()
    use 'wbthomason/packer.nvim' -- Package manager

    use 'tpope/vim-fugitive' -- Git commands in nvim
    use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
    use 'tpope/vim-commentary' -- "gc" to comment visual regions/lines
    use 'tpope/vim-unimpaired'
    use 'tpope/vim-vinegar'
    use 'tpope/vim-sensible'

    use 'tpope/vim-repeat'
    use 'famiu/bufdelete.nvim'
    use 'junegunn/gv.vim'
    use 'ggandor/lightspeed.nvim'

    -- UI to select things (files, grep results, open buffers...)
    use {'nvim-telescope/telescope.nvim', requires = {'nvim-lua/plenary.nvim'}}
    if jit then
        use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
    end

    -- Themes
    use 'joshdick/onedark.vim'
    use 'mhartington/oceanic-next'
    use 'sainnhe/everforest'
    use 'junegunn/seoul256.vim'
    use 'folke/tokyonight.nvim'
    use 'bluz71/vim-nightfly-guicolors'

    -- Fancier statusline
    use {
        'hoob3rt/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }

    -- Add indentation guides even on blank lines
    use 'lukas-reineke/indent-blankline.nvim'
    -- Add git related info in the signs columns and popups
    use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}}
    -- Highlight, edit, and navigate code using a fast incremental parsing library
    use 'nvim-treesitter/nvim-treesitter'
    -- Additional textobjects for treesitter
    use 'nvim-treesitter/nvim-treesitter-textobjects'

    use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
    use 'L3MON4D3/LuaSnip' -- Snippets plugin
    use 'nanotee/sqls.nvim'
    use 'mfussenegger/nvim-jdtls'
    use({
        "jose-elias-alvarez/null-ls.nvim",
        config = function() require("null-ls").setup() end,
        requires = {"nvim-lua/plenary.nvim"}
    })
    use({
        'simrat39/rust-tools.nvim',
        config = function()
            local keymap = require('lsp_keys').lsp_keys
            require('rust-tools').setup({server = {on_attach = keymap}})
        end
    })

    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-path'
    use 'saadparwaiz1/cmp_luasnip'

    use 'RishabhRD/popfix'
    use 'RishabhRD/nvim-lsputils'
end)

require('vim_settings')
require('theme')
require('statusline_settings')
require('telescope_settings')
require('treesitter_settings')
require('lsp_settings')
require('autocomplete_settings')

-- Gitsigns
require('gitsigns').setup {
    signs = {
        add = {hl = 'GitGutterAdd', text = '+'},
        change = {hl = 'GitGutterChange', text = '~'},
        delete = {hl = 'GitGutterDelete', text = '_'},
        topdelete = {hl = 'GitGutterDelete', text = '‾'},
        changedelete = {hl = 'GitGutterChange', text = '~'}
    }
}

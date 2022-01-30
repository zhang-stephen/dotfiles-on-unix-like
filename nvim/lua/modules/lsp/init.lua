local conf = require('modules.lsp.config')

local lsp = {
    ['neovim/nvim-lspconfig'] = {
        opt = true,
        event = 'BufReadPre',
        after = 'cmp-nvim-lsp',
        config = conf.lspconfig
    },

    ['williamboman/nvim-lsp-installer'] = {
        opt = true,
        after = 'nvim-lspconfig',
        config = conf.lspinstaller
    },

    ['RishabhRD/nvim-lsputils'] = {
        opt = true,
        after = {'nvim-lspconfig'},
        config = conf.lsputil
    },

    ['tami5/lspsaga.nvim'] = {
        opt = true,
        after = 'nvim-lspconfig',
        config = conf.lspsaga
    },

    ['kosayoda/nvim-lightbulb'] = {
        opt = true,
        after = 'nvim-lspconfig',
        config = conf.lightbulb
    },

    ['ray-x/lsp_signature.nvim'] = {
        opt = true,
        after = 'nvim-lspconfig'
    },

    -- Completions
    ['hrsh7th/nvim-cmp'] = {
        event = {'InsertEnter'},
        requires = {
            {
                'lukas-reineke/cmp-under-comparator',
            },
            {
                'hrsh7th/cmp-nvim-lsp',
                after = 'nvim-cmp'
            },
            {
                'hrsh7th/cmp-nvim-lua',
                after = 'cmp-nvim-lsp'
            },
            {
                'andersevenrud/cmp-tmux',
                after = 'cmp-nvim-lua'
            },
            {
                'hrsh7th/cmp-path',
                after = 'cmp-tmux'
            },
            {
                'f3fora/cmp-spell',
                after = 'cmp-path'
            },
            {
                'hrsh7th/cmp-buffer',
                after = 'cmp-spell'
            },
            {
                'kdheepak/cmp-latex-symbols',
                after = 'cmp-buffer'
            }
        },
        config = conf.cmp
    }
}

return lsp

-- EOF

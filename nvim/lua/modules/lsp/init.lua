local conf = require('modules.lsp.config')

local lsp = {}

lsp['neovim/nvim-lspconfig'] = {
    opt = true,
    event = { 'BufReadPre', 'BufNewFile' },
    module = {
        'lspconfig',
        'lspconfig.util',
    },
    config = conf.lspconfig,
}
lsp['williamboman/nvim-lsp-installer'] = {
    opt = true,
    module = 'nvim-lsp-installer',
}
lsp['RishabhRD/nvim-lsputils'] = {
    opt = true,
    after = 'nvim-lspconfig',
    config = conf.lsputils,
}
lsp['tami5/lspsaga.nvim'] = { opt = true, after = 'nvim-lspconfig' }
lsp['kosayoda/nvim-lightbulb'] = {
    opt = true,
    after = 'nvim-lspconfig',
    config = conf.lightbulb,
}

lsp['ray-x/lsp_signature.nvim'] = { opt = true, after = 'nvim-lspconfig' }
lsp['L3MON4D3/LuaSnip'] = { config = conf.luasnip, }

lsp['hrsh7th/nvim-cmp'] = {
    config = conf.cmp,
    event = 'InsertEnter',
    module = 'cmp',
    requires = {
        { 'lukas-reineke/cmp-under-comparator' },
        { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp', module = 'cmp_nvim_lsp' },
        { 'hrsh7th/cmp-nvim-lua', after = 'cmp-nvim-lsp' },
        { 'saadparwaiz1/cmp_luasnip', after = 'cmp-nvim-lua' },
        { 'andersevenrud/cmp-tmux', after = 'cmp_luasnip' },
        { 'hrsh7th/cmp-path', after = 'cmp-tmux' },
        { 'f3fora/cmp-spell', after = 'cmp-path' },
        { 'hrsh7th/cmp-buffer', after = 'cmp-spell' },
        { 'kdheepak/cmp-latex-symbols', after = 'cmp-buffer' },
    },
}

lsp['windwp/nvim-autopairs'] = {
    after = 'nvim-cmp',
    config = conf.autopairs,
}

return lsp

-- EOF

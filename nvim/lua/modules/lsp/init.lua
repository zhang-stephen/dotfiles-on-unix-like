local conf = require('modules.lsp.config')

local lsp = {}

lsp['neovim/nvim-lspconfig'] = {
    opt = true,
    after = 'cmp-nvim-lsp',
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
lsp['hrsh7th/nvim-cmp'] = {
    config = conf.cmp,
    event = { 'BufReadPre', 'BufNewFile' },
    module = 'cmp',
    requires = {
        { 'lukas-reineke/cmp-under-comparator' },
        { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp', module = 'cmp_nvim_lsp' },
        { 'hrsh7th/cmp-nvim-lua', after = 'cmp-nvim-lsp' },
        { 'andersevenrud/cmp-tmux', after = 'cmp-nvim-lua' },
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

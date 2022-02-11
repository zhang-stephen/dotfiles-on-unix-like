local conf = require('modules.lsp.config')

local lsp = {}

lsp['neovim/nvim-lspconfig'] = {
    opt = true,
    after = 'cmp-nvim-lsp',
    config = conf.lspconfig,
}
lsp['williamboman/nvim-lsp-installer'] = {
    opt = false,
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
    requires = {
        { 'lukas-reineke/cmp-under-comparator' },
        { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
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

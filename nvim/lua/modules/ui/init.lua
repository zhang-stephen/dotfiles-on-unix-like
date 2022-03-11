local ui = {}
local conf = require('modules.ui.config')

ui['kyazdani42/nvim-web-devicons'] = {
    opt = false,
}
ui['folke/tokyonight.nvim'] = {
    opt = false,
    config = conf.tokyonight,
}
ui['sainnhe/gruvbox-material'] = {
    opt = false,
    config = conf.gruvbox_material,
}
ui['hoob3rt/lualine.nvim'] = {
    opt = true,
    after = 'lualine-lsp-progress',
    config = conf.lualine,
}
ui['arkav/lualine-lsp-progress'] = {
    opt = true,
    after = 'nvim-gps',
}
ui['goolord/alpha-nvim'] = {
    opt = true,
    event = 'BufWinEnter',
    config = conf.alpha_nvim,
}
ui['kyazdani42/nvim-tree.lua'] = {
    opt = true,
    cmd = { 'NvimTreeToggle', 'NvimTreeOpen' },
    config = conf.nvim_tree,
}
ui['lewis6991/gitsigns.nvim'] = {
    opt = true,
    event = { 'BufRead', 'BufNewFile' },
    config = conf.gitsigns,
    requires = {
        'nvim-lua/plenary.nvim',
        opt = true,
    },
}
ui['lukas-reineke/indent-blankline.nvim'] = {
    opt = true,
    event = 'BufReadPre',
    after = 'nvim-treesitter',
    config = conf.indent_blankline,
}
ui['akinsho/nvim-bufferline.lua'] = {
    opt = true,
    event = 'BufRead',
    config = conf.nvim_bufferline,
}
ui['dstein64/nvim-scrollview'] = {
    opt = true,
    event = 'BufRead',
}

return ui

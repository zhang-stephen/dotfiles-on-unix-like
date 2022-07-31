local ui = {}
local conf = require('modules.ui.config')

ui['kyazdani42/nvim-web-devicons'] = {
    opt = false,
    config = conf.devicon,
}
ui['catppuccin/nvim'] = {
    opt = false,
    as = 'catppuccin',
    config = conf.catppuccin,
}
ui['hoob3rt/lualine.nvim'] = {
    opt = true,
    after = 'nvim-gps',
    config = conf.lualine,
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
    event = { 'BufReadPre', 'BufNewFile' },
    after = 'nvim-treesitter',
    config = conf.indent_blankline,
}
ui['akinsho/nvim-bufferline.lua'] = {
    opt = true,
    event = { 'BufReadPre', 'BufNewFile' },
    branch = 'main',
    config = conf.bufferline,
}
ui['dstein64/nvim-scrollview'] = {
    opt = true,
    event = 'BufRead',
}
ui['norcalli/nvim-colorizer.lua'] = {
    opt = true,
    event = 'BufReadPre',
    config = conf.colorizer,
}

return ui

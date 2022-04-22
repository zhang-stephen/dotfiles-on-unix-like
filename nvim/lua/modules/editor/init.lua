local editor = {}
local conf = require('modules.editor.config')

editor['junegunn/vim-easy-align'] = { opt = true, cmd = 'EasyAlign' }
editor['itchyny/vim-cursorword'] = {
    opt = true,
    event = { 'BufReadPre', 'BufNewFile' },
    config = conf.vim_cursorwod,
}
editor['numToStr/Comment.nvim'] = {
    opt = false,
    config = conf.comment,
}
editor['folke/todo-comments.nvim'] = {
    opt = false,
    config = conf.todo_comment,
}
editor['stevearc/aerial.nvim'] = {
    opt = true,
    cmd = { 'AerialToggle' },
    module = 'aerial',
    config = conf.aerial,
}
editor['nvim-treesitter/nvim-treesitter'] = {
    run = ':TSUpdate all',
    config = conf.nvim_treesitter,
}
editor['nvim-treesitter/nvim-treesitter-textobjects'] = {
    opt = true,
    after = 'nvim-treesitter',
}
editor['romgrk/nvim-treesitter-context'] = {
    opt = true,
    after = 'nvim-treesitter',
}
editor['p00f/nvim-ts-rainbow'] = {
    opt = true,
    after = 'nvim-treesitter',
}
editor['JoosepAlviste/nvim-ts-context-commentstring'] = {
    opt = true,
    after = 'nvim-treesitter',
}
editor['mfussenegger/nvim-ts-hint-textobject'] = {
    opt = true,
    after = 'nvim-treesitter',
}
editor['SmiteshP/nvim-gps'] = {
    opt = true,
    event = { 'BufReadPre', 'BufNewFile', 'BufWinEnter' },
    config = conf.nvim_gps,
}
editor['windwp/nvim-ts-autotag'] = {
    opt = true,
    ft = { 'html', 'xml' },
    config = conf.autotag,
}
editor['andymass/vim-matchup'] = {
    opt = true,
    after = 'nvim-treesitter',
    config = conf.matchup,
}
editor['rhysd/accelerated-jk'] = { opt = false }
editor['hrsh7th/vim-eft'] = { opt = false }
editor['romainl/vim-cool'] = {
    opt = true,
    event = { 'CursorMoved', 'InsertEnter' },
}
editor['phaazon/hop.nvim'] = {
    opt = true,
    branch = 'v1',
    cmd = {
        'HopLine',
        'HopLineStart',
        'HopWord',
        'HopPattern',
        'HopChar1',
        'HopChar2',
    },
    config = function()
        require('hop').setup({ keys = 'etovxqpdygfblzhckisuran' })
    end,
}
editor['karb94/neoscroll.nvim'] = {
    opt = true,
    event = 'WinScrolled',
    config = conf.neoscroll,
}
editor['vimlab/split-term.vim'] = { opt = true, cmd = { 'Term', 'VTerm' } }
editor['akinsho/nvim-toggleterm.lua'] = {
    opt = true,
    event = 'BufRead',
    branch = 'main',
    config = conf.toggleterm,
}
editor['numtostr/FTerm.nvim'] = { opt = true, event = 'BufRead' }
editor['rmagatti/auto-session'] = {
    opt = true,
    cmd = { 'SaveSession', 'RestoreSession', 'DeleteSession' },
    config = conf.auto_session,
}
editor['tpope/vim-fugitive'] = { opt = true, cmd = { 'Git', 'G' } }
editor['famiu/bufdelete.nvim'] = {
    opt = true,
    cmd = { 'Bdelete', 'Bwipeout', 'Bdelete!', 'Bwipeout!' },
}
editor['edluffy/specs.nvim'] = {
    opt = true,
    event = 'CursorMoved',
    config = conf.specs,
}
editor["rcarriga/nvim-dap-ui"] = {
	opt = false,
	config = conf.dapui,
	requires = {
		{ "mfussenegger/nvim-dap", config = conf.dap },
		{
			"Pocco81/DAPInstall.nvim",
			opt = true,
			cmd = { "DIInstall", "DIUninstall", "DIList" },
			-- config = conf.dapinstall,
		},
	},
}

return editor

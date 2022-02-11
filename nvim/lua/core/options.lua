local log = require('utility.logger')
local options = {}

options.configuration = {
    global = {
        termguicolors = true,
        mouse = 'a',
        fileformat = 'unix',
        magic = true,
        encoding = 'utf-8',
        virtualedit = 'block',
        history = 2000,
        updatetime = 100,
        redrawtime = 1500,
        background = 'dark',
        bs = 'indent,eol,start',
        foldlevelstart = 99,
        splitbelow = true,
        splitright = true,
        grepformat = '%f:%l:%c:%m',
        -- grepprg = 'rg --hidden --vimgrep --smart-case --'
    },

    buffwin = {
        undofile = true,
        synmaxcol = 2500,
        formatoptions = '1jcroql',
        expandtab = true,
        autoindent = true,
        tabstop = 4,
        shiftwidth = 4,
        softtabstop = -1,
        breakindentopt = 'shift:2,min:20',
        wrap = false,
        linebreak = true,
        number = true,
        relativenumber = true,
        foldenable = true,
        signcolumn = 'number',
        conceallevel = 0,
        concealcursor = 'niv',
        scrolloff = 15,
        smartcase = true,
        hlsearch = true,
        incsearch = true,
        cursorline = true,
        cursorcolumn = false,
        showcmd = true,
        cmdwinheight = 5,
        equalalways = false,
        laststatus = 2,
        display = 'lastline',
        pumblend = 10,
        winblend = 10,
    },

    cmds = { 'filetype indent on', 'highlight Pmenu ctermbg=black guibg=black' },
}

local bind_option = function(options)
    for k, v in pairs(options) do
        if v == true then
            vim.cmd('set ' .. k)
        elseif v == false then
            vim.cmd('set no' .. k)
        else
            vim.cmd('set ' .. k .. '=' .. v)
        end
    end
end

options.setup = function()
    for group, confs in pairs(options.configuration) do
        if group ~= 'cmds' then
            bind_option(confs)
        else
            for _, cmd in ipairs(confs) do
                vim.api.nvim_command(cmd)
            end
        end
    end
end

return options

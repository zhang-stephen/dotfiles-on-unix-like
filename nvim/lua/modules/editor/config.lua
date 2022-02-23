local config = {}
local sessions_dir = vim.fn.stdpath('data') .. '/sessions/'

function config.vim_cursorwod()
    vim.api.nvim_command('augroup user_plugin_cursorword')
    vim.api.nvim_command('autocmd!')
    vim.api.nvim_command('autocmd FileType NvimTree,lspsagafinder,alpha let b:cursorword = 0')
    vim.api.nvim_command('autocmd WinEnter * if &diff || &pvw | let b:cursorword = 0 | endif')
    vim.api.nvim_command('autocmd InsertEnter * let b:cursorword = 0')
    vim.api.nvim_command('autocmd InsertLeave * let b:cursorword = 1')
    vim.api.nvim_command('augroup END')
end

function config.nvim_comment()
    vim.api.nvim_command([[autocmd! FileType c,cpp :lua vim.api.nvim_buf_set_option(0, 'commentstring', '// %s')]])
    require('nvim_comment').setup()
end

function config.todo_comment()
    -- use all default settings
    require('todo-comments').setup {}
end

function config.aerial()
    require('aerial').setup {
        backups = {'lsp', 'treesitter'},
        filter_kind = {
            "Class",
            "Constructor",
            "Enum",
            "Function",
            "Interface",
            "Module",
            "Method",
            "Namespace",
            "Struct",
        },
    }
end

function config.nvim_treesitter()
    vim.api.nvim_command('set foldmethod=expr')
    vim.api.nvim_command('set foldexpr=nvim_treesitter#foldexpr()')

    require('nvim-treesitter.configs').setup({
        ensure_installed = {
            'c',
            'cpp',
            'json',
            'python',
            'rust',
            'yaml',
            'toml',
            'lua',
            'cmake',
            'make',
            'vim',
            'bash',
        },
        highlight = {
            enable = true,
            disable = { 'vim' },
        },
        textobjects = {
            select = {
                enable = true,
                keymaps = {
                    ['af'] = '@function.outer',
                    ['if'] = '@function.inner',
                    ['ac'] = '@class.outer',
                    ['ic'] = '@class.inner',
                },
            },
            move = {
                enable = true,
                set_jumps = true, -- whether to set jumps in the jumplist
                goto_next_start = {
                    [']['] = '@function.outer',
                    [']m'] = '@class.outer',
                },
                goto_next_end = {
                    [']]'] = '@function.outer',
                    [']M'] = '@class.outer',
                },
                goto_previous_start = {
                    ['[['] = '@function.outer',
                    ['[m'] = '@class.outer',
                },
                goto_previous_end = {
                    ['[]'] = '@function.outer',
                    ['[M'] = '@class.outer',
                },
            },
        },
        rainbow = {
            enable = true,
            extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
            max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
        },
        context_commentstring = {
            enable = true,
            enable_autocmd = false,
        },
        matchup = {
            enable = true,
        },
        context = {
            enable = true,
            throttle = true,
        },
    })

    -- prefer git rather than curl to install parsers
    require('nvim-treesitter.install').prefer_git = true
end

function config.matchup()
    vim.api.nvim_command([[let g:matchup_matchparen_offscreen = {'method': 'popup'}]])
end

function config.nvim_gps()
    require('nvim-gps').setup({
        icons = {
            ['class-name'] = ' ', -- Classes and class-like objects
            ['function-name'] = ' ', -- Functions
            ['method-name'] = ' ', -- Methods (functions inside class-like objects)
        },
        languages = {
            ['c'] = true,
            ['cpp'] = true,
            ['lua'] = true,
            ['python'] = true,
            ['rust'] = true,
        },
        separator = ' > ',
    })
end

function config.autotag()
    require('nvim-ts-autotag').setup({
        filetypes = { 'html', 'xml', 'javascript', 'typescriptreact', 'javascriptreact', 'vue' },
    })
end

function config.nvim_colorizer()
    require('colorizer').setup()
end

function config.neoscroll()
    require('neoscroll').setup({
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
        hide_cursor = true, -- Hide cursor while scrolling
        stop_eof = true, -- Stop at <EOF> when scrolling downwards
        use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil, -- Default easing function
        pre_hook = nil, -- Function to run before the scrolling animation starts
        post_hook = nil, -- Function to run after the scrolling animation ends
    })
end

function config.auto_session()
    local opts = {
        log_level = 'info',
        auto_session_enable_last_session = true,
        auto_session_root_dir = sessions_dir,
        auto_session_enabled = true,
        auto_save_enabled = true,
        auto_restore_enabled = true,
        auto_session_suppress_dirs = nil,
    }

    require('auto-session').setup(opts)
end

function config.toggleterm()
    require('toggleterm').setup({
        -- size can be a number or function which is passed the current terminal
        size = function(term)
            if term.direction == 'horizontal' then
                return 15
            elseif term.direction == 'vertical' then
                return vim.o.columns * 0.40
            end
        end,
        open_mapping = [[<c-\>]],
        hide_numbers = true, -- hide the number column in toggleterm buffers
        shade_filetypes = {},
        shade_terminals = false,
        shading_factor = '1', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
        start_in_insert = true,
        insert_mappings = true, -- whether or not the open mapping applies in insert mode
        persist_size = true,
        direction = 'horizontal',
        close_on_exit = true, -- close the terminal window when the process exits
        shell = vim.o.shell, -- change the default shell
    })
end

function config.specs()
    require('specs').setup({
        show_jumps = true,
        min_jump = 10,
        popup = {
            delay_ms = 0, -- delay before popup displays
            inc_ms = 10, -- time increments used for fade/resize effects
            blend = 10, -- starting blend, between 0-100 (fully transparent), see :h winblend
            width = 10,
            winhl = 'PMenu',
            fader = require('specs').pulse_fader,
            resizer = require('specs').shrink_resizer,
        },
        ignore_filetypes = {},
        ignore_buftypes = {
            nofile = true,
        },
    })
end

return config

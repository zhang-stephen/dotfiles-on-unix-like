local config = {}

config.vim_cursorwod = function()
    vim.api.nvim_command('augroup user_plugin_cursorword')
    vim.api.nvim_command('autocmd!')
    vim.api.nvim_command('autocmd FileType NvimTree,lspsagafinder,alpha let b:cursorword = 0')
    vim.api.nvim_command('autocmd WinEnter * if &diff || &pvw | let b:cursorword = 0 | endif')
    vim.api.nvim_command('autocmd InsertEnter * let b:cursorword = 0')
    vim.api.nvim_command('autocmd InsertLeave * let b:cursorword = 1')
    vim.api.nvim_command('augroup END')
end

config.comment = function()
    require('Comment').setup({
        padding = true,
        sticky = true,
        ignore = nil,
        toggler = {
            line = 'gcc',
            block = 'gbc',
        },
        opleader = {
            line = 'gc',
            block = 'gb',
        },
        extra = {
            above = 'gcO',
            below = 'gco',
            eol = 'gcA',
        },
        mapping = {
            basic = true,
            extra = true,
            extended = true,
        },
        pre_hook = nil,
        post_hook = nil,
    })
end

config.todo_comment = function()
    require('todo-comments').setup({})
end

config.aerial = function()
    require('aerial').setup({
        backups = { 'lsp', 'treesitter', 'markdown' },
        filter_kind = {
            'Class',
            'Constructor',
            'Enum',
            'Field',
            'Function',
            'Interface',
            'Key',
            'Module',
            'Method',
            'Namespace',
            'Object',
            'Operator',
            'Package',
            'Property',
            'Struct',
            'TypeParameter',
        },
        max_width = { 60, 0.3 },
        close_behavior = 'close',
    })
end

config.nvim_treesitter = function()
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

config.matchup = function()
    vim.api.nvim_command([[let g:matchup_matchparen_offscreen = {'method': 'popup'}]])
end

config.nvim_gps = function()
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

config.autotag = function()
    require('nvim-ts-autotag').setup({
        filetypes = { 'html', 'xml', 'javascript', 'typescriptreact', 'javascriptreact', 'vue' },
    })
end

config.neoscroll = function()
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

config.toggleterm = function()
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

config.specs = function()
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

config.dapui = function()
    require('dapui').setup({
        icons = { expanded = '-', collapsed = '+' },
        mappings = {
            -- Use a table to apply multiple mappings
            expand = { '<CR>', '<2-LeftMouse>' },
            open = 'o',
            remove = 'd',
            edit = 'e',
            repl = 'r',
            toggle = 't',
        },
        sidebar = {
            elements = {
                -- Provide as ID strings or tables with "id" and "size" keys
                {
                    id = 'scopes',
                    size = 0.25, -- Can be float or integer > 1
                },
                { id = 'breakpoints', size = 0.25 },
                { id = 'stacks', size = 0.25 },
                { id = 'watches', size = 0.25 },
            },
            size = 40,
            position = 'left',
        },
        tray = { elements = { 'repl' }, size = 10, position = 'bottom' },
        floating = {
            max_height = nil,
            max_width = nil,
            mappings = { close = { 'q', '<Esc>' } },
        },
        windows = { indent = 1 },
    })
end

function config.dap()
    local dap = require('dap')
    local dapui = require('dapui')

    dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
    end
    dap.listeners.after.event_terminated['dapui_config'] = function()
        dapui.close()
    end
    dap.listeners.after.event_exited['dapui_config'] = function()
        dapui.close()
    end

    vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })

    dap.adapters.lldb = {
        type = 'executable',
        command = '/usr/bin/lldb-vscode',
        name = 'lldb',
    }
    dap.configurations.cpp = {
        {
            name = 'Launch',
            type = 'lldb',
            request = 'launch',
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = true,
            args = {},

            -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
            --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
            -- Otherwise you might get the following error:
            --    Error on launch: Failed to attach to the target process
            -- But you should be aware of the implications:
            -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
            runInTerminal = false,
        },
    }

    dap.configurations.c = dap.configurations.cpp
    dap.configurations.rust = dap.configurations.cpp

    dap.adapters.python = {
        type = 'executable',
        command = os.getenv('HOME') .. '/.local/share/nvim/dapinstall/python/bin/python',
        args = { '-m', 'debugpy.adapter' },
    }
    dap.configurations.python = {
        {
            -- The first three options are required by nvim-dap
            type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
            request = 'launch',
            name = 'Launch file',
            -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

            program = '${file}', -- This configuration will launch the current file if used.
            pythonPath = function()
                -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
                -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
                -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
                local cwd = vim.fn.getcwd()
                if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
                    return cwd .. '/venv/bin/python'
                elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
                    return cwd .. '/.venv/bin/python'
                else
                    return '/usr/bin/python'
                end
            end,
        },
    }

    -- load user defined .nvim/launch.json
    require('dap.ext.vscode').load_launchjs('.nvim/launch.json')
end

return config

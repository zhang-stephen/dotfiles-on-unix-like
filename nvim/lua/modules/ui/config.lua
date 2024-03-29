local config = {}

config.devicon = function()
    require('nvim-web-devicons').set_default_icon('', '#6d8086')
    require('nvim-web-devicons').setup({
        default = true,
    })
end

config.alpha_nvim = function()
    local alpha = require('alpha')
    local dashboard = require('alpha.themes.dashboard')

    -- Set header
    dashboard.section.header.val = {
        '                                                     ',
        '  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
        '  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
        '  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
        '  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
        '  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
        '  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
        '                                                     ',
    }

    -- Set menu, telescope.nvim required
    dashboard.section.buttons.val = {
        dashboard.button('f', '  > Find file', ':cd ~ | Telescope find_files<CR>'),
        dashboard.button('r', '  > Recent', ':Telescope oldfiles<CR>'),
        dashboard.button('n', '  > Notifations', ':Telescope notify<CR>'),
        dashboard.button('x', '  > Git Status', ':Telescope git_status<CR>'),
        dashboard.button('c', 'ﰖ  > Git Commits', ':Telescope git_commits<CR>'),
        dashboard.button('b', 'שׂ  > Git Branches', ':Telescope git_branches<CR>'),
        dashboard.button('s', 'ﭧ  > Git Stashes', ':Telescope git_stash<CR>'),
        dashboard.button('t', '  > Themes', ':Telescope colorscheme<CR>'),
        dashboard.button('q', '  > Quit neovim', ':qa<CR>'),
    }

    dashboard.section.footer.val = require('alpha.fortune')()
    alpha.setup(dashboard.opts)

    -- Disable folding on alpha buffer
    vim.api.nvim_command([[
        autocmd FileType alpha setlocal nofoldenable
    ]])
end

config.catppuccin = function()
    require('catppuccin').setup({
        transparent_background = true,
        term_colors = true,
        styles = {
            comments = {},
            functions = { 'italic' },
            keywords = { 'italic' },
            strings = { 'bold' },
            variables = {},
        },
        integrations = {
            treesitter = true,
            native_lsp = {
                enabled = true,
                virtual_text = {
                    errors = { 'italic' },
                    hints = { 'italic' },
                    warnings = { 'italic' },
                    information = { 'italic' },
                },
                underlines = {
                    errors = { 'undercurl' },
                    hints = { 'undercurl' },
                    warnings = { 'undercurl' },
                    information = { 'undercurl' },
                },
            },
            lsp_trouble = true,
            cmp = true,
            lsp_saga = true,
            gitgutter = false,
            gitsigns = true,
            telescope = true,
            nvimtree = {
                enabled = true,
                show_root = false,
                transparent_panel = true,
            },
            which_key = true,
            indent_blankline = {
                enabled = true,
                colored_indent_levels = false,
            },
            bufferline = true,
            markdown = true,
            ts_rainbow = false,
            hop = false,
            notify = true,
        },
    })

    vim.api.nvim_command('color catppuccin')
end

config.lualine = function()
    local gps = require('nvim-gps')

    local function gps_content()
        if gps.is_available() then
            return gps.get_location()
        else
            return ''
        end
    end

    local extend_sections = {
        lualine_a = { 'filetype' },
    }

    local aerial = {
        sections = extend_sections,
        filetypes = { 'aerial' },
    }

    local dapui = {
        sections = extend_sections,
        filetypes = {
            ['dapui_scopes'] = 'DAP Scopes',
            ['dapui_stacks'] = 'DAP Stacks',
            ['dapui_breakpoints'] = 'DAP Breakpoints',
            ['dapui_watches'] = 'DAP Watches',
        },
    }

    require('lualine').setup({
        options = {
            icons_enabled = true,
            theme = 'auto',
            disabled_filetypes = {},
            component_separators = '|',
            section_separators = nil,
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { { 'branch' }, { 'diff' } },
            lualine_c = {
                -- { 'lsp_progress' },
                { gps_content, cond = gps.is_available },
            },
            lualine_x = {
                {
                    'diagnostics',
                    sources = { 'nvim_diagnostic' },
                    symbols = { error = ' ', warn = ' ', info = ' ' },
                },
            },
            lualine_y = { 'filetype', 'encoding', 'fileformat' },
            lualine_z = { 'progress', 'location' },
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { 'filename' },
            lualine_x = { 'location' },
            lualine_y = {},
            lualine_z = {},
        },
        tabline = {},
        extensions = {
            'quickfix',
            'nvim-tree',
            'toggleterm',
            'fugitive',
            aerial,
            dapui,
        },
    })
end

config.nvim_tree = function()
    require('nvim-tree').setup({
        disable_netrw = true,
        hijack_netrw = true,
        open_on_setup = false,
        ignore_ft_on_setup = {},
        open_on_tab = false,
        hijack_cursor = true,
        update_cwd = false,
        diagnostics = {
            enable = false,
            icons = { hint = '', info = '', warning = '', error = '' },
        },
        update_focused_file = {
            enable = true,
            update_cwd = true,
            ignore_list = {},
        },
        system_open = { cmd = nil, args = {} },
        filters = { dotfiles = false, custom = {} },
        git = { enable = true, ignore = true, timeout = 500 },
        view = {
            width = 30,
            height = 30,
            hide_root_folder = false,
            side = 'left',
            adaptive_size = true,
            mappings = { custom_only = false, list = {} },
            number = false,
            relativenumber = false,
            signcolumn = 'yes',
        },
        trash = { cmd = 'trash', require_confirm = true },
    })
end

config.bufferline = function()
    require('bufferline').setup({
        options = {
            numbers = function(opts)
                return string.format('%s/%s', opts.raise(opts.id), opts.lower(opts.ordinal))
            end,
            modified_icon = '*',
            buffer_close_icon = '',
            left_trunc_marker = '',
            right_trunc_marker = '',
            max_name_length = 14,
            max_prefix_length = 13,
            tab_size = 20,
            show_buffer_close_icons = true,
            show_buffer_icons = true,
            show_tab_indicators = true,
            diagnostics = 'nvim_lsp',
            always_show_bufferline = true,
            separator_style = 'thin',
            offsets = {
                {
                    filetype = 'NvimTree',
                    text = 'File Explorer',
                    text_align = 'center',
                    padding = 1,
                },
            },
        },
        highlights = {},
    })
end

config.gitsigns = function()
    require('gitsigns').setup({
        keymaps = {
            -- Default keymap options
            noremap = true,
            buffer = true,
            ['n ]g'] = {
                expr = true,
                "&diff ? ']g' : '<cmd>lua require'gitsigns'.next_hunk()<CR>'",
            },
            ['n [g'] = {
                expr = true,
                "&diff ? '[g' : '<cmd>lua require'gitsigns'.prev_hunk()<CR>'",
            },
            ['n <leader>hs'] = "<cmd>lua require'gitsigns'.stage_hunk()<CR>",
            ['v <leader>hs'] = "<cmd>lua require'gitsigns'.stage_hunk({vim.fn.line('.'), vim.fn.line('v')})<CR>",
            ['n <leader>hu'] = "<cmd>lua require'gitsigns'.undo_stage_hunk()<CR>",
            ['n <leader>hr'] = "<cmd>lua require'gitsigns'.reset_hunk()<CR>",
            ['v <leader>hr'] = "<cmd>lua require'gitsigns'.reset_hunk({vim.fn.line('.'), vim.fn.line('v')})<CR>",
            ['n <leader>hR'] = "<cmd>lua require'gitsigns'.reset_buffer()<CR>",
            ['n <leader>hp'] = "<cmd>lua require'gitsigns'.preview_hunk()<CR>",
            ['n <leader>hb'] = "<cmd>lua require'gitsigns'.blame_line(true)<CR>",
            -- Text objects
            ['o ih'] = ":<C-U>lua require'gitsigns'.text_object()<CR>",
            ['x ih'] = ":<C-U>lua require'gitsigns'.text_object()<CR>",
        },
        watch_gitdir = { interval = 1000, follow_files = true },
        current_line_blame = true,
        current_line_blame_opts = { delay = 1000, virtual_text_pos = 'eol' },
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        word_diff = false,
        diff_opts = { internal = true },
    })
end

config.indent_blankline = function()
    vim.opt.list = true
    -- vim.opt.listchars:append('space:⋅')
    -- vim.opt.listchars:append('eol:↴')

    require('indent_blankline').setup({
        char = '│',
        space_char_blankline = ' ',
        use_treesitter = true,
        show_first_indent_level = true,
        show_trailing_blankline_indent = false,
        show_current_context = true,
        show_current_context_start = true,
        buftype_exclude = {
            'terminal',
            'nofile',
        },
        context_patterns = {
            'class',
            'function',
            'method',
            'block',
            'list_literal',
            'selector',
            '^if',
            '^table',
            'if_statement',
            'while',
            'for',
            'type',
            'var',
            'import',
        },
        filetype_exclude = {
            'startify',
            'dashboard',
            'alpha',
            'dotooagenda',
            'log',
            'fugitive',
            'gitcommit',
            'packer',
            'vimwiki',
            'markdown',
            'json',
            'txt',
            'vista',
            'help',
            'todoist',
            'NvimTree',
            'peekaboo',
            'git',
            'TelescopePrompt',
            'undotree',
            'flutterToolsOutline',
            '', -- for all buffers without a file type
        },
    })
    -- because lazy load indent-blankline so need readd this autocmd
    vim.api.nvim_command('autocmd BufReadPre * IndentBlanklineEnable')
    vim.api.nvim_command('autocmd BufNewFile * IndentBlanklineEnable')
    vim.api.nvim_command('autocmd CursorMoved * IndentBlanklineRefresh')
end

config.colorizer = function()
    require('colorizer').setup({
        '*',
    }, {
        mode = 'background',
        RGB = true,
        RRGGBB = true,
        names = true,
    })
end

return config

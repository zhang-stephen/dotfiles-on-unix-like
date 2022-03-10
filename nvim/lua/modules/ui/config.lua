local config = {}

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

config.tokyonight = function()
    vim.g.tokyonight_italic_keywords = false
    vim.g.tokyonight_italic_comments = false
    vim.g.tokyonight_transparent = true
    vim.g.tokyonight_transparent_sidebar = true
    vim.g.tokyonight_style = 'storm'

    vim.api.nvim_command([[colorscheme tokyonight]])
end

config.gruvbox_material = function()
    vim.g.gruvbox_material_disable_italic_comment = 1
    vim.g.gruvbox_material_enable_bold = 1
    vim.g.gruvbox_material_enable_italic = 0
    vim.g.gruvbox_material_transparent_background = 1
    vim.g.gruvbox_material_better_performance = 1
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
            'symbols-outline'
        },
    })
end

config.nvim_tree = function()
    require('nvim-tree').setup({
        disable_netrw = true,
        hijack_netrw = true,
        open_on_setup = false,
        ignore_ft_on_setup = {},
        auto_close = true,
        open_on_tab = false,
        hijack_cursor = true,
        update_cwd = false,
        update_to_buf_dir = { enable = true, auto_open = true },
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
            auto_resize = false,
            mappings = { custom_only = false, list = {} },
            number = false,
            relativenumber = false,
            signcolumn = 'yes',
        },
        trash = { cmd = 'trash', require_confirm = true },
    })
end

config.nvim_bufferline = function()
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
        -- NOTE: disable italics to avoid render issue in windows terminal
        highlights = {
            buffer_selected = {
                gui = 'bold',
            },
            info_selected = {
                gui = 'bold',
            },
            hint_selected = {
                gui = 'bold',
            },
            warning_selected = {
                gui = 'bold',
            },
            error_selected = {
                gui = 'bold',
            },
            diagnostic_selected = {
                gui = 'bold',
            },
            info_diagnostic_selected = {
                gui = 'bold',
            },
            hint_diagnostic_selected = {
                gui = 'bold',
            },
            warning_diagnostic_selected = {
                gui = 'bold',
            },
            error_diagnostic_selected = {
                gui = 'bold',
            },
            pick_selected = {
                gui = 'bold',
            },
            duplicate_selected = {
                gui = 'bold',
            },
        },
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

return config

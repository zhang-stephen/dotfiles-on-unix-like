local config = {}

config.telescope = function()
    vim.api.nvim_command([[packadd sqlite.lua]])
    vim.api.nvim_command([[packadd telescope-fzf-native.nvim]])

    require('telescope').setup({
        defaults = {
            prompt_prefix = '🔭 ',
            selection_caret = '→ ',
            layout_config = {
                horizontal = {
                    prompt_position = 'bottom',
                    results_width = 0.6,
                },
                vertical = {
                    mirror = false,
                },
            },
            file_previewer = require('telescope.previewers').vim_buffer_cat.new,
            grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
            qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
            file_sorter = require('telescope.sorters').get_fuzzy_file,
            file_ignore_patterns = {},
            generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
            path_display = { 'absolute' },
            winblend = 0,
            border = {},
            borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
            color_devicons = true,
            use_less = true,
            set_env = {
                ['COLORTERM'] = 'truecolor',
            },
        },

        pickers = {},

        extensions = {
            fzf = {
                fuzzy = false, -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = 'smart_case', -- or 'ignore_case' or 'respect_case'
                -- the default case_mode is 'smart_case'
            },
        },
    })

    require('telescope').load_extension('fzf')
    require('telescope').load_extension('notify')
end

config.trouble = function()
    require('trouble').setup({
        position = 'bottom', -- position of the list can be: bottom, top, left, right
        height = 10, -- height of the trouble list when position is top or bottom
        width = 50, -- width of the list when position is left or right
        icons = true, -- use devicons for filenames
        mode = 'document_diagnostics', -- 'workspace_diagnostics', 'document_diagnostics', 'quickfix', 'lsp_references', 'loclist'
        fold_open = '', -- icon used for open folds
        fold_closed = '', -- icon used for closed folds
        action_keys = {
            -- key mappings for actions in the trouble list
            -- map to {} to remove a mapping, for example:
            -- close = {},
            close = 'q', -- close the list
            cancel = '<esc>', -- cancel the preview and get back to your last window / buffer / cursor
            refresh = 'r', -- manually refresh
            jump = '<tab>', -- jump to the diagnostic or open / close folds
            open_split = { '<c-x>' }, -- open buffer in new split
            open_vsplit = { '<c-v>' }, -- open buffer in new vsplit
            open_tab = { '<c-t>' }, -- open buffer in new tab
            jump_close = { '<CR>' }, -- jump to the diagnostic and close the list
            toggle_mode = 'm', -- toggle between 'workspace' and 'document' diagnostics mode
            toggle_preview = 'P', -- toggle auto_preview
            hover = 'K', -- opens a small popup with the full multiline message
            preview = 'p', -- preview the diagnostic location
            close_folds = { 'zM', 'zm' }, -- close all folds
            open_folds = { 'zR', 'zr' }, -- open all folds
            toggle_fold = { 'zA', 'za' }, -- toggle fold of current file
            previous = 'k', -- preview item
            next = 'j', -- next item
        },
        indent_lines = true, -- add an indent guide below the fold icons
        auto_open = false, -- automatically open the list when you have diagnostics
        auto_close = false, -- automatically close the list when you have no diagnostics
        auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
        auto_fold = false, -- automatically fold a file trouble list at creation
        signs = {
            -- icons / text used for a diagnostic
            error = '',
            warning = '',
            hint = '',
            information = '',
            other = '﫠',
        },
        use_lsp_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
    })
end

-- Sniprun

config.wilder = function()
    vim.api.nvim_command([[
            call wilder#setup({'modes': [':', '/', '?']})
            call wilder#set_option('use_python_remote_plugin', 0)
            call wilder#set_option('pipeline', [wilder#branch(wilder#cmdline_pipeline({'use_python': 0,'fuzzy': 1, 'fuzzy_filter': wilder#lua_fzy_filter()}),wilder#vim_search_pipeline(), [wilder#check({_, x -> empty(x)}), wilder#history(), wilder#result({'draw': [{_, x -> ' ' . x}]})])])
            call wilder#set_option('renderer', wilder#renderer_mux({':': wilder#popupmenu_renderer({'highlighter': wilder#lua_fzy_highlighter(), 'left': [wilder#popupmenu_devicons()], 'right': [' ', wilder#popupmenu_scrollbar()]}), '/': wilder#wildmenu_renderer({'highlighter': wilder#lua_fzy_highlighter()})}))
        ]])
end

config.legendary = function()
    require('legendary').setup({
        include_builtin = true,
        include_legendary_cmds = true,
    })
end

config.dressing = function()
    require('dressing').setup()
end

config.notify = function()
    local notify = require('notify')
    local notify_renderers = require('notify.render')

    notify.setup({
        stages = 'slide',
        timeout = 2000, -- 2.0s
        background_color = '#121212',
        fps = 60,
        render = function(bufnr, notif, ...)
            if notif.title[1] == '' then
                return notify_renderers.minimal(bufnr, notif, ...)
            else
                return notify_renderers.default(bufnr, notif, ...)
            end
        end,
    })

    -- NOTE: use Telescope as finder for notifications
    -- see config.telescope()

    -- try async notify as default notify method
    vim.notify = notify
end

return config

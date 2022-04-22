local event = {}
local definitions = {
    yank = {
        {
            'TextYankPost',
            '*',
            [[silent! lua vim.highlight.on_yank({higroup='IncSearch', timeout=300})]],
        },
    },

    ft = {
        { 'BufNewFile,BufRead', '*.toml', ' setf toml' },
        -- { 'FileType', 'make', 'set noexpandtab shiftwidth=8 softtabstop=0' },
        -- { 'FileType', 'c,cpp', 'set expandtab tabstop=2 shiftwidth=2' },
        {
            'FileType',
            'alpha',
            'set showtabline=0 | autocmd WinLeave <buffer> set showtabline=2',
        },
        {
            'FileType',
            '*',
            [[setlocal formatoptions-=c formatoptions-=r formatoptions-=o]],
        },
    },

    wins = {
        -- Check if file changed when its window is focus, more eager than 'autoread'
        { 'FocusGained', '* checktime' },
    },

    bufs = {
        { 'BufWritePre', '/tmp/*', 'setlocal noundofile' },
        { 'BufWritePre', 'COMMIT_EDITMSG', 'setlocal noundofile' },
        { 'BufWritePre', 'MERGE_MSG', 'setlocal noundofile' },
        { 'BufWritePre', '*.tmp', 'setlocal noundofile' },
        { 'BufWritePre', '*.bak', 'setlocal noundofile' },
        -- close nvim_tree.lua if it were the last window
        {
            'BufWritePre',
            '*',
            [[++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif]],
        },
        -- FIXME: raise E201/E434 when buffer changed, e.g. run `:h something`
        -- { 'BufEnter', '*', 'silent! lcd %:p:h' }, -- auto place to last edit
    },
}

event.nvim_create_augroups = function(defs)
    for group_name, definition in pairs(defs) do
        vim.api.nvim_command('augroup ' .. group_name)
        vim.api.nvim_command('autocmd!')
        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten({ 'autocmd!', def }), ' ')
            vim.api.nvim_command(command)
        end
        vim.api.nvim_command('augroup END')
    end
end

event.setup = function()
    event.nvim_create_augroups(definitions)
end

return event

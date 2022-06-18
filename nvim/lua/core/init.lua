local core = {
    config = {
        require('core.options'),
        require('core.plugins'),
        require('core.keymap'),
        require('core.event'),
    },
}

local is_nvim_compatible = function()
    return vim.fn.has('nvim-0.7')
end

core.copy_mode_toggle = function()
    if not _G.copy_wt then
        _G.copy_wt = true
        vim.api.nvim_command [[set nonumber norelativenumber signcolumn=no]]
    else
        _G.copy_wt = false
        vim.api.nvim_command [[set number relativenumber signcolumn=yes:2]]
    end

    vim.api.nvim_command [[IndentBlanklineToggle]]
end

function core.setup()
    if is_nvim_compatible() then
        for _, conf in ipairs(core.config) do
            conf.setup()
        end

        -- post-process or user-defined process after configuring
        -- TODO: refactor these code
        require('tasks').run()
    end

    vim.api.nvim_create_user_command('CopyModeToggle', [[:lua require('core').copy_mode_toggle()]], {})
end

return core

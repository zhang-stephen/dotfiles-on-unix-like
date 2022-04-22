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

function core.setup()
    if is_nvim_compatible() then
        for _, conf in ipairs(core.config) do
            conf.setup()
        end

        -- post-process or user-defined process after configuring
        -- TODO: refactor these code
        require('tasks').run()
    end
end

return core

local core = {
    config = {
        require('core.options'),
        require('core.plugins'),
        require('core.keymap'),
        require('core.event'),
    },
}

local is_nvim_compatible = function()
    return vim.fn.has('nvim-0.6')
end

function core.setup()
    if is_nvim_compatible() then
        for _, conf in ipairs(core.config) do
            conf.setup()
        end
    end

    vim.api.nvim_command [[colorscheme nightfox]]
end

return core

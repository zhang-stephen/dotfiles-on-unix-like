local core = {
    config = {
        require('core.options'),
        require('core.plugins'),
        require('core.keymap'),
        require('core.event')
    }
}

function core.setup()
    for _, conf in ipairs(core.config) do
        conf.setup()
    end

    vim.api.nvim_command [[ colorscheme catppuccin ]]
end

return core
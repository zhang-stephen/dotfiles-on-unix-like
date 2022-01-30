local core = {}


local dashboard_config = function()
    vim.g.dashboard_footer_icon = '🐬 '
    vim.g.dashboard_default_executive = 'telescope'

    vim.g.dashboard_custom_section = {
        change_colorscheme = {
            description = { ' Scheme change              <space> s c ' },
            command = 'DashboardChangeColorscheme',
        },
        find_frecency = {
            description = { ' File frecency              <space> f r ' },
            command = 'Telescope frecency',
        },
        find_history = {
            description = { ' File history               <space> f e ' },
            command = 'DashboardFindHistory',
        },
        find_project = {
            description = { ' Project find               <space> f p ' },
            command = 'Telescope project',
        },
        find_file = {
            description = { ' File find                  <space> f f ' },
            command = 'DashboardFindFile',
        },
        file_new = {
            description = { ' File new                   <space> f n ' },
            command = 'DashboardNewFile',
        },
        find_word = {
            description = { ' Word find                  <space> f w ' },
            command = 'DashboardFindWord',
        },
    }
end

function core.setup()
    require('core.options').setup()
    require('core.plugins').setup()
    require('core.keymap').setup()
    require('core.event').setup()
end

return core
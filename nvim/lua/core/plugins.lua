local Packer = {}
local log = require('utility.logger')

local nvim_data_path = vim.fn.stdpath('data') .. '/site'
-- local default_compiled = nvim_data_path .. '/packer_compiled.vim'
local default_compiled = nvim_data_path .. '/lua/_compiled.lua'
local optimized_compiled = nvim_data_path .. '/lua/_compiled.lua'
local packer = nil

local disable_distribution_plugins = function()
    vim.g.loaded_fzf = 1
    vim.g.loaded_gtags = 1
    vim.g.loaded_gzip = 1
    vim.g.loaded_tar = 1
    vim.g.loaded_tarPlugin = 1
    vim.g.loaded_zip = 1
    vim.g.loaded_zipPlugin = 1
    vim.g.loaded_getscript = 1
    vim.g.loaded_getscriptPlugin = 1
    vim.g.loaded_vimball = 1
    vim.g.loaded_vimballPlugin = 1
    vim.g.loaded_matchit = 1
    vim.g.loaded_matchparen = 1
    vim.g.loaded_2html_plugin = 1
    vim.g.loaded_logiPat = 1
    vim.g.loaded_rrhelper = 1
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    vim.g.loaded_netrwSettings = 1
    vim.g.loaded_netrwFileHandlers = 1
end


local plugins = setmetatable({}, {
    __index = function(_, key)
        if not packer then
            packer = require(Packer.manager.name)
        end
        return packer[key]
    end
})

local is_nvim_compatible = function()
    -- FIXME: method doesn't adapt to nvim 0.6+
    return vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1
end

Packer.bootstrap = function()
    Packer.manager = {
        name = 'packer',
        -- to mute the WARNING: use 'wbthomason/packer.nvim' for twice!
        path = vim.fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim',
        status = false,
        repo = 'wbthomason/packer.nvim'
    }

    if vim.fn.empty(vim.fn.glob(Packer.manager.path)) > 0 then
        local ret = vim.fn.system({'git', 'clone', '--depth', '1',
                                   string.format('https://github.com/%s', Packer.manager.repo), Packer.manager.path})

        Packer.manager.status = (ret ~= nil)
    else
        log.info('plugin manager has been initliazed...')
        Packer.manager.status = true
    end
end

Packer.setup = function()
    Packer.bootstrap()

    if not Packer.manager.status then
        log.error(string.format('[%s] load failed, neovim initialized failed!', Packer.manager.name))
        require('os').exit(-1)
    end

    -- CORE function to load all plugins
    local loading = function(use)
        use({
            'wbthomason/packer.nvim',
            opt = true
        })

        for group, modules in pairs(require('modules')) do
            for repo, spec in pairs(modules) do
                if spec then
                    use(vim.tbl_extend('force', {repo}, spec))
                else
                    use(repo)
                end
            end
        end
    end

    vim.cmd [[ packadd packer.nvim ]]

    packer = require(Packer.manager.name)
    packer.init({
        compile_path = default_compiled,
        max_job = 32,
        git = {
            clone_timeout = 120
        },
        disable_commands = true,
        display = {
            open_fn = function()
                return require('packer.util').float({
                    border = 'single'
                })
            end
        }
    })

    packer.reset()

    loading(packer.use)
    packer.install()
end

plugins.convert_compiled_to_lua = function()
    local lines = {}
    local lnum = 1
    lines[#lines + 1] = 'vim.cmd [[packadd packer.nvim]]\n'

    for line in io.lines(default_compiled) do
        lnum = lnum + 1
        if lnum > 15 then
            if line == 'END' then
                break
            end
            lines[#lines + 1] = line .. '\n'
        end
    end

    if vim.fn.isdirectory(nvim_data_path .. '/lua') ~= 1 then
        os.execute(string.format('mkdir -p %s/lua', nvim_data_path))
    end

    if vim.fn.filereadable(optimized_compiled) == 1 then
        os.rename(optimized_compiled, optimized_compiled .. '.bak')
    end

    local file = io.open(optimized_compiled, 'w')
    for _, line in ipairs(lines) do
        file:write(line)
    end
    file:close()

    os.remove(default_compiled)
end

function plugins.auto_compile()
     local file = vim.fn.expand("%:p")
     if file:match(modules_dir) then
          plugins.clean()
          plugins.compile()
     end
end


plugins.setup = function()
    disable_distribution_plugins()
    Packer.setup()
    plugins.compile()
    plugins.load_compile()
end

plugins.load_compile = function()
    if vim.fn.filereadable(optimized_compiled) == 1 then
        require('_compiled')
    else
        assert('Missing packer compile file Run PackerCompile Or PackerInstall to fix')
    end

    vim.cmd [[ command! PackerCompile lua require('core.plugins').user_compile() ]]
    vim.cmd [[ command! PackerInstall lua require('core.plugins').install() ]]
    vim.cmd [[ command! PackerUpdate lua require('core.plugins').update() ]]
    vim.cmd [[ command! PackerSync lua require('core.plugins').sync() ]]
    vim.cmd [[ command! PackerClean lua require('core.plugins').clean() ]]
    vim.cmd [[ command! PackerStatus lua require('core.plugins').status() ]]
end

return plugins

-- EOF

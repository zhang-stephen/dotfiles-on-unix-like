local log = require('utility.logger')
local bind = require('utility.keybinding')
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local loaded_plugins = nil

local keymap = {}

local no_plugin_loaded = function()
    if _G['packer_plugins'] == nil then return true
    else
        loaded_plugins = _G.packer_plugins
        return false
    end
end

keymap.set_mapleader = function()
    vim.g.mapleader = ' '
end

keymap.init = function ()
    keymap.set_mapleader()

    -- the keymap for nvim builtin features
    keymap.builtin = {
        -- tab switches
        ['n|<leader>1'] = map_cmd('1gt'),
        ['n|<leader>2'] = map_cmd('2gt'),
        ['n|<leader>3'] = map_cmd('3gt'),
        ['n|<leader>4'] = map_cmd('4gt'),
        ['n|<leader>5'] = map_cmd('5gt'),
        ['n|<leader>j'] = map_cmd('gt'),
        ['n|<leader>k'] = map_cmd('gT'),

        -- options for windows
        ['n|<C-h>'] = map_cmd('<C-w>h'),
        ['n|<C-j>'] = map_cmd('<C-w>j'),
        ['n|<C-k>'] = map_cmd('<C-w>k'),
        ['n|<C-l>'] = map_cmd('<C-w>l'),
        ['n|<A-[>'] = map_cr('vertical resize -5'):with_silent(),
        ['n|<A-]>'] = map_cr('vertical resize +5'):with_silent(),
        ['n|<A-;>'] = map_cr('resize -2'),
        ['n|<A-\'>'] = map_cr('resize +2'),
        ['n|<C-q>'] = map_cr('wq!'):with_silent(),

        -- edit
        ['n|Y'] = map_cmd('y$'),
        ['n|D'] = map_cmd('D$'),
        ['n|n'] = map_cmd('nzzzv'), -- n zz zv
        ['n|N'] = map_cmd('Nzzzv'), -- N zz zv

        -- command line
        ["c|<C-b>"] = map_cmd("<Left>"),
        ["c|<C-f>"] = map_cmd("<Right>"),
        ["c|<C-a>"] = map_cmd("<Home>"),
        ["c|<C-e>"] = map_cmd("<End>"),
        ["c|<C-d>"] = map_cmd("<Del>"),
        ["c|<C-h>"] = map_cmd("<BS>"),
        ["c|<C-t>"] = map_cmd([[<C-R>=expand("%:p:h") . "/" <CR>]]),
        ["c|w!!"] = map_cmd("execute 'silent! write !sudo tee % >/dev/null' <bar> edit!"),

        -- Visual
        ["v|J"] = map_cmd(":m '>+1<cr>gv=gv"),
        ["v|K"] = map_cmd(":m '<-2<cr>gv=gv"),
        ["v|<"] = map_cmd("<gv"),
        ["v|>"] = map_cmd(">gv"),
    }

    -- the keymap for features provided via plugins
    -- some keymap configured via field 'config' in specifications of packer.nvim, see modules/*/config
    keymap.plugins = {
        ['lspsaga.nvim'] = {}
    }
end

keymap.setup = function ()
    keymap.init()

    -- builtin keymap loading
    bind.nvim_load_mapping(keymap.builtin)

    if no_plugin_loaded() then
        return
    end

    log.debug('plugin_load: ', loaded_plugins ~= nil)

    for plugin, mapping in pairs(keymap.plugins) do
        -- load keymap if plugin loaded
        if loaded_plugins[plugin].loaded then
            bind.nvim_load_mapping(mapping)
        end
    end
end

return keymap
local bind = require('utility.keybinding')
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd

local keymap = {}

keymap.set_mapleader = function()
    vim.g.mapleader = ' ' -- use <space> as <leader>
end

keymap.init = function ()
    keymap.set_mapleader()

    local t = function(str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
    end

    _G.enhance_jk_move = function(key)
        local map = key == 'j' and '<Plug>(accelerated_jk_gj)' or '<Plug>(accelerated_jk_gk)'
        return t(map)
    end

    _G.enhance_ft_move = function(key)
        local map = {
            f = '<Plug>(eft-f)',
            F = '<Plug>(eft-F)',
            t = '<Plug>(eft-t)',
            T = '<Plug>(eft-T)',
            [';'] = '<Plug>(eft-repeat)',
        }
        return t(map[key])
    end

    _G.enhance_align = function(key)
        vim.cmd([[packadd vim-easy-align]])
        local map = { ['nga'] = '<Plug>(EasyAlign)', ['xga'] = '<Plug>(EasyAlign)' }
        return t(map[key])
    end

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
        ['c|<C-b>'] = map_cmd('<Left>'),
        ['c|<C-f>'] = map_cmd('<Right>'),
        ['c|<C-a>'] = map_cmd('<Home>'),
        ['c|<C-e>'] = map_cmd('<End>'),
        ['c|<C-d>'] = map_cmd('<Del>'),
        ['c|<C-h>'] = map_cmd('<BS>'),
        ['c|<C-t>'] = map_cmd [[<C-R>=expand('%:p:h') . '/' <CR>]],
        ['c|w!!'] = map_cmd [[execute 'silent! write !sudo tee % >/dev/null' <bar> edit!]],

        -- Visual
        ['v|J'] = map_cmd(':m \'>+1<cr>gv=gv'),
        ['v|K'] = map_cmd(':m \'<-2<cr>gv=gv'),
        ['v|<'] = map_cmd('<gv'),
        ['v|>'] = map_cmd('>gv'),
    }

    -- the keymap for features provided via plugins
    -- some keymap configured via field 'config' in specifications of packer.nvim, see modules/*/config
    keymap.plugins = {
        -- packer.nvim
        ['n|<leader>ps'] = map_cr('PackerSync'):with_silent():with_nowait(),
        ['n|<leader>pu'] = map_cr('PackerUpdate'):with_silent():with_nowait(),
        ['n|<leader>pi'] = map_cr('PackerInstall'):with_silent():with_nowait(),
        ['n|<leader>pc'] = map_cr('PackerClean'):with_silent():with_nowait(),

        -- nvim-lspconfig, nvim-lspinstaller, lspsaga, nvim-lsp, ...
        ['n|<leader>li'] = map_cr('LspInfo'):with_silent():with_nowait(),
        ['n|<leader>lr'] = map_cr('LspRestart'):with_silent():with_nowait(),
        ['n|g['] = map_cr('Lspsaga diagnostic_jump_next'):with_silent(),
        ['n|g]'] = map_cr('Lspsaga diagnostic_jump_prev'):with_silent(),
        ['n|gs'] = map_cr('Lspsaga signature_help'):with_silent(),
        ['n|<leader>rn'] = map_cr('Lspsaga rename'):with_silent(),
        ['n|K'] = map_cr('Lspsaga hover_doc'):with_silent(),
        ['n|<C-Up>'] = map_cr [[lua require('lspsaga.action').smart_scroll_with_saga(-1)]]:with_silent(),
        ['n|<C-Down>'] = map_cr [[lua require('lspsaga.action').smart_scroll_with_saga(1)]]:with_silent(),
        ['n|<leader>ca'] = map_cr('Lspsaga code_action'):with_silent(),
        ['v|<leader>ca'] = map_cu('Lspsaga range_code_action'):with_silent(),
        ['n|gd'] = map_cr('Lspsaga preview_definition'):with_silent(),
        ['n|gD'] = map_cr('lua vim.lsp.buf.definition()'):with_silent(),
        ['n|gr'] = map_cr('lua vim.lsp.buf.references()'):with_silent(),

        -- SymbolsOutline
        ['n|<leader>o'] = map_cu('SymbolsOutline'):with_silent(),

        -- Trouble
        ['n|gt'] = map_cr('TroubleToggle'):with_silent(),
        ['n|gR'] = map_cr('TroubleToggle lsp_references'):with_silent(),
        ['n|<leader>cd'] = map_cr('TroubleToggle lsp_document_diagnostics'):with_silent(),
        ['n|<leader>cw'] = map_cr('TroubleToggle lsp_workspace_diagnostics'):with_silent(),
        ['n|<leader>cq'] = map_cr('TroubleToggle quickfix'):with_silent(),
        ['n|<leader>cl'] = map_cr('TroubleToggle loclist'):with_silent(),

        -- nvim-comment
        ['n|<A-/>'] = map_cr('CommentToggle'):with_silent(),

        -- Hop
        ['n|<leader>w'] = map_cu('HopWord'),
        ['n|<leader>j'] = map_cu('HopLine'),
        ['n|<leader>k'] = map_cu('HopLine'),
        ['n|<leader>c'] = map_cu('HopChar1'),
        ['n|<leader>cc'] = map_cu('HopChar2'),

        -- accelerate-jk
        ['n|j'] = map_cmd [[v:lua.enhance_jk_move('j')]]:with_silent():with_expr(),
        ['n|k'] = map_cmd [[v:lua.enhance_jk_move('k')]]:with_silent():with_expr(),

        -- vim-eft
        ['n|f'] = map_cmd [[v:lua.enhance_ft_move('f')]]:with_expr(),
        ['n|F'] = map_cmd [[v:lua.enhance_ft_move('F')]]:with_expr(),
        ['n|t'] = map_cmd [[v:lua.enhance_ft_move('t')]]:with_expr(),
        ['n|T'] = map_cmd [[v:lua.enhance_ft_move('T')]]:with_expr(),
        ['n|;'] = map_cmd [[v:lua.enhance_ft_move(';')]]:with_expr(),

        -- Plugin EasyAlign
        ['n|ga'] = map_cmd [['v:lua.enhance_align('nga')]]:with_expr(),
        ['x|ga'] = map_cmd [[v:lua.enhance_align('xga')]]:with_expr(),

        -- bufferline
        ['n|gb'] = map_cr('BufferLinePick'):with_silent(),
        ['n|<A-j>'] = map_cr('BufferLineCycleNext'):with_silent(),
        ['n|<A-k>'] = map_cr('BufferLineCyclePrev'):with_silent(),
        ['n|<leader>be'] = map_cr('BufferLineSortByExtension'),
        ['n|<leader>bd'] = map_cr('BufferLineSortByDirectory'),
        ['n|<A-1>'] = map_cr('BufferLineGoToBuffer 1'):with_silent(),
        ['n|<A-2>'] = map_cr('BufferLineGoToBuffer 2'):with_silent(),
        ['n|<A-3>'] = map_cr('BufferLineGoToBuffer 3'):with_silent(),
        ['n|<A-4>'] = map_cr('BufferLineGoToBuffer 4'):with_silent(),
        ['n|<A-5>'] = map_cr('BufferLineGoToBuffer 5'):with_silent(),
        ['n|<A-6>'] = map_cr('BufferLineGoToBuffer 6'):with_silent(),
        ['n|<A-7>'] = map_cr('BufferLineGoToBuffer 7'):with_silent(),
        ['n|<A-8>'] = map_cr('BufferLineGoToBuffer 8'):with_silent(),
        ['n|<A-9>'] = map_cr('BufferLineGoToBuffer 9'):with_silent(),

        -- nvim-tree
        ['n|<leader>e'] = map_cr('NvimTreeToggle'):with_silent(),
        ['n|<Leader>ef'] = map_cr('NvimTreeFindFile'):with_silent(),
        ['n|<Leader>er'] = map_cr('NvimTreeRefresh'):with_silent(),

        -- auto-session
        ['n|<leader>ss'] = map_cu('SaveSession'):with_silent(),
        ['n|<leader>sr'] = map_cu('RestoreSession'):with_silent(),
        ['n|<leader>sd'] = map_cu('DeleteSesion'):with_silent(),

        -- Plugin split-term
        ['n|<C-w>t'] = map_cr('VTerm'):with_silent(),
    }
end

keymap.setup = function ()
    keymap.init()
    bind.nvim_load_mapping(keymap.builtin)
    bind.nvim_load_mapping(keymap.plugins)
end

return keymap

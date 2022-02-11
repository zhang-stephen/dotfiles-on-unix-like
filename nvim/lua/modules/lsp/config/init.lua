local log = require('utility.logger')
local conf = {}

conf.lspconfig = function()
    local lsp = require('lspconfig')
    local util = require('lspconfig.util')
    local installer = require('nvim-lsp-installer')
    local capabilities = require('vim.lsp.protocol').make_client_capabilities()

    -- register a global command to Format the buffer
    -- just like coc.nvim
    vim.api.nvim_command([[command! -nargs=0 Format lua vim.lsp.buf.formatting()]])

    local enhance_server_opts = {
        ['ccls'] = {
            init_options = {
                compilationDatabaseDirectory = './',
                index = {
                    threads = 12,
                    comments = 2,
                },
                clang = {
                    includeArgs = { '-isystem' },
                    excludeArgs = { '-m*', '-flto*', '-W*', '-frounding-math' },
                },
                cache = {
                    directory = vim.env['HOME'] .. '/.cache/ccls/',
                    format = 'binary',
                    -- retainInMemory = 2,
                },
            },
            root_dir = util.root_pattern('.git', '.ccls', 'compile_commands.json'),
            -- single_file_support = true, -- seems not support ccls, try clangd in the future
        },

        ['sumneko_lua'] = function(opts)
            opts.settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim', 'packer_plugins' },
                    },
                    workspace = {
                        library = {
                            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                            [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                        },
                        maxPreload = 100000,
                        preloadFileSize = 10000,
                    },
                    telemetry = {
                        enable = false,
                    },
                },
            }
        end,

        ['jsonls'] = function(opts)
            opts.settings = {
                json = {
                    schemas = {
                        {
                            fileMatch = { 'package.json' },
                            url = 'https://json.schemastore.org/package.json',
                        },
                    },
                },
            }
        end,

        'bashls',
        'cmake',
        'pyright',
        'taplo',
        'vimls',
        'lemminx',
        'yamlls',
    }

    installer.settings({
        ui = {
            icons = {
                server_installed = '✓',
                server_pending = '➜',
                server_uninstalled = '✗',
            },
        },
    })

    local custom_attach = function()
        require('lsp_signature').on_attach({
            bind = true,
            use_lspsaga = false,
            floating_window = true,
            fix_pos = true,
            hint_enable = true,
            hi_parameter = 'Search',
            handler_opts = { 'double' },
        })
    end

    local server_ready = function(server)
        local opts = {
            capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities),
            on_attach = custom_attach,
            flags = {
                debounce_text_changes = 300,
            },
        }

        if enhance_server_opts[server.name] then
            enhance_server_opts[server.name](opts)
        end

        server:setup(opts)
    end

    for server, config in pairs(enhance_server_opts) do
        if type(config) == 'table' then
            if lsp[server] then
                lsp[server].setup(config)
            else
                log.error(string.format('nvim-lspconfig not support: %s', server))
            end
        elseif type(config) == 'function' or type(config) == 'nil' then
            local available, managed = require('nvim-lsp-installer.servers').get_server(server)
            if available then
                if managed:is_installed() then
                    managed:on_ready(server_ready)
                else
                    managed:install()
                end
            else
                log.error(string.format('unknown server: %s', server))
            end
        end
    end
end

conf.lspsaga = function()
    require('lspsaga').init_lsp_saga({
        error_sign = '',
        warn_sign = '',
        hint_sign = '',
        infor_sign = '',
    })
end

conf.lsputil = function()
    vim.lsp.handlers['textDocument/codeAction'] = require('lsputil.codeAction').code_action_handler
    vim.lsp.handlers['textDocument/references'] = require('lsputil.locations').references_handler
    vim.lsp.handlers['textDocument/definition'] = require('lsputil.locations').definition_handler
    vim.lsp.handlers['textDocument/declaration'] = require('lsputil.locations').declaration_handler
    vim.lsp.handlers['textDocument/typeDefinition'] = require('lsputil.locations').typeDefinition_handler
    vim.lsp.handlers['textDocument/implementation'] = require('lsputil.locations').implementation_handler
    vim.lsp.handlers['textDocument/documentSymbol'] = require('lsputil.symbols').document_handler
    vim.lsp.handlers['workspace/symbol'] = require('lsputil.symbols').workspace_handler
end

conf.lightbulb = function()
    vim.api.nvim_command([[ autocmd CursorHold,CursorHoldI * lua require('nvim-lightbulb').update_lightbulb() ]])
end

conf.cmp = require('modules.lsp.config.cmp')

conf.autopairs = function()
    require('nvim-autopairs').setup({})

    -- If you want insert `(` after select function or method item
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    local cmp = require('cmp')
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))
    cmp_autopairs.lisp[#cmp_autopairs.lisp + 1] = 'racket'
end

return conf

-- EOF

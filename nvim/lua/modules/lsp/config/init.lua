local log = require('utility.logger')
local conf = {}

conf.lspconfig = function()
    local lsp = require('lspconfig')
    local util = require('lspconfig.util')
    local installer = require('nvim-lsp-installer')
    local capabilities = require('vim.lsp.protocol').make_client_capabilities()

    local custom_attach = function(client, bufnr)
        require('lsp_signature').on_attach({
            bind = true,
            use_lspsaga = false,
            floating_window = true,
            fix_pos = true,
            hint_enable = true,
            hi_parameter = 'Search',
            handler_opts = { 'double' },
        })

        require('aerial').on_attach(client, bufnr)
    end

    -- register a global command to Format the buffer
    -- just like coc.nvim
    vim.api.nvim_command([[command! -nargs=0 Format lua vim.lsp.buf.formatting()]])

    local enhance_server_opts = {
        ['ccls'] = {
            -- the default configurations
            -- create .ccls under project root rather than modify lua code if you want to customize it
            -- refers to: https://github.com/MaskRay/ccls/wiki/Project-Setup#ccls-file
            -- use `ln -sf` to place compile_commands.json into project root dir
            init_options = {
                compilationDatabaseDirectory = './',
                index = {
                    threads = 12,
                    comments = 2,
                },
                clang = {
                    extraArgs = {},
                    excludeArgs = { '-m*', '-flto*', '-W*', '-frounding-math' },
                },
                cache = {
                    directory = vim.env['HOME'] .. '/.cache/ccls/',
                    format = 'binary',
                },
            },
            root_dir = util.root_pattern('.git/', '.ccls', 'compile_commands.json'),
            on_attach = custom_attach,
        },

        -- lsp servers managed by nvim-lsp-installer
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
                    completion = {
                        keywordSnippet = 'Disable',
                        callSnippet = 'Disable',
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

        ['bashls'] = function(opts)
            opts.settings = {}
        end,

        ['cmake'] = function(opts)
            opts.settings = {}
        end,

        -- python3
        ['pyright'] = function(opts)
            opts.settings = {}
        end,

        -- toml
        ['taplo'] = function(opts)
            opts.settings = {}
        end,

        ['vimls'] = function(opts)
            opts.settings = {}
        end,

        -- xml
        ['lemminx'] = function(opts)
            opts.settings = {}
        end,

        -- yaml
        ['yamlls'] = function(opts)
            opts.settings = {}
        end,
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
        elseif type(config) == 'function' then
            local available, managed = require('nvim-lsp-installer.servers').get_server(server)
            if available then
                if managed:is_installed() then
                    managed:on_ready(server_ready)
                else
                    managed:install()
                end
            else
                log.error(string.format('unknown server for nvim-lspinstaller: %s', server))
            end
        else
            log.error(string.format('unsupport config for %s', server))
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
    require('cmp').event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))
    cmp_autopairs.lisp[#cmp_autopairs.lisp + 1] = 'racket'
end

return conf

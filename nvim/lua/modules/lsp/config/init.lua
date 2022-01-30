local log = require('utility.logger')
local conf = {}

-- override the default settings of servers

local custom_attach = function(client)
    require('lsp_signature').on_attach({
        bind = true,
        use_lspsaga = false,
        floating_window = true,
        fix_pos = true,
        hint_enable = true,
        hi_parameter = 'Search',
        handler_opts = {'double'}
    })

    -- if client.resolved_capabilities.document_formatting then
    --     vim.cmd([[augroup Format]])
    --     vim.cmd([[autocmd! * <buffer>]])
    --     vim.cmd([[autocmd BufWritePost <buffer> lua require'modules.completion.formatting'.format()]])
    --     vim.cmd([[augroup END]])
    -- end
end

conf.lspconfig = function()
    require('lspconfig').ccls.setup {
        init_options = {
            compilationDatabaseDirectory = 'build',
            index = {
                threads = 0
            },
            clang = {
                excludeArgs = {'-frounding-math'}
            }
        }
    }
end

conf.lspinstaller = function()
    local enhance_server_opts = {
        ['sumneko_lua'] = function(opts)
            opts.settings = {
                Lua = {
                    diagnostics = {
                        globals = {'vim', 'packer_plugins'}
                    },
                    workspace = {
                        library = {
                            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                            [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
                        },
                        maxPreload = 100000,
                        preloadFileSize = 10000
                    },
                    telemetry = {
                        enable = false
                    }
                }
            }
        end,

        'pyright',

        ['jsonls'] = function(opts)
            opts.settings = {
                json = {
                    schemas = {{
                        fileMatch = {'package.json'},
                        url = 'https://json.schemastore.org/package.json'
                    },}
                }
            }
        end
    }

    local installer = require('nvim-lsp-installer')
    local capabilities = require('vim.lsp.protocol').make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

    installer.settings({
        ui = {
            icons = {
                server_installed = '✓',
                server_pending = '➜',
                server_uninstalled = '✗'
            }
        }
    })

    for server_name, options in pairs(enhance_server_opts) do
        local server_available, server = require('nvim-lsp-installer.servers').get_server(server_name)
        if server_available then
            server:on_ready(function(server)
                local opts = {
                    capabilities = capabilities,
                    flags = {
                        debounce_text_changes = 500
                    },
                    on_attach = custom_attach
                }

                if enhance_server_opts[server.name] then
                    enhance_server_opts[server.name](opts)
                end

                server:setup(opts)
            end)
            if not server:is_installed() then
                server:install()
            end
        end
    end
end

conf.lspsaga = function()
    require('lspsaga').init_lsp_saga({
        error_sign = '',
        warn_sign = '',
        hint_sign = '',
        infor_sign = ''
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
    vim.cmd [[ autocmd CursorHold,CursorHoldI * lua require('nvim-lightbulb').update_lightbulb() ]]
end

conf.cmp = require('modules.lsp.config.cmp')

return conf

-- EOF

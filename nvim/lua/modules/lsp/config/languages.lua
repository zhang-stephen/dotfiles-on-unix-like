local log = require('utility.logger')

return function()
    local lsp = require('lspconfig')
    local util = require('lspconfig.util')
    local installer = require('nvim-lsp-installer')
    local capabilities = require('vim.lsp.protocol').make_client_capabilities()
    local servers_path = vim.fn.stdpath('data') .. '/lsp_servers'

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

        -- add hover diagnostic after nvim 0.7
        vim.api.nvim_create_autocmd('CursorHold', {
            buffer = bufnr,
            callback = function()
                vim.diagnostic.open_float({
                    focusable = false,
                    close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
                    border = 'rounded',
                    source = 'always',
                    prefix = ' ',
                    scope = 'cursor',
                })
            end,
        })
    end

    -- register a global command to Format the buffer
    -- just like coc.nvim
    -- TODO:use a universial method to replace this command.
    vim.api.nvim_command([[command! -nargs=0 Format lua vim.lsp.buf.formatting()]])

    -- language servers managed by nvim-lsp-installer
    local servers = {
        ['sumneko_lua'] = {
            settings = {
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
            },
            cmd = {
                string.format('%s/sumneko_lua/extension/server/bin/lua-language-server', servers_path),
            },
        },

        ['jsonls'] = {
            settings = {
                json = {
                    schemas = {
                        {
                            fileMatch = { 'package.json' },
                            url = 'https://json.schemastore.org/package.json',
                        },
                    },
                },
            },
            cmd = {
                string.format('%s/jsonls/node_modules/.bin/vscode-json-language-server', servers_path),
                string.format('%s/jsonls/node_modules/.bin/vscode-eslint-language-server', servers_path),
                string.format('%s/jsonls/node_modules/.bin/vscode-html-language-server', servers_path),
                string.format('%s/jsonls/node_modules/.bin/vscode-css-language-server', servers_path),
            },
        },

        ['bashls'] = {
            cmd = {
                string.format('%s/bash/node_modules/.bin/bash-language-server', servers_path),
            }
        },

        ['cmake'] = {},

        -- python3
        ['pyright'] = {
            cmd = {
                string.format('%s/python/node_modules/.bin/pyright-langserver', servers_path),
            }
        },

        -- toml
        ['taplo'] = {},

        ['vimls'] = {},

        -- xml
        ['lemminx'] = {},

        -- yaml
        ['yamlls'] = {},
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

    for server, config in pairs(servers) do
        local available, managed = installer.get_server(server)
        if available then
            if not managed:is_installed() then
                managed:install()
            end

            -- add common options for each server
            config['capabilities'] = require('cmp_nvim_lsp').update_capabilities(capabilities)
            config['on_attach'] = custom_attach
            config['flags'] = {
                debounce_text_changes = 300,
            }

            lsp[server].setup(config)
        else
            log.error(string.format('unknown server for nvim-lspinstaller: %s', server))
        end
    end

    local c_cpp_servers = {
        ['clangd'] = {
            -- users might have to create `.clangd` under the root path of projects to configure it
            -- see https://clangd.llvm.org/config
            cmd = {
                'clangd',
                '--log=error',
                '--background-index',
                '--clang-tidy',
                '--header-insertion=iwyu',
                '-j=12',
                '--pch-storage=memory',
                '--malloc-trim',
                '--enable-config',
            },
            on_attach = custom_attach,
            root_dir = util.root_pattern('.git/', '.clangd', 'compile_commands.json'),
            single_file_support = true,
            capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities),
        },

        ['ccls'] = {
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
            capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities),
            on_attach = custom_attach,
        },
    }

    local selected = vim.env['LSP_USE_LLVM_CLANGD'] and 'clangd' or 'ccls'
    lsp[selected].setup(c_cpp_servers[selected])
end

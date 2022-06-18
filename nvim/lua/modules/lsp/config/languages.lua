local log = require('utility.logger')

return function()
    local lsp = require('lspconfig')
    local util = require('lspconfig.util')
    local installer = require('nvim-lsp-installer')
    local capabilities = require('vim.lsp.protocol').make_client_capabilities()

    local executable = function(bin)
        local servers_path = vim.fn.stdpath('data') .. '/lsp_servers'
        return string.format(servers_path .. '/%s', bin);
    end

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
                    runtime = {
                        version = 'Lua 5.1',
                    },
                },
            },
            cmd = {
                executable('sumneko_lua/extension/server/bin/lua-language-server');
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
                executable('jsonls/node_modules/.bin/vscode-json-language-server'),
                executable('jsonls/node_modules/.bin/vscode-eslint-language-server'),
                executable('jsonls/node_modules/.bin/vscode-html-language-server'),
                executable('jsonls/node_modules/.bin/vscode-css-language-server'),
            },
        },

        ['bashls'] = {
            cmd = {
                executable('bash/node_modules/.bin/bash-language-server'),
            }
        },

        ['cmake'] = {
            cmd = {
                executable('cmake/venv/bin/cmake-language-server'),
            },
        },

        -- python3
        ['pyright'] = {
            cmd = {
                executable('python/node_modules/.bin/pyright-langserver'),
            }
        },

        -- toml
        ['taplo'] = {
            cmd = {
                executable('taplo/taplo_lsp'),
            },
        },

        ['vimls'] = {
            cmd = {
                executable('vim/node_modules/.bin/vim-language-server'),
            },
        },

        -- xml
        ['lemminx'] = {
            cmd = {
                executable('lemminx/lemminx'),
            },
        },

        -- yaml
        ['yamlls'] = {
            cmd = {
                executable('yaml/node_modules/.bin/yaml-language-server'),
            },
        },
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

    local which_c_cpp_server = function()
        -- default c/c++ language server is MaskRay/ccls
        -- only use llvm/clangd if one of following conditions is fulfilled:
        -- 1. if environment variable `LSP_USE_LLVM_CLANGD`were set,
        -- 2. single file mode(ccls doesn't support single file mode)
        -- 3. if .clangd exists in project root but .ccls doesn't exist
        local start_path = vim.api.nvim_buf_get_name(0)

        -- TODO: return nil if start_path is not filetype of  c/c++/obj-c.
        -- HACK: need more verification, e.g. first buffer is not c/c++/obj-c but the second on is. I'm not sure what will happen.

        local root_dir = util.root_pattern('.git/', '.ccls', '.clangd', 'compile_commands.json')(start_path)

        if vim.env['LSP_USE_LLVM_CLANGD'] then return 'clangd' end

        if root_dir == nil then
            return 'clangd'
        else
            if not vim.fn.filereadable(string.format('%s/.ccls', root_dir)) then
                return 'clangd'
            end
        end

        return 'ccls'
    end

    -- C/C++ language servers aren't managed by nvim-lsp-installer
    -- TODO: integrate ccls into modules.lsp
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

    local selected = which_c_cpp_server()
    lsp[selected].setup(c_cpp_servers[selected])
end

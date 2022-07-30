local log = require('utility.logger')
local conf = {}

conf.mason = function()
    require('mason').setup({
        ui = {
            icons = {
                server_installed = '✓',
                server_pending = '➜',
                server_uninstalled = '✗',
            },
        },
    })
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

conf.lsp_loader = function()
    require('nvim-lsp-loader').setup({
        mode = 'user-first',
        default_config_path = vim.env['HOME'] .. '/.config/nvim/languages.json',
        nested_json_keys = true,

        on_attach = function(client, bufnr)
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
        end,

        make_capabilities = function()
            local capabilities = require('vim.lsp.protocol').make_client_capabilities()
            return require('cmp_nvim_lsp').update_capabilities(capabilities)
        end,
    })
end

conf.cmp = require('modules.lsp.config.completion')

conf.luasnip = function()
    require('luasnip').config.set_config({
        history = true,
        updateevents = 'TextChanged,TextChangedI',
    })
    require('luasnip/loaders/from_vscode').load()
end

conf.autopairs = function()
    require('nvim-autopairs').setup({})

    -- If you want insert `(` after select function or method item
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    require('cmp').event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))
end

return conf

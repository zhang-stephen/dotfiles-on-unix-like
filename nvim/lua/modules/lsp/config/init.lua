local log = require('utility.logger')
local conf = {}

conf.lspconfig = require('modules.lsp.config.languages')

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

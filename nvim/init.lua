-- the entry point for neovim configuration in lua5.1/luaJIT

-- logger initialized, config avalible:
require('utility.logger').init(vim.log.levels.WARN)

require('core').setup()

-- EOF

-- the entry point for neovim configuration in lua5.1/luaJIT

-- logger initialized, config avalible:
-- 'DBG', 'INF', 'WRN', 'ERR', 'OFF'(disable all logs)
-- should be configured as OFF except debugging
require('utility.logger').init('DBG')

require('core').setup()

-- EOF
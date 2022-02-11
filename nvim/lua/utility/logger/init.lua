local logger = {}

local levels = {
    DBG = 0,
    INF = 1,
    WRN = 2,
    ERR = 3,
    OFF = 0xff,
}

local level_string2int = function(level)
    for k, v in pairs(levels) do
        if level == k then
            return v
        end
    end

    return 0xff
end

logger.init = function(level)
    logger.level = level
end

logger.emit = function(level, ...)
    if level_string2int(logger.level) > level_string2int(level) then
        return
    end

    print(string.format('[%s]: ', level), ...)
end

logger.debug = function(...)
    logger.emit('DBG', ...)
end

logger.info = function(...)
    logger.emit('INF', ...)
end

logger.warning = function(...)
    logger.emit('WRN', ...)
end

logger.error = function(...)
    logger.emit('ERR', ...)
end

return logger

-- EOF

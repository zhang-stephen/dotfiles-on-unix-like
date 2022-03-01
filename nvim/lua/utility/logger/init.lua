local logger = {}

logger.init = function(level)
    logger.level = level
end

logger.emit = function(msg, level, opts)
    if logger.level > level then
        return
    end

    vim.notify(msg, level, opts)
end

logger.debug = function(msg)
    logger.emit(msg, vim.log.levels.DEBUG)
end

logger.info = function(msg)
    logger.emit(msg, vim.log.levels.INFO)
end

logger.warning = function(msg)
    logger.emit(msg, vim.log.levels.WARN)
end

logger.error = function(msg)
    logger.emit(msg, vim.log.levels.ERROR)
end

return logger

-- EOF

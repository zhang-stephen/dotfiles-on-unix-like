local log = require('utility.logger')

local M = {
    worker = nil,
    tasks = require('tasks.components'),
}

local check_deps = function(deps)
    for _, dep in ipairs(deps) do
        local available, _ = pcall('require', dep)
        if available == nil then
            return false
        end
    end

    return true
end

M.init = function()
    local has_async, pasync = pcall(require, 'plenary.async')

    if has_async then
        M.worker = pasync
    end
end

M.run = function()
    M.init()

    if M.worker == nil then
        log.warning('Cannot find module plenary.async!')
        return false
    end

    for _, task in pairs(M.tasks) do
        if check_deps(task.deps) then
            if type(task.exec) == 'function' then
                M.worker.run(task.exec)
            end
        end
    end

    return true
end

return M

countdownTime = 0

return {
    split = function(inputstr, sep)
        if sep == nil then
            sep = '%s'
        end
        local t = {}
        for str in string.gmatch(inputstr, '([^' .. sep .. ']+)')
        do
            table.insert(t, str)
        end
        return t
    end,

    timer = function(dt, secs, func)
        countdownTime = countdownTime - dt
        if countdownTime <= 0 then
            func()
            countdownTime = countdownTime + secs
        end
    end
}

return {
    load = function()
        car = Car()
    end,

    update = function(dt, data)
        -- if data == nil then
        --     return
        -- end

        car:update(dt, data)
    end,

    draw = function()
        love.graphics.setBackgroundColor(0.13, 0.13, 0.13)
        car:draw()
    end
}

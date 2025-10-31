local tick = require 'tick'
local socket = require "socket"
local udp

Class = require 'class'
require "entities/car"
require "entities/road/road"

function love.load(filtered_args, args)
    -- love.window.setFullscreen(true)
    love.window.setMode(1024, 600)
    love.window.setVSync(-1)
    tick.framerate = 59

    -- Leer configuración desde archivo
    local success, config = pcall(require, "config")
    if not success then
        print("No se encontró el archivo config.lua:", config)
        config = {}
    end
    if config.port then
        print("Port from config:", config.port)
    else
        print("No se especificó el puerto. Usando valor por defecto 12345")
        config.port = 12345
    end

    -- Socket UDP
    udp = socket.udp()
    udp:setoption("reuseaddr", true)
    local success, err = udp:setsockname("*", config.port)
    if not success then
        print("Error al enlazar socket: ", err)
    else
        print("Escuchando...")
    end
    udp:settimeout(0) -- para que no bloquee el hilo principal

    -- Inicialización de objetos
    road = Road()
    car = Car()
end

function love.update(dt)
    -- print(love.timer.getFPS())

    while true do
        local data = udp:receive(20)

        -- print(data)

        if data then
            car:update(dt, data)
        else
            -- Salir del bucle para no bloquear el thread
            break
        end
    end

    -- Actualizar objetos
    road:update(dt)
    car:update(dt, nil)
end

function love.draw()
    -- Dibujar objetos
    road:draw()
    car:draw()
end

function love.keypressed(key, scancode, isrepeat)
    if key == "q" then
        udp:close()
        love.event.quit()
    end

    if key == "down" then
        road:curveRight("easy")
    end

    if key == "up" then
        road:curveLeft("easy")
    end

    if key == "left" then
        road:curveLeft("hard")
    end

    if key == "right" then
        road:curveRight("hard")
    end
end

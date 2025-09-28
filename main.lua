local tick = require 'tick'
local socket = require "socket"
local udp

-- Efectos disponibles
local standby = require("effects/standby/standby")
local carrera = require("effects/carrera/carrera")

local utils = require "utils/utils"
Class = require 'class'
require "effects/carrera/car"

function love.load(filtered_args, args)
    -- love.window.setFullscreen(true)
    tick.framerate = 60

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

    carrera.load()
end

function love.update(dt)
    print(love.timer.getFPS())
    while true do
        local data = udp:receivefrom()

        if data then
            carrera.update(dt, data)
        else
            -- Salir del bucle si no hay más mensajes para no bloquear el thread
            break
        end
    end
    carrera.update(dt, nil)
end

function love.draw()
    carrera.draw()
end

function love.keypressed(key, scancode, isrepeat)
    if key == "q" then
        love.event.quit()
    end
end

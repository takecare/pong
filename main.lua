WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

DEFAULT_FONT_HEIGHT = 6

push = require 'push'

--[[
    Runs when the game first starts up, only once; used to initialize the game.
]]
function love.load()
    -- 
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true, -- debugging only
        vsync = true
    })

    love.graphics.setDefaultFilter('nearest', 'nearest')
end

function love.update()
    -- TODO
end

-- Called after update by LÖVE2D, used to draw anything to the screen, updated or otherwise.
function love.draw()
    love.graphics.printf('Hello Pong!', 10, 10, WINDOW_WIDTH, 'left') -- can take up whole width
    
    push:apply('start')
    -- love.graphics.rectangle('fill', 10, 10, 100, 100)
    love.graphics.printf('Hello Pong!', 10, 10, VIRTUAL_WIDTH, 'left')
    push:apply('end')
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

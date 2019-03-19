WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_WIDTH = 5
PADDLE_HEIGHT = 20
BALL_SIZE = 5

DEFAULT_FONT_HEIGHT = 6

push = require 'push'

--[[
    Runs when the game first starts up, only once; used to initialize the game.
]]
function love.load()
    -- load new font
    font = love.graphics.newFont('font.ttf', 8)
    love.graphics.setFont(font)

    -- setup push library (allows to render in virtual rez)
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true, -- debugging only
        vsync = true
    })

    -- 
    love.graphics.setDefaultFilter('nearest', 'nearest')
end

function love.update()
    -- TODO
end

-- Called after update by LÖVE2D, used to draw anything to the screen, updated or otherwise.
function love.draw()
    -- love.graphics.clear(0.1, 0, 0, 0)

    love.graphics.printf('Hello Pong!', 10, 10, WINDOW_WIDTH, 'left') -- can take up whole width
    
    push:apply('start')
    -- love.graphics.setColor(0, 0, 1, 0)
    
    -- left paddle
    love.graphics.rectangle('fill', PADDLE_WIDTH * 2, VIRTUAL_HEIGHT / 2 - (PADDLE_HEIGHT / 2), 5, 20)

    -- right paddle
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - PADDLE_WIDTH * 3, VIRTUAL_HEIGHT / 2 - (PADDLE_HEIGHT / 2), 5, 20)

    -- ball
    love.graphics.rectangle('fill', VIRTUAL_WIDTH/2 - (BALL_SIZE/2), VIRTUAL_HEIGHT/2 - (BALL_SIZE/2), BALL_SIZE, BALL_SIZE)

    love.graphics.printf('p o n g', 0, 5, VIRTUAL_WIDTH, 'center')
    push:apply('end')
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

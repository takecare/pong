WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_WIDTH = 5
PADDLE_HEIGHT = 20
PADDLE_SPEED = 200
BALL_SIZE = 5

DEFAULT_FONT_HEIGHT = 6

player1score = 0
player1pos = VIRTUAL_HEIGHT / 2 - (PADDLE_HEIGHT / 2)
player2score = 0
player2pos = VIRTUAL_HEIGHT / 2 - (PADDLE_HEIGHT / 2)

ballX = VIRTUAL_WIDTH/2 - (BALL_SIZE/2)
ballY = VIRTUAL_HEIGHT/2 - (BALL_SIZE/2)

push = require 'push'

--[[
    Runs when the game first starts up, only once; used to initialize the game.
]]
function love.load()
    math.randomseed(os.time())

    font = love.graphics.newFont('font.ttf', 8)
    scoreFont = love.graphics.newFont('font.ttf', 32)
    
    love.graphics.setFont(font)

    -- setup push library (allows to render in virtual rez)
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true, -- debugging only
        vsync = true
    })

    -- scale images using nearest neigbour interpolation
    love.graphics.setDefaultFilter('nearest', 'nearest')
end

function love.update(dt)
    handleInput(dt)

    ballX = ballX + 50 * dt
end

function love.draw()
    -- love.graphics.clear(0.1, 0, 0, 0)

    love.graphics.setFont(font)
    love.graphics.printf('Hello Pong!', 10, 10, WINDOW_WIDTH, 'left') -- can take up whole width
    
    push:apply('start')
    -- love.graphics.setColor(0, 0, 1, 0)
    
    love.graphics.rectangle('fill', PADDLE_WIDTH * 2, player1pos, 5, 20) -- left paddle
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - PADDLE_WIDTH * 3, player2pos, 5, 20) -- right paddle
    love.graphics.rectangle('fill', ballX, ballY, BALL_SIZE, BALL_SIZE) -- ball

    love.graphics.setFont(scoreFont)
    love.graphics.printf('0 0', 0, 5, VIRTUAL_WIDTH, 'center')
    push:apply('end')
end

function handleInput(dt)
    if love.keyboard.isDown('w') and (player1pos >= 0) then
        player1pos = player1pos - PADDLE_SPEED * dt
    elseif love.keyboard.isDown('s') and (player1pos + PADDLE_HEIGHT < VIRTUAL_HEIGHT) then
        player1pos = player1pos + PADDLE_SPEED * dt
    end

    if love.keyboard.isDown('i') and (player2pos >= 0) then
        player2pos = player2pos - PADDLE_SPEED * dt
    elseif love.keyboard.isDown('k') and (player2pos + PADDLE_HEIGHT < VIRTUAL_HEIGHT) then
        player2pos = player2pos + PADDLE_SPEED * dt
    end
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

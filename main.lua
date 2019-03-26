windowWidth, windowHeight = love.window.getDesktopDimensions()
windowWidth, windowHeight = 1280 / 2, 960 / 2

virtualWidth = 256 --windowWidth * 0.5
virtualHeight = 192 --windowHeight * 0.5 

player1score = 0
player2score = 0

title = 'p o n g'

push = require 'push'
Class = require 'class'
require 'State'
require 'Paddle'
require 'Ball'

function love.load()
    math.randomseed(os.time())
    love.window.setTitle('pong')
    love.graphics.setDefaultFilter('nearest', 'nearest')

    state = State()

    push:setupScreen(virtualWidth, virtualHeight, windowWidth, windowHeight, {
        fullscreen = false,
        resizable = true, 
        vsync = true,
        pixelperfect = true
    })
    
    local paddleWidth = 4
    local paddleHeight = 26
    local xOffset = paddleWidth + paddleWidth / 2
    local yCenter = virtualHeight / 2 - (paddleHeight / 2)
    player1 = Paddle(xOffset, yCenter, paddleWidth, paddleHeight, 'w', 's', virtualHeight)
    player2 = Paddle(virtualWidth - xOffset - paddleWidth, yCenter, paddleWidth, paddleHeight, 'i', 'k', virtualHeight)
    ball = Ball(virtualWidth, virtualHeight)
    
    font = love.graphics.newFont('font.ttf', 8)
    scoreFont = love.graphics.newFont('font.ttf', virtualWidth * 0.08)
end

function love.update(dt)
    if (state:isPlaying()) then
        title = state:player1Score() .. ' ' .. state:player2Score()

        player1:handleInput()
        player2:handleInput()

        ball:update(dt)
        player1:update(dt)
        player2:update(dt)

        if (ball:collidesWith(player1)) then
            ball:bounceFrom(player1)
        elseif (ball:collidesWith(player2)) then
            ball:bounceFrom(player2)
        elseif (ball:isOutLeft()) then
            state:player2Scored()
            player1Serving()
        elseif (ball:isOutRight()) then
            state:player1Scored()
            player2Serving()
        end

    elseif (state:isPaused()) then
        title = 'paused'
    end
end

function player1Serving()
    resetPlayers()
    ball:serveToRight()
end

function player2Serving()
    resetPlayers()
    ball:serveToLeft()
end

function resetPlayers()
    player1:reset()
    player2:reset()
end

function love.draw()
    love.graphics.clear(0.25, 0.25, 0.25)

    push:apply("start")
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle('fill', 0, 0, virtualWidth, virtualHeight)

    love.graphics.setColor(1, 1, 1)

    player1:render()
    player2:render()
    ball:render()

    love.graphics.setFont(scoreFont)
    love.graphics.printf(title, 0, 5, virtualWidth, 'center')

    push:apply("end")

    love.graphics.setFont(font)
    love.graphics.printf(windowWidth .. ' x ' .. windowHeight .. ' | ' .. virtualWidth .. ' x ' .. virtualHeight .. ' @ ' .. tostring(love.timer.getFPS()), 5, 5, windowWidth, 'left')
end

function love.keypressed(key)
    if key == 'space' then
        state:togglePause()
    elseif key == 'escape' then
        love.event.quit()
    elseif key == 'return' then
        resetPlayers()
        ball:reset()
    end
end

function love.resize(w, h)
    push:resize(w, h)
end

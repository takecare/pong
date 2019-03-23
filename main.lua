windowWidth, windowHeight = love.window.getDesktopDimensions()
windowWidth, windowHeight = 1280, 960

virtualWidth = 256 --windowWidth * 0.5
virtualHeight = 192 --windowHeight * 0.5 

player1score = 0
player2score = 0

gameState = 'paused'
title = 'p o n g'

push = require 'push'
Class = require 'class'
require 'Paddle'
require 'Ball'

function love.load()
    math.randomseed(os.time())
    love.graphics.setDefaultFilter('nearest', 'nearest')

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
    if (gameState == 'playing') then
        title = player1score .. ' ' .. player2score -- TODO unnecessary on every update()
        player1:handleInput()
        player2:handleInput()

        ball:update(dt)
        player1:update(dt)
        player2:update(dt)
    elseif (gameState == 'paused') then
        title = 'paused'
    end
end

function love.draw()
    love.graphics.setFont(font)
    love.graphics.printf(windowWidth .. ' x ' .. windowHeight .. ' | ' .. virtualWidth .. ' x ' .. virtualHeight, 5, 5, windowWidth, 'left') -- can take up whole width
    
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
end

function love.keypressed(key)
    if key == 'space' then
        if gameState == 'playing' then
            gameState = 'paused'
        elseif gameState == 'paused' then
            gameState = 'playing'
        end
    elseif key == 'escape' then
        love.event.quit()
    end
end

function love.resize(w, h)
    push:resize(w, h)
end

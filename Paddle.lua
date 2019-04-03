Paddle = Class{}

function Paddle:init(width, height, xOffset, screenWidth, screenHeight, upKey, downKey, inverted)
    self.x = xOffset
    
    self.movement = screenHeight / 2 - (height / 2)
    self.initialMovement = y
    self.screenWidth = screenWidth
    self.screenHeight = screenHeight

    self.width = width
    self.height = height
    
    self.upKey = upKey
    self.downKey = downKey
    self.inverted = inverted ~= nil and inverted or false

    self.speed = 60
    self.dy = 0

    self.edge = ''
end

function Paddle:reset()
    self.movement = self.initialMovement
    self.dy = 0
end

function Paddle:update(dt)
    self.movement = self.movement + self.dy * dt
end

function Paddle:collidesWith(ball)
    -- TODO
end

function Paddle:render()
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle('fill', self.x, 0, self.height, self.width)
    love.graphics.setColor(1, 1, 1)

    local mov = self.movement
    local sh = self.screenHeight
    local sw = self.screenWidth
    local h = self.height
    local w = self.width
    local x = self.x

    self._msg = self.edge .. ' - mov=' .. math.ceil(self.movement)

    if (mov > 0 and mov + h < sh) then
        self.edge = 'A'
        love.graphics.rectangle('fill', x, mov, w, h)

    elseif (mov < 0 and mov > -sw) then
        self.edge = 'B'
        if (math.abs(mov) > 0 and math.abs(mov) < h) then
            self.edge = 'AB'
        else
            if (self.inverted) then
                love.graphics.rectangle('fill', x - math.abs(mov), 0, h, w)
            else 
                love.graphics.rectangle('fill', math.abs(mov) - h + x, 0, h, w)
            end
        end

    elseif (mov < -sw and mov > -sw - sh) then
        self.edge = 'C'
        if (math.abs(mov) > sw and math.abs(mov) < sw+h) then
            self.edge = 'BC '
        else
            if (self.inverted) then
                love.graphics.rectangle('fill', sw - x, math.abs(mov)+sw+h, w, h)
            else
                love.graphics.rectangle('fill', sw, math.abs(mov)-sw-h, w, h)
            end
        end

    elseif (mov < -sw - sh and mov > -2 * sw - sh + x) then
        self.edge = 'D'
        if (math.abs(mov) > sw+sh and math.abs(mov) < sw+sh+h) then
            self.edge = 'CD'
        else
            love.graphics.rectangle('fill', 2*sw+sh-math.abs(mov), sh-w, h, w)
        end

    elseif (mov < -2 * sw - sh and mov > -2 * sw - 2 * sh) then
        self.edge = '_A'
        if (math.abs(mov) > sw+sh+sw and math.abs(mov) < sw+sh+sw+h) then
            self.edge = 'DA'
        else
            self.movement = sh - h
        end

    elseif (mov + h > sh) then
        self.movement = -2 * sw - sh - h
    end
end

function Paddle:handleInput()
    if love.keyboard.isDown(self.upKey) then
        self:_moveUpwards()
    elseif love.keyboard.isDown(self.downKey) then
        self:_moveDownwards()
    else 
        self.dy = 0
    end
end

function Paddle:_moveUpwards()
    self.dy = -self.speed
end

function Paddle:_moveDownwards()
    self.dy = self.speed
end

function Paddle:debug(x, y)
    local x = x ~= nil and x or 20
    local y = y ~= nil and y or 50
    if (self._msg ~= nil) then
        love.graphics.printf(self._msg, x, y, self.screenWidth, 'left')
    end
end

Paddle = Class{}

function Paddle:init(width, height, upKey, downKey, screenWidth, screenHeight)
   self.x = 0
   self.movement = screenHeight / 2- (height / 2)
   self.initialMovement = y
   self.screenWidth = screenWidth
   self.screenHeight = screenHeight

   self.width = width
   self.height = height
   
   self.upKey = upKey
   self.downKey = downKey

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
    
    local mov = self.movement
    local sh = self.screenHeight
    local sw = self.screenWidth
    local h = self.height

    if (mov > 0 and mov < sh / 2) then
        self.edge = 'A'
    elseif (mov < 0 and mov > -sw) then
        self.edge = 'B'
        if (math.abs(mov) > 0 and math.abs(mov) < h) then
            self.edge = 'AB'
        end
    elseif (mov < -sw and mov > -sw - sh) then
        self.edge = 'C'
        if (math.abs(mov) > sw and math.abs(mov) < sw+h) then
            self.edge = 'BC'
        end
    elseif (mov < -sw - sh and mov > -2 * sw - sh) then
        self.edge = 'D'
        if (math.abs(mov) > sw+sh and math.abs(mov) < sw+sh+h) then
            self.edge = 'CD'
        end
    elseif (mov < -2 * sw - sh and mov > -2 * sw - 2 * sh) then
        self.edge = '_A'
        if (math.abs(mov) > sw+sh+sw and math.abs(mov) < sw+sh+sw+h) then
            self.edge = 'DA'
        else--if () then
            self.movement = sh - h
        end
    end
end

function Paddle:collidesWith(ball)
    -- TODO
end

function Paddle:render()
    -- delta is the amount of paddle that has crossed an axis (YY or XX)
    local delta = self.movement < 0 and math.abs(self.movement) or 0

    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle('fill', self.screenWidth - self.width, 0, self.width, self.width)
    love.graphics.setColor(1, 1, 1)

    self._msg = self.edge .. ' - mov=' .. math.ceil(self.movement)

    if (delta > 0 and delta < self.height - self.width) then -- top, left corner
        love.graphics.rectangle('fill', self.width, 0, delta, self.width) -- top edge part
        love.graphics.rectangle('fill', 0, self.movement, self.width, self.height) -- left edge part

    elseif (delta >= self.height - self.width and delta < self.screenWidth - self.width) then -- top edge
        love.graphics.rectangle('fill', delta - self.height + self.width, 0, self.height, self.width)

    elseif (delta > self.screenWidth - self.width) then -- top, right corner
        local amountInRightEdge = self.screenHeight - (delta / self.screenHeight)
        local x = delta - self.height + self.width

        love.graphics.rectangle('fill', x, 0, self.screenWidth - x, self.width) -- top edge part
        love.graphics.rectangle('fill', self.screenWidth - self.width, self.width, self.screenWidth, amountInRightEdge)

    else
        love.graphics.rectangle('fill', self.x, self.movement, self.width, self.height)
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

function Paddle:debug()
    if (self._msg ~= nil) then
        love.graphics.printf(self._msg, 20, 50, self.screenWidth, 'left')
    end
end

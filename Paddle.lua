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
    
    local mov = self.screenHeight/2 - self.movement - self.height / 2
    local sh = self.screenHeight
    local sw = self.screenWidth

    if (mov < sh / 2 and mov > -sh / 2) then
        self.edge = 'A'
    elseif (mov > -sh / 2 and mov < -sh / 2 - sw) then
        self.edge = 'B'
    elseif (mov > -sh / 2 - sw and mov < -sh / 2 - sw - sh) then
        self.edge = 'C'
    elseif (mov > -sh / 2 - sw - sh and mov < -sh / 2 - 2 * sw - sh) then
        self.edge = 'D'
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

    self._msg = self.edge .. ' delta=' .. math.ceil(delta) .. ' mov=' .. math.ceil(self.movement)

    if (delta > 0 and delta < self.height - self.width) then -- top, left corner
        self._msg = self._msg .. ' (A)'
        love.graphics.rectangle('fill', self.width, 0, delta, self.width) -- top edge part
        love.graphics.rectangle('fill', 0, self.movement, self.width, self.height) -- left edge part

    elseif (delta >= self.height - self.width and delta < self.screenWidth - self.width) then -- top edge
        self._msg = self._msg .. ' (B) '
        love.graphics.rectangle('fill', delta - self.height + self.width, 0, self.height, self.width)

    elseif (delta > self.screenWidth - self.width) then -- top, right corner
        local amountInRightEdge = self.screenHeight - (delta / self.screenHeight)
        local x = delta - self.height + self.width

        self._msg = self._msg .. ' (C) ' .. (amountInRightEdge)
        
        love.graphics.rectangle('fill', x, 0, self.screenWidth - x, self.width) -- top edge part
        love.graphics.rectangle('fill', self.screenWidth - self.width, self.width, self.screenWidth, amountInRightEdge)

    else

        self._msg = self._msg .. ' (I) '
        love.graphics.rectangle('fill', self.x, self.movement, self.width, self.height)
    end
end

function Paddle:handleInput()
    if love.keyboard.isDown(self.upKey) then
        self:_moveUpwards()
    elseif love.keyboard.isDown(self.downKey) then -- and (self.movement + self.height < self.screenHeight) 
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

Paddle = Class{}

function Paddle:init(x, y, width, height, upKey, downKey, screenWidth, screenHeight)
   self.x = x
   self.y = y
   self.initialY = y
   self.width = width
   self.height = height
   self.upKey = upKey
   self.downKey = downKey
   self.screenWidth = screenWidth
   self.screenHeight = screenHeight
   self.speed = 200
   self.dy = 0

   self.de = 0

   -- full length of the border = screenWidth * 2 + screenHeight * 2
   -- we want this to be the amount the top of the paddle has moved across the full length of the border
   self.edge = 0
end

function Paddle:reset()
   self.y = self.initialY
   self.dy = 0
end

function Paddle:update(dt)
    self.y = self.y + self.dy * dt
    self.edge = self.y -- - self.screenHeight/2 + self.height/2
end

function Paddle:render()
    -- delta is the amount of paddle that has crossed an axis (YY or XX)
    local delta = self.y < 0 and math.abs(self.edge) or 0
    local x = self.x

    self._msg = 'delta=' .. math.ceil(delta)

    -- if (delta >= self.height) then -- draw on top-most edge
        -- love.graphics.rectangle('fill', x + delta - self.height + self.width, 0, self.height, self.width)
    if (delta > 0 and delta < self.height - self.width) then
        love.graphics.rectangle('fill', x + self.width, 0, delta, self.width)
        love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
        self._msg = '-> delta=' .. math.ceil(delta)
    elseif (delta >= self.height - self.width) then
        love.graphics.rectangle('fill', x + delta - self.height + self.width, 0, self.height, self.width)
        -- love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
    else
        love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
    end

    -- love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

function Paddle:handleInput()
    if love.keyboard.isDown(self.upKey) then--and (self.y >= 0) then
        self:_moveUpwards()
    elseif love.keyboard.isDown(self.downKey) and (self.y + self.height < self.screenHeight) then
        self:_moveDownwards()
    else 
        self.dy = 0
        self.de = 0
    end
end

function Paddle:_moveUpwards()
    self.de = -self.speed
    self.dy = -self.speed
end

function Paddle:_moveDownwards()
    self.de = self.speed
    self.dy = self.speed
    
end

function Paddle:debug()
    love.graphics.printf('edge=' .. math.ceil(self.edge) .. ' y=' .. math.ceil(self.y) .. ' h=' .. (self.height), 20, 30, self.screenWidth, 'left')
    if (self._msg ~= nil) then
        love.graphics.printf(self._msg, 20, 50, self.screenWidth, 'left')
    end
end

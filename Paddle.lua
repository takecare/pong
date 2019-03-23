Paddle = Class{}

function Paddle:init(x, y, width, height, upKey, downKey, screenHeight)
   self.x = x
   self.y = y
   self.initialY = y
   self.width = width
   self.height = height
   self.upKey = upKey
   self.downKey = downKey
   self.screenHeight = screenHeight
   self.speed = 200
   self.dy = 0
end

function Paddle:reset()
   self.y = self.initialY
   self.dy = 0
end

function Paddle:update(dt)
    self.y = self.y + self.dy * dt
end

function Paddle:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

function Paddle:handleInput()
    if love.keyboard.isDown(self.upKey) and (self.y >= 0) then
        self.dy = -self.speed
    elseif love.keyboard.isDown(self.downKey) and (self.y + self.height < self.screenHeight) then
        self.dy = self.speed
    else 
        self.dy = 0
    end
end

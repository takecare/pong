
Ball = Class{}

function Ball:init(screenWidth, screenHeight) -- TODO check for screenWidth & screenHeight
    self.size = 5
    self.screenHeight = screenHeight
    self.x = screenWidth / 2 - self.size / 2
    self.initialX = self.x
    self.y = screenHeight / 2 - self.size / 2
    self.initialY = self.y
    self.speed = 60
    self.dx = math.random(2) == 1 and -self.speed or self.speed
    self.dy = math.random(-self.speed, self.speed)
end

function Ball:reset()
    self.x = self.initialX
    self.y = self.initialY
    self.speed = 60
    self.dx = math.random(2) == 1 and -self.speed or self.speed
    self.dy = math.random(-self.speed, self.speed)
end

function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt

    if (self.y + self.size > self.screenHeight) then
        self.dy = -self.dy
        self.y = self.screenHeight - self.size
    elseif (self.y < 0) then
        self.dy = -self.dy
        self.y = 0
    end
end

function Ball:collidesWith(paddle)
    local minX, minY = self.x, self.y
    local maxX, maxY = self.x + self.size, self.y + self.size
    local paddleMinX, paddleMinY = paddle.x, paddle.y
    local paddleMaxX, paddleMaxY = paddle.x + paddle.width, paddle.y + paddle.height
    return (minX <= paddleMaxX and maxX >= paddleMinX) and (minY <= paddleMaxY and maxY >= paddleMinY)
end

function Ball:bounceFrom(paddle)
    self.x = self.dx < 0 and (self.x + self.size / 2) or (self.x - self.size / 2)
    self.dx = -self.dx * (math.random(4) == 1 and 1.25 or 1.03)
    local dy = self.dy + (math.random(10, 50))
    self.dy = math.random(2) == 2 and dy * 1 or dy * -1
end

function Ball:render()
    love.graphics.rectangle('fill', self.x, self.y, self.size, self.size)
end

Ball = Class{}

function Ball:init(screenWidth, screenHeight) -- TODO check for screenWidth & screenHeight
    self.size = 5
    self.screenWidth = screenWidth
    self.screenHeight = screenHeight
    self.x = screenWidth / 2 - self.size / 2
    self.initialX = self.x
    self.y = screenHeight / 2 - self.size / 2
    self.initialY = self.y
    self.speed = 60
    self.dx = math.random(2) == 1 and -self.speed or self.speed
    self.dy = math.random(-self.speed, self.speed)
end

function Ball:serveToLeft()
    self:reset('left')
end

function Ball:serveToRight()
    self:reset('right')
end

function Ball:reset(direction)
    if (direction == nil) then
        direction = math.random(2) == 1 and 'left' or 'right'
        print("random direction = " .. direction)
    end
    print("direction = " .. direction)
    self.x = self.initialX
    self.y = self.initialY
    self.speed = 60
    self.dx = direction == 'left' and math.min(self.speed, -self.speed) or math.max(self.speed, -self.speed)
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

function Ball:isOutLeft()
    return self.x < 0
end

function Ball:isOutRight()
    return self.x + self.size > self.screenWidth
end

function Ball:bounceFrom(paddle)
    self.x = self.dx < 0 and (paddle.x + paddle.width) or (self.x - paddle.width)
    self.dx = -self.dx * (math.random(4) == 1 and 1.25 or 1.03)
    -- local dy = self.dy + (math.random(10, 50))
    self.dy = math.random(25, 150) * (self.dy > 0 and 1 or -1)
    print(self.dy)
end

function Ball:render()
    love.graphics.rectangle('fill', self.x, self.y, self.size, self.size)
end

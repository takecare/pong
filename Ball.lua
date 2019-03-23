
Ball = Class{}

function Ball:init(screenWidth, screenHeight) -- TODO check for screenWidth & screenHeight
    self.size = 5
    self.x = screenWidth/2 - self.size/2
    self.y = screenHeight/2 - self.size/2
    self.defaultSpeed = 50
    self.dy = math.random(2) == 1 and -self.defaultSpeed or self.defaultSpeed
    self.dx = math.random(-self.defaultSpeed, self.defaultSpeed)
end

function Ball:reset()
    self.x = screenWidth/2 - self.size/2
    self.y = screenHeight/2 - self.size/2
    self.dx = math.random(2) == 1 and -self.defaultSpeed or self.defaultSpeed
    self.dy = math.random(-self.defaultSpeed, self.defaultSpeed)
end

function Ball:update(dt)
    self.y = self.x + self.dx * dt
    self.x = self.y + self.dy * dt
end

function Ball:render()
    love.graphics.rectangle('fill', self.x, self.y, self.size, self.size)
end

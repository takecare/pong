State = Class{}

local MAX_POINTS = 10

function State:init()
    self.state = 'paused'
    self.previous = 'player1serving'
    self.player1score = 0
    self.player2score = 0
end

function State:reset()
    if (self.state == 'player1won') then
        self.state = 'player2serving'
    else
        self.state = 'player1serving'
    end
    self.player1score = 0
    self.player2score = 0
end

function State:pause()
    self.previous = self.state
    self.state = 'paused'
end

function State:resume()
    self.state = self.previous
    self.previous = 'paused'
end

function State:togglePause()
    if (self:isPaused()) then
        self:resume()
    else
        self:pause()
    end
end

function State:isPaused()
    return self.state == 'paused'
end

function State:isPlaying()
    return self.state == 'player1serving' or self.state == 'player2serving'
end

function State:player1Won()
    return self.state == 'player1won'
end

function State:player2Won()
    return self.state == 'player2won'
end

function State:isOver()
    return self.state == 'player1won' or self.state == 'player2won'
end

function State:player1Scored()
    self.player1score = self.player1score + 1
    self.state = 'player2serving'
    self:_checkIfOver()
end

function State:_checkIfOver()
    if (self.player1score == MAX_POINTS) then
        self.state = 'player1won'
    elseif (self.player2score == MAX_POINTS) then
        self.state = 'player2won'
    end
end

function State:player2Scored()
    self.player2score = self.player2score + 1
    self.state = 'player1serving'
    self:_checkIfOver()
end

function State:player1Score()
    return self.player1score
end

function State:player2Score()
    return self.player2score
end

State = Class{}

function State:init()
    self.state = 'paused'
    self.prePause = 'player1serving'
    self.player1score = 0
    self.player2score = 0
end

function State:startGame(previous)
    self.state = previous.state == 'player1serving' and 'player2serving' or 'player1serving'
end

function State:pause()
    self.prePause = self.state
    self.state = 'paused'
end

function State:resume()
    self.state = self.prePause
    self.prePause = 'paused'
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

function State:player1Scored()
    self.player1score = self.player1score + 1
    self.state = 'player2serving'
end

function State:player2Scored()
    self.player2score = self.player2score + 1
    self.state = 'player1serving'
end

function State:player1Score()
    return self.player1score
end

function State:player2Score()
    return self.player2score
end

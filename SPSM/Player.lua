Player = Class{}

PLAYER_SIZE = 0.2
PLAYER_SPEED = 100
PLAYER_DSPEED = PLAYER_SPEED / math.sqrt(2)

function Player:init()
    self.image = love.graphics.newImage('Ships/player.png')

    self.iwidth = self.image:getWidth()  
    self.iheight = self.image:getHeight()  

    self.width = self.image:getWidth()  * PLAYER_SIZE * 0.8
    self.height = self.image:getHeight()  * PLAYER_SIZE * 0.8

    self.x = VIRTUAL_WIDTH / 2 - (self.width * PLAYER_SIZE / 2)
    self.y = VIRTUAL_HEIGHT / 2 - (self.height  * PLAYER_SIZE /2)
    self.angle =  math.pi / 2
end

function Player:update(dt)
    if love.keyboard.isDown('up') and love.keyboard.isDown('left') and self.y > self.height * PLAYER_SIZE and  self.x > self.width * PLAYER_SIZE then
        self.x = self.x - PLAYER_DSPEED * dt
        self.y = self.y - PLAYER_DSPEED * dt
        self.angle = - math.pi / 4
    elseif love.keyboard.isDown('up') and love.keyboard.isDown('right') and self.y > self.height * PLAYER_SIZE and self.x < VIRTUAL_WIDTH - self.width * PLAYER_SIZE then
        self.x = self.x + PLAYER_DSPEED * dt
        self.y = self.y - PLAYER_DSPEED * dt
        self.angle = math.pi / 4
    elseif love.keyboard.isDown('down') and love.keyboard.isDown('right') and self.y < VIRTUAL_HEIGHT - self.height * PLAYER_SIZE and self.x < VIRTUAL_WIDTH - self.width * PLAYER_SIZE then
        self.x = self.x + PLAYER_DSPEED * dt
        self.y = self.y + PLAYER_DSPEED * dt
        self.angle = 3 * math.pi / 4
    elseif love.keyboard.isDown('down') and love.keyboard.isDown('left') and self.y < VIRTUAL_HEIGHT - self.height * PLAYER_SIZE and self.x > self.width * PLAYER_SIZE then
        self.x = self.x - PLAYER_DSPEED * dt
        self.y = self.y + PLAYER_DSPEED * dt
        self.angle = - 3 * math.pi / 4
    elseif love.keyboard.isDown('up') and self.y > self.height * PLAYER_SIZE then
        self.y = self.y - PLAYER_SPEED * dt
        self.angle = 0 
    elseif love.keyboard.isDown('down') and self.y < VIRTUAL_HEIGHT - self.height * PLAYER_SIZE then
        self.y = self.y + PLAYER_SPEED * dt
        self.angle = math.pi 
    elseif love.keyboard.isDown('left') and self.x > self.width * PLAYER_SIZE then
        self.x = self.x - PLAYER_SPEED * dt
        self.angle = 3 * math.pi / 2
    elseif love.keyboard.isDown('right') and self.x < VIRTUAL_WIDTH - self.width * PLAYER_SIZE  then
        self.x = self.x + PLAYER_SPEED * dt
        self.angle =  math.pi / 2
    end
end

function Player:render()
    love.graphics.draw(self.image, self.x, self.y, self.angle, PLAYER_SIZE, PLAYER_SIZE, self.iwidth / 2, self.iheight / 2)
    
    --[[ Draw Collider
    love.graphics.line(self.x - self.width / 2, self.y - self.height / 2, self.x + self.width / 2, self.y - self.height / 2)
    love.graphics.line(self.x - self.width / 2, self.y - self.height / 2, self.x - self.width / 2, self.y + self.height / 2)
    love.graphics.line(self.x - self.width / 2, self.y + self.height / 2, self.x + self.width / 2, self.y + self.height / 2)
    love.graphics.line(self.x + self.width / 2, self.y - self.height / 2, self.x + self.width / 2, self.y + self.height / 2)
    ]]
end
Asteroid = Class{}

VIRTUAL_WIDTH = 282
VIRTUAL_HEIGHT = 160

local ASTEROID_IMAGES = {}
for i=1,4 do
    table.insert(ASTEROID_IMAGES, love.graphics.newImage("/PNG/Meteors/meteorBrown_big" .. i .. ".png"))
end
local MAX_W_H = 80

local INITIAL_POSITION_X = { 0, VIRTUAL_WIDTH + MAX_W_H / 2,  0, - MAX_W_H / 2}
local INITIAL_POSITION_Y = {- MAX_W_H / 2,  0, VIRTUAL_HEIGHT + MAX_W_H/ 2, 0}
local ANGLE = {0,  math.pi / 2, - math.pi, 3 * math.pi / 2}

function Asteroid:init(s)
    self.number = math.random(4)

    self.imageNumber = math.random(4)
    self.image = ASTEROID_IMAGES[self.imageNumber]

    if self.number % 2 == 0 then
        self.x = INITIAL_POSITION_X[self.number]
        self.y = math.random(MAX_W_H, VIRTUAL_HEIGHT - MAX_W_H)
    else
        self.x = math.random(MAX_W_H, VIRTUAL_WIDTH - MAX_W_H)
        self.y = INITIAL_POSITION_Y[self.number]
    end

    self.collided = 0

    self.size = 0.1 + math.random() / 5

    if self.imageNumber == 2 then
        self.width = self.image:getWidth() * self.size * 0.7

        self.height = self.image:getHeight() * self.size * 0.7
    else 
        self.width = self.image:getWidth() * self.size * 0.8

        self.height = self.image:getHeight() * self.size * 0.8
    end

    self.speed = (1 - math.random() / 2) * s
    
    local angleGenerator = math.random()
    if angleGenerator < 1/2 then
        self.angle = math.pi * angleGenerator + ANGLE[self.number] + math.pi /4
    else
        self.angle = math.pi * angleGenerator + ANGLE[self.number] - math.pi /4
    end

end

function Asteroid:update(dt)
    self.x = self.x + (math.cos(self.angle) * self.speed *  dt) 

    self.y = self.y + (math.sin(self.angle) * self.speed * dt)

    if self.collided > 0 then
        self.collided = self.collided - 2 * dt
    end

end

function Asteroid:render()   
    love.graphics.draw(self.image, self.x, self.y, 0, self.size, self.size, self.width / 2, self.height / 2)
    
    --[[ Draw Colliders
    love.graphics.line(self.x, self.y, self.x + self.width, self.y)
    love.graphics.line(self.x, self.y, self.x, self.y + self.height)
    love.graphics.line(self.x + self.width, self.y, self.x + self.width, self.y + self.height)
    love.graphics.line(self.x, self.y + self.height, self.x + self.width, self.y + self.height)
    ]]
end
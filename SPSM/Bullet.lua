Bullet = Class{}

local BULLETS = {}
table.insert(BULLETS, love.graphics.newImage("/PNG/Lasers/laserBlue05.png"))
table.insert(BULLETS, love.graphics.newImage("/PNG/Lasers/laserGreen09.png")) 

local BULLET_SCROLL = 200
local BULLET_SIZE = 0.25

function Bullet:init(x ,y ,image, angle)

    self.image = BULLETS[image]

    self.x = x

    self.y = y

    self.angle = angle

    self.width = self.image:getWidth() * BULLET_SIZE

    self.height = self.image:getHeight() * BULLET_SIZE
    
    
end

function Bullet:update(dt)
    self.x = self.x + (math.cos(self.angle) * BULLET_SCROLL *  dt) 

    self.y = self.y + (math.sin(self.angle) * BULLET_SCROLL *  dt) 
end

function Bullet:render()   
    love.graphics.draw(self.image, self.x, self.y, self.angle + math.pi / 2, BULLET_SIZE, BULLET_SIZE, self.width / 2, self.height / 2)

    --[[ Draw bullet colliders, need to fix when diagonal trayectories
    local sign1 = - math.sin(self.angle)
    local sign2 = math.cos(self.angle)
    love.graphics.line(self.x, self.y, self.x + sign1 * self.width - sign2 * self.height, self.y)
    love.graphics.line(self.x, self.y, self.x, self.y + sign1 * self.height + sign2 * self.width)
    love.graphics.line(self.x, self.y + sign1 * self.height + sign2 * self.width, self.x + sign1 * self.width - sign2 * self.height, self.y + sign1 * self.height + sign2 * self.width)
    love.graphics.line(self.x + sign1 * self.width - sign2 * self.height, self.y, self.x + sign1 * self.width - sign2 * self.height, self.y + sign1 * self.height + sign2 * self.width)
    ]]
end
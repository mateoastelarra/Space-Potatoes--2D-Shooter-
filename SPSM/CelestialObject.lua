CelestialObject = Class{}

local CO_IMAGES = {}
for i=2,4 do
    table.insert(CO_IMAGES, love.graphics.newImage("CelestialObjects/Co" .. i .. ".png"))
end

local CO_SCROLL =-40

function CelestialObject:init()
    self.number = math.random(3)

    self.image = CO_IMAGES[math.random(3)]

    self.x = VIRTUAL_WIDTH

    self.y = math.random(0, VIRTUAL_HEIGHT - 10)

    self.width = self.image:getWidth()

    self.size = 0.2 + math.random() / 2

    self.speed = 0.75 +  self.size /2

    self.rotation = 2 * math.pi * math.random()
end

function CelestialObject:update(dt)
    self.x = self.x + CO_SCROLL * self.speed *  dt
end

function CelestialObject:render()   
    love.graphics.draw(self.image, self.x, self.y, self.rotation, self.size, self.size)
end
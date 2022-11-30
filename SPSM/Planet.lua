Planet = Class{}

local PLANET_IMAGES = {}
for i=1,12 do
    table.insert(PLANET_IMAGES, love.graphics.newImage("PLanets/planet" .. i .. ".png"))
end

local PLANET_SCROLL =-80

function Planet:init()
    self.number = math.random(12)

    self.image = PLANET_IMAGES[self.number]

    self.width = self.image:getWidth()
    
    self.x = VIRTUAL_WIDTH + self.width

    self.y = math.random(0, VIRTUAL_HEIGHT - 10)

    self.width = self.image:getWidth()

    self.size = 0.3 + math.random() / 2

    self.rotation = 2 * math.pi * math.random()

    self.speed = 0.3 +  self.size
end

function Planet:update(dt)
    self.x = self.x + PLANET_SCROLL * self.speed *  dt
end

function Planet:render()   
    love.graphics.draw(self.image, self.x, self.y, self.rotation, self.size, self.size)
end
Explosion = Class{}

local EXPLOSIONS = {{}, {}, {}}


for i = 1, 11 do 
    for j = 1, 3 do
        table.insert(EXPLOSIONS[j], love.graphics.newImage("/Animations/Explosions/Explosion".. j .. "/Explosion".. j .."_" .. i .. ".png"))
    end 
end


function Explosion:init(n, x, y)
    self.images = EXPLOSIONS[n]

    self.x = x

    self.y = y
    
    self.currentFrame = 1

end

function Explosion:update(dt)
    self.currentFrame = self.currentFrame + 10 * dt
end

function Explosion:render()
    if self.currentFrame <= 11 then
        image = self.images[math.floor(self.currentFrame)]
        love.graphics.draw(image, self.x, self.y, 0, 0.3, 0.3, image:getWidth() / 2, image:getHeight() / 2)
    end
end
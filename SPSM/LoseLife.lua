LoseLife = Class{}

local LOSELIFEANI = {}

for i = 1, 7 do
    table.insert(LOSELIFEANI, love.graphics.newImage("/Animations/Damage/playerDeath".. i .. ".png"))
end 




function LoseLife:init(x, y)

    self.x = x

    self.y = y
    
    self.currentFrame = 1

end

function LoseLife:update(dt)
    self.currentFrame = self.currentFrame + 5 * dt
end

function LoseLife:render()
    if self.currentFrame <= 7 then
        image = LOSELIFEANI[math.floor(self.currentFrame)]
        love.graphics.draw(image, self.x, self.y, 0, 0.3, 0.3, image:getWidth() / 2, image:getHeight() / 2)
    end
end
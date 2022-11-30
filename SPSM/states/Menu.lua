Menu = Class{}

-- initialize text fonts
tittleFont = love.graphics.newFont('fonts/Aller_Bd.ttf', 20)
middleFont = love.graphics.newFont('fonts/Aller_Bd.ttf', 15)

-- initialize potato
potato1 = love.graphics.newImage('PNG/Meteors/meteorBrown_big3.png')
potato2 = love.graphics.newImage('PNG/Meteors/meteorBrown_big1.png')
hero = love.graphics.newImage('Ships/player.png')

-- Set size
SIZE = 0.3


function Menu:init()
    self.scrolling = 0
    self.position = 0
    self.pressSpace = 0

    -- Load and play music
    song = love.audio.newSource("Sounds/Pantalla de Inicio.mp3", "stream")

    song:play()
    song:setLooping(true)
    song:setVolume(0.5)
end

function Menu:update(dt)
    self.pressSpace = self.pressSpace + 2 * dt
    if self.scrolling == 1 then
        self.position = self.position - 15 * dt
    end
end

function Menu:render()
    -- Draw titles and draw Icons, make them scroll upwards if space bar is pushed
    love.graphics.setFont(tittleFont)
    love.graphics.printf("SPACE POTATOES", 0, 10 + self.position, VIRTUAL_WIDTH, "center")
    love.graphics.setFont(middleFont)
    love.graphics.printf("A space adventure somewhere in time", 0, 30 + self.position, VIRTUAL_WIDTH , "center")
    love.graphics.draw(potato1, 60, 60 + self.position, 0, SIZE, SIZE)
    love.graphics.draw(potato2, 180, 60 + self.position, 0, SIZE, SIZE)
    love.graphics.draw(hero, 120, 60 + self.position, 0, SIZE, SIZE)

    -- Some Narrative when the scorlling starts
    love.graphics.printf("In the Year 2054, important corporations messed way too much with transgenics.", 0, VIRTUAL_HEIGHT + self.position, VIRTUAL_WIDTH , "center")
    love.graphics.printf("This gave birth to the P VIRUS, forming destructive potatoes that, not only tasted like shit, but conquered planet earth in less than a year. ", 
                        0, VIRTUAL_HEIGHT + 70 + self.position, VIRTUAL_WIDTH , "center")
    love.graphics.printf("Several years later human race was forced to live in space, and the field of stars became our daily battlefield.", 
                        0, VIRTUAL_HEIGHT + 150 + self.position, VIRTUAL_WIDTH , "center")
    love.graphics.printf("Your job as a Space Trooper is to destroy as many explosive potatoes as you can. You must be the smasher and avoid being the SMASHED. Good luck mate!", 
                        0, VIRTUAL_HEIGHT + 215 + self.position, VIRTUAL_WIDTH , "center")
    love.graphics.printf("S: fire", 0, VIRTUAL_HEIGHT + 300 + self.position, VIRTUAL_WIDTH , "center")
    love.graphics.printf("Arrows: move", 0, VIRTUAL_HEIGHT + 315 + self.position, VIRTUAL_WIDTH , "center")
    love.graphics.printf("P: Pause", 0, VIRTUAL_HEIGHT + 330 + self.position, VIRTUAL_WIDTH , "center")   
    love.graphics.printf("M: Pause Music", 0, VIRTUAL_HEIGHT + 345 + self.position, VIRTUAL_WIDTH , "center")
    love.graphics.printf("Space Bar: Play", 0, VIRTUAL_HEIGHT + 360 + self.position, VIRTUAL_WIDTH , "center")            

    if self.scrolling == 0 and math.floor(self.pressSpace) % 2 == 0 then
        love.graphics.printf("PUSH SPACEBAR", 0, 110 + self.position, VIRTUAL_WIDTH , "center")
        love.graphics.printf("TO BEGIN", 0, 130 + self.position, VIRTUAL_WIDTH , "center")
    end
end


function Menu:stopSong()
    song:stop()
end

function Menu:startScrolling()
    self.scrolling = 1
end

function Menu: pauseMusic()
    if song:isPlaying() then
        song:pause()
    else
        song:play()
    end
end

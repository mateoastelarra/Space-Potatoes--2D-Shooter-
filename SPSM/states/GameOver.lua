GameOver = Class{}

-- Initialize text fonts
tittleFont = love.graphics.newFont('fonts/Aller_Bd.ttf', 20)
middleFont = love.graphics.newFont('fonts/Aller_Bd.ttf', 15)

-- Initialize table with text for credits
creditsText ={{"A game by: ", "MATEO ASTELARRA "},
              {"2D art from: ", "KENNEY: www.kenney.nl", "NORMA2D: https://ko-fi.com/norma2d"},
              {"Sound Effects from:", "pixabay.com", "Bfxr"},
              {"Music and Story:", "MATEO ASTELARRA"},
              {"Game Design and Programming:", "MATEO ASTELARRA"},
              {"Thanks to: ", "CS50", "GD50", "SHEEPOLUTION", "JESICA DOTTA", "EL GATO CANDOMBE", "KILLING POTATO SPACE TROOPERS"},
              {"Some potatoes where eaten during the making of this video game. They tasted good."}}

-- initialize some assets
assets = {love.graphics.newImage('PNG/Meteors/meteorBrown_big3.png'),
          love.graphics.newImage('Planets/16.png'),
          love.graphics.newImage('Ships/player.png'),
          love.graphics.newImage('Planets/17.png'),
          love.graphics.newImage('PNG/Meteors/meteorBrown_big1.png'),
          love.graphics.newImage('Ships/teo_telecaster.png'),
          love.graphics.newImage('Ships/pure.jfif')
        }


function GameOver:init()
    -- Load music
    gameOver = love.audio.newSource("Sounds/GameOver.mp3", "static")
    credits = love.audio.newSource("Sounds/credits.mp3", "static")
    
    self.pressSpace = 0
    self.scrolling = 0
    self.position = 0
    self.song = gameOver
    self.song2 = credits
    gameOver:play()
    gameOver:setVolume(0.5)
end

function GameOver:update(dt)
    self.pressSpace = self.pressSpace +  dt
    if self.scrolling == 1 then
        self.position = self.position - 15 * dt
    end
end

function GameOver:render()
    if self.scrolling == 0 then
        love.graphics.setFont(tittleFont)
        love.graphics.printf("SMASHED BY POTATOES", 0, 20 + self.position, VIRTUAL_WIDTH, "center")
        love.graphics.setFont(middleFont)
        love.graphics.printf("Your Score: ".. score, 0, 60 + self.position, VIRTUAL_WIDTH, "center")
        love.graphics.printf("Current Max Score: ".. maxScore, 0, 80 + self.position, VIRTUAL_WIDTH, "center")

        if math.floor(self.pressSpace) % 2 == 0 then
            love.graphics.printf("Press Spacebar to Play Again", 0, 100 + self.position, VIRTUAL_WIDTH, "center")
        end
        love.graphics.printf("Press C for game credits", 0, 120 + self.position, VIRTUAL_WIDTH, "center")
    end

    local position = -60
    for i = 1, #creditsText do 
        position = position + 40 
        for j = 1, #creditsText[i] do
            position = position + 20 
            love.graphics.printf(creditsText[i][j], 0, VIRTUAL_HEIGHT + position + self.position, VIRTUAL_WIDTH, "center")
        end
    end

    for i = 1, #assets - 2 do
        position = position + 60
        love.graphics.draw(assets[i], 120, VIRTUAL_HEIGHT + position + self.position, 0, SIZE, SIZE)
    end

    love.graphics.draw(assets[#assets - 1], 100, VIRTUAL_HEIGHT + position + 60 + self.position, 0, 0.1, 0.1)
    love.graphics.draw(assets[#assets], 100, VIRTUAL_HEIGHT + position + 160 + self.position, 0, SIZE, SIZE)
    love.graphics.printf("Thank you Very Much!", 0, VIRTUAL_HEIGHT + position + 240 + self.position, VIRTUAL_WIDTH, "center")
    
end

function GameOver:stopSong()
    self.song:stop()
    self.song2:stop()
end

function GameOver:playCreditsSong()
    self.song2:play()
    self.song2:setVolume(0.5)
end

function GameOver:startScrolling()
    self.scrolling = 1
end
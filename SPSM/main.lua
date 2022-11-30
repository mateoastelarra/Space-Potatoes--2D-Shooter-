Class = require "Class"
push = require "push"
require "states/Menu"
require "states/Game"
require "states/GameOver"
require "helpers"
require "Player"
require "PLanet"
require "CelestialObject"
require "Bullet"
require "Asteroid"
require "Explosion"
require "LoseLife"

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 282
VIRTUAL_HEIGHT = 160


function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.window.setTitle("Space Potatoes")

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
            vsync = true,
            fullscreen = false,
            resizable = true
    })

    math.randomseed(os.time())
    
    -- Initialize some variables, tables and Objects
    transition = false
    actualState = "menu"
    love.keyboard.keysPressed = {}
    menu = Menu()
end

function rezise(w, h)
    push:resize(w, h)
end

function love.update(dt)
    if lives == 0 then
        if score > maxScore then
            maxScore = score
        end
        actualState = ReturnState(actualState)
        transition = true
        lives = 3
        game:stopSong() 
    end
    if transition  == true then
        if actualState == "menu" then 
            menu = Menu()
        elseif actualState == "game" then    
            game = Game()
        elseif actualState == "gameOver" then    
            gameOver = GameOver()
        end
        transition = false
    end
    if actualState == "menu" then 
        menu:update(dt)
    elseif actualState == "game" then    
        game:update(dt)
    elseif actualState == "gameOver" then    
        gameOver:update(dt)
    end
end

function love.draw()
    push:start()
    if actualState == "menu" then 
        menu:render()
    elseif actualState == "game" then    
        game:render()
    elseif actualState == "gameOver" then    
        gameOver:render()
    end
    push:finish()   
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
    -- Change state 
    if key == "space" and (actualState == "menu" or actualState == "gameOver") then
        if actualState == "menu" then
            if menu.scrolling == 0 then
                menu:startScrolling()
            else
                menu:stopSong()
                actualState = ReturnState(actualState)
                transition = true
            end     
        elseif actualState == "gameOver" then
            gameOver:stopSong()
            actualState = ReturnState(actualState)
            transition = true
        end 
    end

    -- Show Credits
    if key == "c" and actualState == "gameOver" then
        gameOver:stopSong()
        gameOver:startScrolling()
        gameOver:playCreditsSong()
    end

    -- Shoot
    if key == "s" and actualState == "game" then
        game:shoot()
    end

    -- Escape
    if key == 'escape' then
        love.event.quit()
    end

    -- Pause Music
    if key == "m" then
        if actualState == "game" then
            game:pauseMusic()
        elseif actualState == "menu" then
            menu:pauseMusic()
        end
    end

    -- Pause Game
    if key =="p" and actualState == "game" then
        game:Pause()
    end
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

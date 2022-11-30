Game = Class{}

-- Load background images, Scrolling speed and width
local stars = love.graphics.newImage("space_background_pack/layers/parallax-space-stars.png")
local starsWidth = stars:getWidth()
local starsScroll = 0
local STARS_SPEED = 30

-- Load lives image and declare counter and score
local livesImage = love.graphics.newImage("PNG/UI/playerLife1_red.png")
lives = 3


-- Declare Score and points bonus for destroyin asteroids
maxScore = 0
local EXPLOSION_BONUS = 2
local ASTEROIDS_SPEED = 1

-- initialize text fonts
smallFont = love.graphics.newFont('fonts/Aller_Bd.ttf', 10)

-- Load sounds
explosionAs = love.audio.newSource("Sounds/explosionAs.wav", "static")
songGame = love.audio.newSource("Sounds/Uno de Naves Espaciales.mp3", "static")
songMenu = love.audio.newSource("Sounds/Pantalla de Inicio.mp3", "static")
loseLife = love.audio.newSource("Sounds/LoseLife1.mp3", "static")
explosionSh = love.audio.newSource("Sounds/explosionSh.wav", "static")
shoot = love.audio.newSource("Sounds/shoot.wav", "static")

-- Declare soun effects volume and 
SOUND_EFFECTS_VOLUMEN = 0.15

function Game:init()
    self.player = Player()

    -- Reset Game Variables and Objects
    spawnTimer = 0    -- to Spawn planer
    spawnTimerCo = 0  -- to spawn stars
    spawnTimerAs = 0  -- to spawn asteroid
    lifeTimer = 1     -- To give inmunity after losing a life
    asteroidFrequency = 1  -- To acelarate asteroid frequency 
    score = 0
    lives = 3
    alive = 1
    pause = 0
    a_scroll = 60 -- Asteroids speed
    planets = {}
    showing_planets = {}
    celestialObjects = {}
    bullets = {}
    asteroids = {}
    explosions = {}

    love.graphics.setFont(smallFont)
    songGame:play()
    songGame:setLooping(true)
    songGame:setVolume(0.5)

end

function Game:update(dt)
    if pause == 0 then
        -- Update scrolling position and spawntimers
        starsScroll = (starsScroll + 30 * dt) % starsWidth
        spawnTimer = spawnTimer + dt
        spawnTimerCo = spawnTimerCo + dt
        spawnTimerAs = spawnTimerAs + dt
        a_scroll = a_scroll + ASTEROIDS_SPEED * dt

        -- Update life timer of ininmunity after dying
        if lifeTimer < 1 then
            lifeTimer = lifeTimer + dt
        end

        if asteroidFrequency > 0.01 then
            asteroidFrequency = asteroidFrequency - (dt / 500)
        end

        -- Spawn new Planets
        if spawnTimer >= 0 then
            planet = Planet()
            if checkPlanet(planet.number) == false then
                table.insert(planets, planet)
                table.insert(showing_planets, planet.number)
            end
            spawnTimer = - math.random(2,5)
        end 

        -- Update and remove Planets that are out of bounds
        for k,planet in pairs(planets) do
            planet:update(dt)
            if planet.x < -planet.width then
                table.remove(planets, k)
                table.remove(showing_planets, k)
            end
        end

        -- Spawn new celestial objects
        if spawnTimerCo >= 0 then
            table.insert(celestialObjects, CelestialObject())
            spawnTimerCo = - math.random(1,4)
        end

        --Update and remove Celestial Objects that are out of bounds
        for k, co in pairs(celestialObjects) do
            co:update(dt)
            if co.x < - co.width then
                table.remove(celestialObjects, k)
            end
        end

        --Spawn new Asteroids
        if spawnTimerAs >= asteroidFrequency then
            table.insert(asteroids, Asteroid(a_scroll))
            spawnTimerAs = 0
        end

        -- Update Asteroids and remove the ones that are out of bounds
        for k, as in pairs(asteroids) do
            as:update(dt)
            if outOfBounds(as.number, as.x, as.y, as.height, as.width) then
                table.remove(asteroids, k)
            end
            for j, aste in pairs(asteroids) do
                -- Check for collisions between asteroids and change trayectory if one of them is significally bigger than the other
                if j ~= k and checkCollisionAs(as, aste) then
                    local bigger = aste.size - as.size
                    local asAngle = as.angle
                    local asNumber = as.number
                    if as.collided <= 0 and bigger > -0.1 then
                        as.angle = aste.angle
                        as.number = aste.number
                        as.collided = 1
                    end
                    if aste.collided <= 0 and bigger < 0.1 then
                        aste.angle = asAngle
                        aste.number = asNumber
                        aste.collided = 1
                    end
                end
            end
        end

        -- Update bullets and remove the ones that are out of bounds
        for k, bu in pairs(bullets) do
            bu:update(dt)
            if bu.x < - bu.width or bu.x > VIRTUAL_WIDTH + bu.width or bu.y < - bu.height or bu.y > VIRTUAL_HEIGHT + bu.height then
                table.remove(bullets,k)
            end 
        end

        -- Check for collisions of potatoes with bullets
        for k, as in pairs(asteroids) do
            for j, bu in pairs(bullets) do
                if checkCollision(as, bu) and alive == 1 then
                    -- Cast animation for explosion acording to Asteroid size
                    table.insert(explosions, Explosion(checkSize(as.size), as.x, as.y))
                    
                    -- Update score, Smaller potatoes give more score
                    score = score + EXPLOSION_BONUS * (50 - math.floor(100 * as.size)) 
                    
                    -- Remove Asteroid and Bullet that collided
                    table.remove(asteroids, k)
                    if explosionAs:isPlaying() then
                        explosionAs:stop()
                    end
                    explosionAs:play()
                    explosionAs:setVolume(SOUND_EFFECTS_VOLUMEN)
                    table.remove(bullets, j)                    
                end
            end  
        end

        -- Update Explosion Animations and delete the ones that ended
        for k,ex in pairs(explosions) do
            ex:update(dt)
            if ex.currentFrame > 11 then
                table.remove(explosions, k)
            end
        end

        -- Check Collisions between player and potatoes and update lives
        for k, as in pairs(asteroids) do
            if alive == 1 and checkCollisionPoPla(as, self.player) and lifeTimer >= 1 then
                loselife = LoseLife(self.player.x, self.player.y)
                loseLife:play()
                loseLife:setVolume(SOUND_EFFECTS_VOLUMEN + 0.1)
                explosionSh:play()
                explosionSh:setVolume(SOUND_EFFECTS_VOLUMEN)
                alive = 0
                lifeTimer = 0
                -- table.insert(explosions, Explosion(checkSize(as.size), as.x, as.y))
                -- table.remove(asteroids, k)
            end
        end

        -- Update PLayer damage animation
        if alive == 0 then
            loselife:update(dt)
        end

        -- Chek if player damage animation ended and lose life
        if alive == 0 and loselife.currentFrame > 7 then
            lives = lives - 1
            lifeTimer = 0
            if lives > 0 then
                alive = 1
            end
        end

        -- Update player
        if alive == 1 then
            self.player:update(dt)
        end
    end
end

function Game:render()
    -- draw stars
    for i = 0, 3 do
        love.graphics.draw(stars,(i * starsWidth / 2) - starsScroll, 0, 0, 0.5, 1)
    end

      -- Draw celestial objects
      for k, co in pairs(celestialObjects) do
        co:render()
    end

    -- Draw planets
    for k, planet in pairs(planets) do
        planet:render()
    end

    -- Draw bullets
    for k, bu in pairs(bullets) do
        bu:render()
    end

    -- Draw asteroids
    for k, as in pairs(asteroids) do
        as:render()
    end

    -- Draw Explotions
    for k, ex in pairs(explosions) do
        ex:render()
    end

    -- Draw Player Damage
    if alive == 0 then
        loselife:render()
    end

    -- Draw lives UI
    for i = 0, lives - 1 do
        love.graphics.draw(livesImage, 15 * i + 3, 3, 0, 0.4, 0.4)
    end

    -- Draw Score
    love.graphics.print("Score: ".. score, VIRTUAL_WIDTH - 80, 3, 0, 1, 1)
    
    -- Draw Player
    if alive == 1 then
        if lifeTimer >= 1 then
            self.player:render()
        elseif math.floor(lifeTimer * 10) % 2 == 0 then
            self.player:render()
        end
    end
end

-- Check if a given planet is already on the screen
function checkPlanet(num)
    for k, planet in pairs(planets) do
        if planet.number == num then
            return true
        end
    end
    return false
end

function Game:shoot()
    if pause == 0 then
        bullet = Bullet(self.player.x, self.player.y, 1, self.player.angle - math.pi / 2)
        if shoot:isPlaying() then
            shoot:stop()
        end
        shoot:play()
        shoot:setVolume(SOUND_EFFECTS_VOLUMEN)
        if alive == 1 then
            table.insert(bullets, bullet)
        end
    end
end

function Game:stopSong()
    songGame:stop()
end

function Game: pauseMusic()
    if pause == 0 then
        if songGame:isPlaying() then
            songGame:pause()
        else
            songGame:play()
        end
    end
end

function Game:Pause()
    if pause == 0 then
        songGame:pause()
    elseif pause == 1 then 
        songGame:play()
    end
    pause = (pause + 1) % 2   
end


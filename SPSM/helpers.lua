function ReturnState(state)
    if state == "menu" then
        return "game"
    elseif state == "game" then
        return "gameOver"
    elseif state == "gameOver" then
        return "game"
    end 
end

-- Collision between asteroids
function checkCollisionAs(a, b)
    local a_left = a.x
    local a_right = a.x + a.width
    local a_top = a.y
    local a_bottom = a.y + a.height
 
    local b_left = b.x
    local b_right = b.x + b.width
    local b_top = b.y
    local b_bottom = b.y + b.height

    --Directly return this boolean value without using if-statement
    return  a_right > b_left
        and a_left < b_right
        and a_bottom > b_top
        and a_top < b_bottom
end


--Collision between Potatoes and Bullets
function checkCollision(a, b)
    local a_left = a.x
    local a_right = a.x + a.width
    local a_top = a.y
    local a_bottom = a.y + a.height

    local sign1 = - math.sin(b.angle)
    local sign2 = math.cos(b.angle)
    local b_top
    local b_bottom 
    local b_left
    local b_right 
    
    if b.angle == - math.pi /2 or b.angle == - 3 * math.pi / 4 then
        b_top = b.y 
        b_bottom = b.y + sign1 * b.height + sign2 * b.width
        b_left = b.x
        b_right = b.x + sign1 * b.width - sign2 * b.height
    elseif b.angle == math.pi / 2 or b.angle == math.pi / 4 then
        b_top = b.y + sign1 * b.height + sign2 * b.width
        b_bottom = b.y
        b_left = b.x + sign1 * b.width - sign2 * b.height
        b_right = b.x 
    elseif b.angle == math.pi or b.angle == - 5 * math.pi / 4 then 
        b_left = b.x
        b_right = b.x + sign1 * b.width - sign2 * b.height
        b_top = b.y + sign1 * b.height + sign2 * b.width
        b_bottom = b.y
    elseif b.angle == 0 or b.angle ==  - math.pi / 4  then
        b_top = b.y 
        b_bottom = b.y + sign1 * b.height + sign2 * b.width
        b_left = b.x + sign1 * b.width - sign2 * b.height
        b_right = b.x 
    end

    --Directly return this boolean value without using if-statement
    return  a_right > b_left
        and a_left < b_right
        and a_bottom > b_top
        and a_top < b_bottom
end

-- Collision between Potatoes and player, b is the player
function checkCollisionPoPla(a, b)
    local a_left = a.x
    local a_right = a.x + a.width
    local a_top = a.y
    local a_bottom = a.y + a.height 

    local b_left = b.x - b.width / 2
    local b_right = b.x + b.width / 2
    local b_top = b.y - b.height / 2
    local b_bottom = b.y + b.height / 2

    --Directly return this boolean value without using if-statement
    return  a_right > b_left
        and a_left < b_right
        and a_bottom > b_top
        and a_top < b_bottom
end


-- Function to chek asteroid size an select Animation for explosion
function checkSize(a)
    if a <= 0.16 then
        return 2
    elseif a <= 24 then
        return 3
    else 
        return 1
    end
end

-- Function to decide what Asteroid has to be deleted accordint to where it was spawned and size
function outOfBounds(a, x, y, w, h)
    if (a == 1 and y > VIRTUAL_HEIGHT + h)
        or (a == 2 and x < -w)
        or (a == 3 and y < -h)
        or (a == 4 and x> VIRTUAL_WIDTH + w) then
            return true
    end
    return false
end
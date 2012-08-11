
--Esto representa a inicializar
function love.load()
    map = love.graphics.newImage("images/map.jpg")

    skin30 = love.graphics.newImage("images/plane1/30.png")
    skin75 = love.graphics.newImage("images/plane1/75.png")
    skin90 = love.graphics.newImage("images/plane1/90.png")
    skin135 = love.graphics.newImage("images/plane1/135.png")
    skin150 = love.graphics.newImage("images/plane1/150.png")
    skinPlane = { skin30, skin75, skin90, skin135, skin150}
    plane1 = { x = 200, y = 200, rot = 0, rotH = 90, skin = skinPlane}

    --Variables globales
    delta_rotH = 10

    width = skin30:getWidth()
    height = skin30:getHeight()
end

function love.draw()
    love.graphics.draw(map, 0, 0)
    love.graphics.print(plane1.rotH, 0, 0)

    love.graphics.print(delta_x, 200, 0)
    love.graphics.print(delta_y, 350, 0)

    love.graphics.draw(actualSkin, plane1.x, plane1.y, plane1.rotH*0.1, 1, 1, width / 2, height / 2)    
end

function love.update()

    actualSkin = plane1.skin[3]
    -- if plane1.rotH <= 30 then
    --     actualSkin = plane1.skin[1]
    -- elseif plane1.rotH <= 75 then
    --     actualSkin = plane1.skin[2]
    -- elseif plane1.rotH <= 90 then
    --     actualSkin = plane1.skin[3]
    -- elseif plane1.rotH <= 135 then
    --     actualSkin = plane1.skin[4]
    -- else 
    --     actualSkin = plane1.skin[5]
    -- end

    delta_x = math.sin((plane1.rotH - 90) * 0.1)
    delta_y = math.cos((plane1.rotH - 90) * 0.1)

    plane1.x = plane1.x - (delta_x * 10)
    plane1.y = plane1.y - (delta_y * 10)

    if love.keyboard.isDown("a") then
        plane1.rotH = plane1.rotH - delta_rotH
    end

    if love.keyboard.isDown("d") then
        plane1.rotH = plane1.rotH + delta_rotH
    end

    if plane1.rotH < 0 then
        plane1.rotH = 0
    end

    if plane1.rotH > 200 then
        plane1.rotH = 200
    end
end

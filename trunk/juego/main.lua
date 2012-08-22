require "table"

--Esto representa a inicializar
function love.load()
    map = love.graphics.newImage("images/map.jpg")

    skin75 = love.graphics.newImage("images/plane1/75.png")
    skin90 = love.graphics.newImage("images/plane1/90.png")
    skin135 = love.graphics.newImage("images/plane1/135.png")
    skinPlane = { skin75, skin90, skin135}
    plane1 = { x = 500, y = 500, rot = 90, skin = skinPlane}

    --global variables
    delta_rot = 1.8

    width = skin90:getWidth()
    height = skin90:getHeight()

    activeRays = {}

    --collisions 
    world = love.physics.newWorld(0, 0, true)

    solidPlane1 = {}
    solidPlane1.b = love.physics.newBody(world, plane1.x, plane1.y, "dynamic")  -- set x,y position (400,200) and let it move and hit other objects ("dynamic")
    solidPlane1.b:setMass(0)                                        -- make it pretty light
    solidPlane1.s = love.physics.newCircleShape(50)                  -- give it a radius of 50
    solidPlane1.f = love.physics.newFixture(solidPlane1.b, solidPlane1.s)          -- connect body to shape
    solidPlane1.f:setRestitution(0.4)                                -- make it bouncy
    solidPlane1.f:setUserData("solidPlane1")                         -- give it a name, which we'll access later

    solidPlane2 = {}
    solidPlane2.b = love.physics.newBody(world, 500, 200, "dynamic")  -- set x,y position (400,200) and let it move and hit other objects ("dynamic")
    solidPlane2.b:setMass(0)                                        -- make it pretty light
    solidPlane2.s = love.physics.newCircleShape(50)                  -- give it a radius of 50
    solidPlane2.f = love.physics.newFixture(solidPlane2.b, solidPlane2.s)          -- connect body to shape
    solidPlane2.f:setRestitution(0.4)                                -- make it bouncy
    solidPlane2.f:setUserData("solidPlane2")                         -- give it a name, which we'll access later



    world:setCallbacks(beginContact, endContact, preSolve, postSolve)

    contact = 0
end

function love.draw()
    love.graphics.draw(map, 0, 0)
    love.graphics.print(plane1.rot, 0, 0)

    love.graphics.print(delta_x, 200, 0)
    love.graphics.print(delta_y, 350, 0)

    love.graphics.draw(actualSkin, plane1.x, plane1.y, -(plane1.rot-90)*0.1, 1, 1, width / 2, height / 2)    

    love.graphics.print( table.maxn(activeRays), 0, 10)

    drawRay = function(key, ray)
        length = 20

        delta_x = math.sin((ray.rot - 90) * 0.1)
        delta_y = math.cos((ray.rot - 90) * 0.1)

        x2 = ray.x - (delta_x * length)
        y2 = ray.y - (delta_y * length)

        love.graphics.setColor(255, 0, 0) 
        love.graphics.setLine(2, "smooth")
        love.graphics.line(ray.x, ray.y, x2, y2)
    end

    table.foreach(activeRays, drawRay)

    love.graphics.print(contact, 10, 50)

    love.graphics.reset()

    love.graphics.circle("line", solidPlane2.b:getX(),solidPlane2.b:getY(), solidPlane2.s:getRadius(), 20)
end

function love.update(dt)

    actualSkin = plane1.skin[2]
    
    delta_x = math.sin((plane1.rot - 90) * 0.1)
    delta_y = math.cos((plane1.rot - 90) * 0.1)

    plane1.x = plane1.x - (delta_x * 10)
    plane1.y = plane1.y - (delta_y * 10)

    if love.keyboard.isDown("a") then
        plane1.rot = plane1.rot + delta_rot
        actualSkin = plane1.skin[1]
    end

    if love.keyboard.isDown("d") then
        plane1.rot = plane1.rot - delta_rot
        actualSkin = plane1.skin[3]
    end

    if love.keyboard.isDown("w") then
        newRay = {x = plane1.x, y = plane1.y, rot = plane1.rot }
        table.insert(activeRays, newRay)
    end

    updateRay = function(key, ray)
        speed = 30

        delta_x = math.sin((ray.rot - 90) * 0.1)
        delta_y = math.cos((ray.rot - 90) * 0.1)

        x2 = ray.x - (delta_x * speed)
        y2 = ray.y - (delta_y * speed)

        ray.x = x2
        ray.y = y2
    end

    table.foreach(activeRays, updateRay)

    --collision
    solidPlane1.b:setX(plane1.x) 
    solidPlane1.b:setY(plane1.y)  
    world:update(dt)
end

function beginContact(a, b, coll)
    contact = contact + 1
end

function endContact(a, b, coll)
    
end

function preSolve(a, b, coll)
    
end

function postSolve(a, b, coll)
    
end

--Esto representa a inicializar
function love.load()
	m = 0
end

function love.draw()
	love.graphics.print(m,100,200)
end

function love.update()
	if love.keyboard.isDown("up") then
    	m = m + 1
	end
end

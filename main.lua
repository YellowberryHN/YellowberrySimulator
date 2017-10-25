local o_ten_one = require "splash"

local done

local function mainGame()
	love.graphics.setColor(0, 255, 0, 255)
	love.graphics.print("Hello World!", 400, 300)
	print("yoyoyo")
end

function love.load()
	splash = o_ten_one({background=false})
	splash.onDone = function() done = true end
end

function love.update(dt)
	if not done then
		splash:update(dt)
	end
end

function love.draw()
	if not done then
		splash:draw()
	else
		mainGame()
	end
end

function love.keypressed()
	splash:skip()
end

local o_ten_one = require "splash"

local function mainGame()
	love.graphics.setColor(0, 255, 0, 255)
	love.graphics.print("Hello World!", 400, 300)
	print("yoyoyo")
end	

function love.load()
  splash = o_ten_one({background=false})
  splash.onDone = function() print("DONE") end
end

function love.update(dt)
  splash:update(dt)
end

function love.draw()
  splash:draw()
  mainGame()
end

function love.keypressed()
  splash:skip()
end
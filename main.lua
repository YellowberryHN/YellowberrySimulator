local o_ten_one = require "lib.splash"
local Gamestate = require "lib.hump.gamestate"

local splashState = {}
local hnsplash = {}
local game = {}

function love.load()
	--love.mouse.setGrabbed(true)
	--love.mouse.setVisible(false) -- make default mouse invisible
	mx, my, mw, mh = 0, 0, 20, 20
	w2, h2 = love.graphics.getDimensions( )
    Gamestate.registerEvents()
    Gamestate.switch(splashState)
end

function love.update(dt)

end

function love.draw()

end

function love.keypressed(key)
	splash:skip()
	if key == "tab" then
		local state = not love.mouse.isGrabbed()   -- the opposite of whatever it currently is
		love.mouse.setGrabbed(state)
	end
end

function splashState:init()
	splash = o_ten_one({background={0,0,0}})
  	splash.onDone = function() Gamestate.switch(hnsplash) end
end

function splashState:draw()
	splash:draw()
    --love.graphics.print("Press Enter to continue", 10, 10)
end

function splashState:update(dt)
	splash:update(dt)
end

function splashState:keyreleased(key, code)
	splash:skip()
end

function hnsplash:init()
	hnLogo = love.graphics.newImage("tex/hnLogo.png")

	w2 = love.graphics.getWidth() / 2   -- half the window width
    h2 = love.graphics.getHeight() / 2   -- half the window height
end

function hnsplash:draw()
    love.graphics.draw( hnLogo, w2-256, h2-256, 0, 1,1, 0, 0 )
end

function hnsplash:update(dt)
	--hsplash:update(dt)
end

function hnsplash:keyreleased(key, code)
	if key == 'return' then
        Gamestate.switch(game)
    end
end

function game:enter()
    --Entities.clear()
    -- setup entities here
end

function game:update(dt)
    --Entities.update(dt)
    mx, my = love.mouse.getPosition() -- get the position of the mouse
	mw = 20--x2 + 20
	mh = 20--y2 + 20
end

function game:draw()
    --Entities.draw()
    love.graphics.setColor(0, 100, 100)
	love.graphics.rectangle("fill", mx, my, mw, mh)
	love.graphics.setColor(200, 200, 100)
	love.graphics.rectangle("fill", mx, my, mw/2, mh/2)
    love.graphics.setColor(0, 255, 0, 255)
	love.graphics.print("Hello World!", 400, 300)
	print("yoyoyo")
end
local o_ten_one = require "lib.splash"
local Gamestate = require "lib.hump.gamestate"
local audio = require 'lib.wave'

-- suit up
local suit = require 'lib.suit'

-- storage for text input
local input = {text = ""}

local splashState = {}
--local hnsplash = {}
local game = {}
local menu = {}

function love.load()
	--love.mouse.setGrabbed(true)
	--love.mouse.setVisible(false) -- make default mouse invisible
	mx, my, mw, mh = 0, 0, 20, 20
	w2, h2 = love.graphics.getDimensions( )
	Gamestate.registerEvents()
	Gamestate.switch(splashState)
	title = love.window.getTitle()
end

function love.update(dt)
	love.window.setTitle(title .. " v" .. math.floor(dt*1000000))
end

function love.draw()

end

function love.keypressed(key)
	splash:skip()
	if key == "tab" then
		local state = not love.mouse.isGrabbed()   -- the opposite of whatever it currently is
		love.mouse.setGrabbed(state)
	end
	suit.keypressed(key)
end

function splashState:init()
	splash = o_ten_one({background={0,0,0}})
	splash.onDone = function() Gamestate.switch(menu) end--Gamestate.switch(hnsplash) end
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

--[[
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
--]]

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

function menu:update()
	-- put the layout origin at position (100,100)
	-- the layout will grow down and to the right from this point
	resetPad = 10
	suit.layout:reset(10,10)
	suit.layout:padding(10)

	-- put an input widget at the layout origin, with a cell size of 200 by 30 pixels
	suit.Input(input, suit.layout:row(love.graphics.getWidth()-resetPad*2,30))
	
	-- put a label that displays the text below the first cell
	-- the cell size is the same as the last one (200x30 px)
	-- the label text will be aligned to the left
	suit.Label("Hello, "..input.text, {align = "left"}, suit.layout:row())

	-- put an empty cell that has the same size as the last cell (200x30 px)
	suit.layout:row()
	
	-- put a button of size 200x30 px in the cell below
	-- if the button is pressed, quit the game
	if suit.Button("ploy gaem", suit.layout:row(love.graphics.getWidth()-resetPad*2,30,10, love.graphics.getHeight()-70 )).hit then
		Gamestate.switch(game)
	end

	-- put a button of size 200x30 px in the cell below
	-- if the button is pressed, quit the game
	if suit.Button("Close", suit.layout:row()).hit then
		love.event.quit()
	end
end

function menu:draw()
	suit.draw()
end

function menu:init()

end

function menu:enter()
	local music = audio:newSource("mus/mus1.xm", "stream")
	music:play()
end

function love.textinput(t)
	-- forward text input to SUIT
	suit.textinput(t)
end
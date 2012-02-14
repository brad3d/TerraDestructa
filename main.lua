-- Project: TerraDestructa
-- Description:
--
-- Version: 1.0
-- Managed with http://CoronaProjectManager.com
--
-- Copyright 2012 Brad Herman. All Rights Reserved.
---- cpmgen main.lua

main = display.newGroup ( )
movingObjects = display.newGroup ( )

local background = display.newImage("background.png")

local terra = require("terra")
terra.debug = false
local physics = require("physics")

physics.start()
physics.setGravity( 0, 9.8 )
display.setStatusBar(display.HiddenStatusBar)
--[[
local resetButton = display.newRect(  0, 0, 32, 32 )
resetButton:setFillColor ( 255, 0, 0 ,128 )
]]

local gameStart = function()
local balls = {}
for i=1 , 18 do
	local ball = display.newRoundedRect( 68+ i*10, 0, 15, 15, 7.5 )
	movingObjects:insert(ball)
	ball:setFillColor (64, 64, 244  )
	table.insert(balls,ball)
	physics.addBody( ball, { density = 1.0, friction = 0.0, bounce = 0.4, radius = 5 } )
end

terra.bounce = .8
terra.carve = false -- if this is true then we do the save image / load image mask replace background carving, very alpha and slow
-- using terra.carve you MUST have the terrain size divisable by 4, its a mask issue
-- terra.carve works in the simulator for iphone, other devices do not work yet
-- terra carve is SLOW on hardware due to save/load of jpg

terra.BGdrawCarve = true


local graphics = { hole="hole_16.png",
							edge="edge_16.png",
							dirt="dirt_16.png"
						}


terra.newTerrain(0,48,20,27,16,16,graphics)  -- our 'mid' res  with Graphics
--terra.newTerrain(0,40,40,55,8,8,"rect")   -- our 'high' res
--terra.newTerrain(0,32,20,28,16,16,"rect")  -- our 'mid' res  
--terra.newTerrain(0,32,10,14,32,32,"rect")  -- our 'low' res  
--terra.newTerrain(17,20,9,9,32,32,"rect")  -- our 'test' res  
main:insert(terra.dynamicMask)
main:insert( background )



main:insert( terra.displayGroupFG )
--main:insert(terra.dynamicMask)
main:insert(terra.carveMask)
main:insert( movingObjects )
main:insert( terra.displayGroup )



--main:insert(resetButton)
end

--[[local resetGame = function()
gameStart()
end
]]
gameStart()

--resetButton:addEventListener("tap",resetGame)
Runtime:addEventListener ("enterFrame",terra.enterFrameProcess)		--this event processes our terrain each frame

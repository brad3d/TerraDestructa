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
--terra.debug = true
local physics = require("physics")

physics.start()

physics.setGravity( 0, 9.8 )

display.setStatusBar(display.HiddenStatusBar)

for i=1 , 18 do
	local ball = display.newRoundedRect( 68+ i*10, 0, 15, 15, 7.5 )
	movingObjects:insert(ball)
	ball:setFillColor (64, 64, 244  )
physics.addBody( ball, { density = 1.0, friction = 0.0, bounce = 0.4, radius = 5 } )

end



terra.bounce = .8
terra.newTerrain(0,40,32,44,10,10,"rect")
main:insert( background )
main:insert( terra.displayGroupFG )
main:insert( movingObjects )
main:insert( terra.displayGroup )
--main:insert(terra.dynamicMask)



Runtime:addEventListener ("enterFrame",terra.enterFrameProcess)		--this event processes our terrain each frame

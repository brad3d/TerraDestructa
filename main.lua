-- Project: TerraDestructa
-- Description:
--
-- Version: 1.0
-- Managed with http://CoronaProjectManager.com
--
-- Copyright 2012 Brad Herman. All Rights Reserved.
---- cpmgen main.lua

local terra = require("terra")
terra.debug = true
local physics = require("physics")
--physics.setDrawMode( "hybrid" )
physics.start()
physics.pause()
physics.setGravity( 0, 9.8 )

display.setStatusBar(display.HiddenStatusBar)


local ball = display.newRoundedRect(  50, 0, 25, 25, 15 )
physics.addBody( ball, { density = 1.0, friction = 0.3, bounce = 0.2, radius = 13 } )


local ball = display.newRoundedRect(  100, 0, 25, 25, 15 )
physics.addBody( ball, { density = 1.0, friction = 0.3, bounce = 0.2, radius = 13 } )


local ball = display.newRoundedRect(  150, 0, 25, 25, 15 )
physics.addBody( ball, { density = 1.0, friction = 0.3, bounce = 0.2, radius = 13 } )


terra.newTerrain(0,100,32,32,10,10,"rect")


physics.start( true )


Runtime:addEventListener ("enterFrame",terra.enterFrameProcess)		--this event processes our terrain each frame

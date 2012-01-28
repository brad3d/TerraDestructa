-- Project: TerraDestructa
-- Description:
--
-- Version: 1.0
-- Managed with http://CoronaProjectManager.com
--
-- Copyright 2012 Brad Herman. All Rights Reserved.
---- cpmgen main.lua

local terra = require("terra")
--terra.debug = true
local physics = require("physics")

physics.start()
physics.pause()
physics.setGravity( 0, 9.8 )

display.setStatusBar(display.HiddenStatusBar)

for i=1 , 40 do
	local ball = display.newRoundedRect(  i*5, 0, 10, 10, 5 )
physics.addBody( ball, { density = 1.0, friction = 0.3, bounce = 0.4, radius = 5 } )

end



terra.bounce = .8
terra.newTerrain(0,40,34,44,10,10,"rect")


physics.start( true )


Runtime:addEventListener ("enterFrame",terra.enterFrameProcess)		--this event processes our terrain each frame

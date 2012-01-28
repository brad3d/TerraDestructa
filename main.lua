-- Project: TerraDestructa
-- Description:
--
-- Version: 1.0
-- Managed with http://CoronaProjectManager.com
--
-- Copyright 2012 Brad Herman. All Rights Reserved.
---- cpmgen main.lua

local terra = require("terra")

local physics = require("physics")
physics.start()

display.setStatusBar(display.HiddenStatusBar)

--test = display.newRect(0,0,128,64)
--test:setFillColor ( 64, 100, 27 ,255 )

terra.newTerrain(10,10,15,15,"rect")

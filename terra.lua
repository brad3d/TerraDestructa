-- This is Brads Destructble terrain test system
-- define a local table to store all references to functions/variables
local M = {}  
ocal physics = require("physics")

-- Private Variables to this Lib, with good method coding the user never should see this stuff
M.w = 10
M.h = 10
M.terraGrid = {}
M.terraLookup = {}
M.displayGroup = display.newGroup ( )


-- functions are now local:
local newTerrain = function(width,height,pxW,pxH,img)
    print( "init New Terrain" )
    M.w = width
    M.h = height
    
    for w = 1, M.w do
    	M.terraGrid[w]= {}
    	for h = 1, M.h do
    		if img == "rect" then
    			M.terraGrid[w][h] = display.newRect( M.displayGroup, (w-1)*pxW, (h-1)*pxH, pxW, pxH )  --Create a Rect for Terrain, this should be an image eventualy
    			M.terraGrid[w][h]:addEventListener ( "touch", M.terrainTouch )
    			M.terraGrid[w][h]:setFillColor ( math.random(0,255), math.random(0,255), math.random(0,255)  )
    			physics.addBody ( M.terraGrid[w][h],  {density=.5, friction=.03, bounce=.5} )
    		end
    	end
    end
    
end
-- assign a reference to the above local function
M.newTerrain = newTerrain

local terrainTouch = function(event)
    print( "Touched it",event.phase )
end
M.terrainTouch = terrainTouch

local testFunction3 = function(val)
    print( "Test 3" )
    M.example = val + M.myValue
end
M.testFunction3 = testFunction3


local testFunction4 = function()
    print( "Test 4" .. M.myString )
    print(M.example)
end
M.testFunction4 = testFunction4


-- Finally, return the table to be used locally elsewhere
return M
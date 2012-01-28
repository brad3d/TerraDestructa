-- This is Brads Destructble terrain test system
-- define a local table to store all references to functions/variables
local M = {}  
local physics = require("physics")

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
    	local count = 1
    	for h = 1, M.h do
    		if img == "rect" then
    			M.terraGrid[w][h] = display.newRect( M.displayGroup, (w-1)*pxW, (h-1)*pxH, pxW, pxH )  --Create a Rect for Terrain, this should be an image eventualy
    			M.terraGrid[w][h]:addEventListener ( "touch", M.terrainTouch )
    			M.terraGrid[w][h]:setFillColor ( math.random(0,255), math.random(0,255), math.random(0,255)  )
    			M.terraGrid[w][h].name = count
    			M.terraLookup[count] = {}
    			M.gridLookup(count)
    			physics.addBody ( M.terraGrid[w][h],  "static",{density=.5, friction=.03, bounce=.5} )
    		end
    		count = count + 1
    	end
    end
    
end
-- assign a reference to the above local function
M.newTerrain = newTerrain

local terrainTouch = function(event)
    print( "Touched it",event.phase )
    --remove the object touched here
end
M.terrainTouch = terrainTouch

local gridTest = function(target)
	-- for loop of the array in side here: M.terraLookup[target.name]
end
M.gridTest = gridTest


local gridLookup = function(id)
-- Look up the 8 squares around us top row, middle row, bottom row
-- 1,2,3
-- 4,x,6
-- 7,8,9

end
M.gridLookup = gridLookup


-- Finally, return the table to be used locally elsewhere
return M
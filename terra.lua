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
M.removeQueue = {}
M.debug = false


-- functions are now local:
local newTerrain = function(x,y,width,height,pxW,pxH,img)
    print( "init New Terrain" )
    M.w = width
    M.h = height
    local count = 1
    for w = 1, M.w do
    	M.terraGrid[w]= {}
    	for h = 1, M.h do
    		if img == "rect" then
    			M.terraGrid[w][h] = display.newRect( M.displayGroup, (w-1)*pxW+x, (h-1)*pxH+y, pxW, pxH )  --Create a Rect for Terrain, this should be an image eventualy
    			--display.newText(  count,  (w-1)*pxW+x, (h-1)*pxH+y,nil,10)
    			M.terraGrid[w][h]:addEventListener ( "touch", M.terrainTouch )
    			M.terraGrid[w][h]:setFillColor ( math.random(0,255), math.random(0,255), math.random(0,255)  )
    			M.terraGrid[w][h].name = count
    			M.terraLookup[count] = {}
    			M.gridLookup(count)
    			physics.addBody ( M.terraGrid[w][h],  "static",{density=.5, friction=.1, bounce=.4} )
    		end
    		count = count + 1
    	end
    end
    
end
-- assign a reference to the above local function
M.newTerrain = newTerrain

local terrainTouch = function(event)
    if M.debug then print( "Touched it",event.phase ,event.target.name) end
    --M.removeBlock(event.target)
    M.removeQueue[event.target] = event.target
    --remove the object touched here
end
M.terrainTouch = terrainTouch


local removeBlock = function(target)
	if target then
	if M.debug then print("removing",target.name) end
	physics.removeBody(target ) 	 	--remove our physics objects
	display.remove(target)					-- remove display objects
	--M.displayGroup:remove(target)
	target = nil 									-- remove the display object from memory now
	end
end
M.removeBlock = removeBlock



local enterFrameProcess = function()
	--print(#M.removeQueue)
	for k,v in pairs(M.removeQueue) do					 
			M.removeBlock(M.removeQueue[k])			
	end
	M.removeQueue = {}


end
M.enterFrameProcess = enterFrameProcess

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
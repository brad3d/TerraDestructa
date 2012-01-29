-- This is Brads Destructble terrain test system
-- define a local table to store all references to functions/variables
local M = {}  
local physics = require("physics")

-- Private Variables to this Lib, with good method coding the user never should see this stuff

M.x = 0
M.y = 0
M.w = 10
M.h = 10
--M.terraGrid = {}
M.terraLookup = {}
M.displayGroup = display.newGroup ( )
M.displayGroupFG = display.newGroup ( )
M.dynamicMask = display.newGroup();
M.alphaRect = nil
M.removeQueue = {}
M.debug = false
M.bounce = .5
M.friction = 0.02
M.density = .5
M.pxH = 10
M.pxW = 10
M.boundRect = nil





-- functions are now local:
local newTerrain = function(x,y,width,height,pxW,pxH,img)
    print( "init New Terrain" )
    if M.debug then physics.setDrawMode( "hybrid" ) end
    

    
    	
    M.x = x
	M.y = y
    M.w = width
    M.h = height
    M.pxH = pxH
	M.pxW = pxW
    M.dynamicMask:toBack();
    M.alphaRect =  display.newRect( M.displayGroupFG, x,y, M.w * M.pxW, M.h * M.pxH ) 
	M.alphaRect:setFillColor(255,255,255)
    M.dynamicMask:insert(M.alphaRect);	
	
	M.boundRect =  display.newRect( M.displayGroupFG, x,y, M.w * M.pxW, M.h * M.pxH ) 
	M.boundRect:setFillColor(64,28,28)
	M.boundRect:addEventListener ( "touch", M.terrainBoundTouch )
	M.radius =  (((M.pxW+M.pxH)/2)/2) * .9
	
    local count = 1
    for w = 1, M.w do
    	--M.terraGrid[w]= {}
    	for h = 1, M.h do
    		if img == "rect" then
    			--M.terraGrid[w][h] = display.newRect( M.displayGroup, (w-1)*pxW+x, (h-1)*pxH+y, pxW, pxH )  --Create a Rect for Terrain, this should be an image eventualy
    			if M.debug then display.newText(  count,  (w-1)*pxW+x, (h-1)*pxH+y,nil,7) end
    			--M.terraGrid[w][h]:addEventListener ( "touch", M.terrainTouch )
    			--M.terraGrid[w][h]:setFillColor ( math.random(0,255), math.random(0,255), math.random(0,255),0  )
    			--M.terraGrid[w][h] = {}
    			--M.terraGrid[w][h].name = count
    			M.terraLookup[count] =  {}
    			M.terraLookup[count]["w"] = w
    			M.terraLookup[count]["h"] = h
    			M.terraLookup[count]["state"] = "dirt"
    			M.terraLookup[count]["grid"] = M.gridLookup(count)
    			if M.terraLookup[count]["state"] == "edge" then 	
    				local object = display.newRect( M.displayGroup, (w-1)*pxW+x, (h-1)*pxH+y, pxW, pxH )		
    				physics.addBody ( object,  "static",{density=M.density, friction=M.friction, bounce=M.bounce,radius = M.radius } )
    				object:setFillColor(128,128,128)
    				M.terraLookup[count]["object"]   =  object
    			end
    		end
    		count = count + 1
    	end
    end
    
end
-- assign a reference to the above local function
M.newTerrain = newTerrain

--[[
local terrainTouch = function(event)
    if M.debug then print( "Touched it",event.phase ,event.target.name) end
    --M.removeBlock(event.target)
    M.removeQueue[event.target] = event.target
    --remove the object touched here
end
M.terrainTouch = terrainTouch
]]

local terrainBoundTouch = function(event)
 if M.debug then print( "Touched it",event.phase ,event.x,event.y) end
    --M.removeQueue[event.target] = event.target
    --remove the object touched here
    local id = M.coord2grid(event.x,event.y)
	M.removeQueue[id] = id
	M.updateMask(id)
    
end
M.terrainBoundTouch = terrainBoundTouch


local updateMask = function(id)  --update our mask image
	local newCarve = display.newRect( M.displayGroup, (M.terraLookup[id]["w"]-1)*M.pxW+M.x, (M.terraLookup[id]["h"]-1)*M.pxH+M.y, M.pxW, M.pxH )
	newCarve:setFillColor(0,0,0)
	M.dynamicMask:insert(newCarve);
	display.save (M.dynamicMask, "tmp.jpg",  system.DocumentsDirectory)
	local mask = graphics.newMask( "tmp.jpg", system.DocumentsDirectory )
	M.boundRect:setMask(nil)

	M.boundRect:setMask(mask)
    M.boundRect.maskX = .01;--display.contentWidth/4

    M.boundRect.maskY = .01;--display.contentHeight/4        
        
end
M.updateMask = updateMask


local removeBlock = function(id)
	--if target then
	if M.debug then print("removing",id) end
	physics.removeBody(M.terraLookup[id]["object"] ) 	 	--remove our physics objects
	display.remove(M.terraLookup[id]["object"])					-- remove display objects
	M.terraLookup[id]["state"] = "hole"
	--M.displayGroup:remove(target)
	--target = nil 									-- remove the display object from memory now
	--end
end
M.removeBlock = removeBlock



local enterFrameProcess = function()
	--print(#M.removeQueue)
	for k,v in pairs(M.removeQueue) do
			if M.terraLookup[k]["state"] == "dirt" then
			M.gridTestbyID(k)	
				
			elseif M.terraLookup[k]["state"] == "edge" then
			M.gridTestbyID(k)
			M.removeBlock(k)
			
			
			end
			M.terraLookup[k]["state"] = "hole"
								 
			
			--			
	end
	M.removeQueue = {}


end
M.enterFrameProcess = enterFrameProcess

--[[
local gridTest = function(target)  		-- OLD
	-- for loop of the array in side here: M.terraLookup[target.name]
	for k,v in pairs(M.terraLookup[target.name]["grid"]) do
		if M.terraLookup[v]["state"] == "dirt" then
			M.terraLookup[v]["object"] = display.newRect( M.displayGroup, (w-1)*M.pxW+x, (h-1)*M.pxH+y, M.pxW, M.pxH )
			M.terraLookup[v]["object"]:setFillColor(128,128,128)
			M.terraLookup[v]["state"] = "edge"
			physics.addBody ( M.terraLookup[v]["object"],  "static",{density=.5, friction=0.02, bounce=.5 ,radius = ((M.pxW+M.pxH)/2)/2  } )
		end
	end

end
M.gridTest = gridTest
]]

local gridTestbyID = function(id)  		-- OLD
	-- for loop of the array in side here: M.terraLookup[target.name]
	for k,v in pairs(M.terraLookup[id]["grid"]) do
		if v ~= id then
		if M.terraLookup[v]["state"] == "dirt" then
			M.terraLookup[v]["object"] = display.newRect( M.displayGroup, (M.terraLookup[v]["w"]-1)*M.pxW+M.x, (M.terraLookup[v]["h"]-1)*M.pxH+M.y, M.pxW, M.pxH )
			M.terraLookup[v]["object"]:setFillColor(128,128,128)
			M.terraLookup[v]["state"] = "edge"
			physics.addBody ( M.terraLookup[v]["object"],  "static",{density=.5, friction=0.02, bounce=.5 ,radius =M.radius  } )
		end
		end

	end

end
M.gridTestbyID = gridTestbyID



local coord2grid  = function(x,y)
	w = math.ceil(((x-M.x) / (M.w * M.pxW)) *M.w)
	h = math.ceil(((y-M.y) / (M.h * M.pxH)) *M.h)
	if M.debug then print(w,h,((w-1)*M.h)+h) end
	id = ((w-1)*M.h)+h
	return id
end
M.coord2grid = coord2grid

local gridLookup = function(id)
-- Look up the 8 squares around us top row, middle row, bottom row
-- 1,2,3
-- 4,x,6
-- 7,8,9
	local id2 = nil
	local id1 = nil
	local id3 = nil
	local id4 = nil
	local id5 = id
	local id6 = nil
	 local id7 = nil
	 local id8 = nil
	 local id9 = nil
	 	
if (id%M.h)-1 == 0 then   	--we are the top edge
	 id2 = nil
	 id1 = nil
	 id3 = nil
	 M.terraLookup[id]["state"] = "edge"
else  									--not the top edge store values
	 id2 = id-1
	 id1 = id2-M.h
	 id3 = id2+M.h
end

if (id%M.h) == 0 then   	--we are the bottom edge
	 id7 = nil
	 id8 = nil
	 id9 = nil
	 M.terraLookup[id]["state"] = "edge"
else  									--not the top edge store values
 	id8 = id+1
 	id7 = id8-M.h
 	id9 = id8+M.h
end


if id-M.h < 1 then 	-- left edge
	 id4 = nil  --center left and fix edge
	 id1 = nil
	 id7 = nil
	 M.terraLookup[id]["state"] = "edge"
	else
	 id4 = id-M.h 			--just set center left
end


if id+M.h > M.h*M.w then  -- right edge
		id3 = nil
		id6 = nil
		id9 = nil
		M.terraLookup[id]["state"] = "edge"
	else
		id6 = id+M.h
	
end

return {id1,id2,id3,id4,id5,id6,id7,id8,id9}

end
M.gridLookup = gridLookup


-- Finally, return the table to be used locally elsewhere
return M
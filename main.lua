-- define vars local outside of function
local touches = {}
local multitouch
local scaleTo = 1
local touch

-- somehwere activate the multitouch on phone
system.activate( "multitouch" )

function scene:touch( event )

	-- define object Group to scale
	local sceneGroup = Group
	
	
	if event.phase == "began" then
		-- reset vars on began
		touch = event.id
		multitouch = false
	end
	
	if event.phase == "moved" and event.id ~= touch then
		-- there is a second id while moving, so its a multitouch
		multitouch = true
		
		-- saves touches from other id for later compare with the last one
		touches.x = event.x
		touches.y = event.y
		touches.xStart = event.xStart
		touches.yStart = event.yStart
		
	end
	
	if event.phase == "ended" and multitouch ~= true then
		
	-- put code for just one finger touch 
		
	elseif event.phase == "ended" and multitouch and event.id == touch then
		
		-- do the magic here at the end of the multitouch
		-- compare finger 1 with the saved finger
		
				local function distance(x1, y1, x2, y2)
					return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
				end
		
			-- does distance between fingers get bigger or smaller
			if distance(event.x, event.y, touches.x, touches.y) > distance(event.xStart, event.yStart, touches.xStart, touches.yStart) then
				scaleTo = 1.2
			else
				scaleTo = 0.8
			end
			
			-- just scale object group
			sceneGroup:scale(scaleTo, scaleTo)
	
	end 
	
			
	
end

-- create a rect around the screen
local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
background:addEventListener( "touch", scene )	

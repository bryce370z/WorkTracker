-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.
	
	-- create a white background to fill screen
	local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor( 1 )	-- white
	
	-- create some text
  
  -- Form submission button -- 
  local SubmitBtn = display.newText("Submit", display.contentCenterX, display.contentCenterY * 1.5, native.SystemFont, 32)
  SubmitBtn:setFillColor( 0 )
  
  local function onClick(event)
    if (event.phase == "began") then
      SubmitBtn.xScale = .85
      SubmitBtn.yScale = .85
      
    elseif(event.phase == "moved") then
      SubmitBtn.xScale = 1
      SubmitBtn.yScale = 1
      
    elseif (event.phase == "ended") then
      SubmitBtn.xScale = 1
      SubmitBtn.yScale = 1
      print("ended")
      local info = 
      {
        {
          date = tostring(DB_input[0]),
          description = tostring(DB_input[1]),
          amount = tostring(DB_input[2])
        }
      }
      
      for i = 1,#info do
      local q = [[INSERT INTO Job VALUES (NULL, ']] .. info[i].date .. [[',']] .. info[i].description .. [[', ']] ..   info[i].amount .. [[');]]
      db:exec( q )
      end
      
     -- local insertQuery = [[INSERT INTO Job VALUES (NULL, DB_input[0], DB_input[1], DB_input[2]);]]
     -- db:exec( insertQuery )
    end
end
  
  
  -- Button End -- 
  
  
  SubmitBtn:addEventListener("touch",onClick)
	
	-- all objects must be added to group (e.g. self.view)
	sceneGroup:insert(background)
  sceneGroup:insert(SubmitBtn)
  
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
  
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
    
	elseif phase == "did" then
		-- Called when the scene is now off screen
    Date.isVisible = false
    date_field.isVisible = false
    Description.isVisible = false
    description_field.isVisible = false
    Price.isVisible = false
    price_field.isVisible = false
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
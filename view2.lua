-----------------------------------------------------------------------------------------
--
-- view2.lua
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
	
  function givelist()
    local jobs = {}
    for row in db:nrows("SELECT * FROM Job") do
          jobs[#jobs+1] =
      {
          date = row.Date,
          FirstName = row.First_Name,
          LastName = row.Last_Name,
          description = row.Job_Description,
          amount = row.Sale_Amount
      }
      
    end
    
    for i=1,table.getn(jobs)
    do
      print("Date: " .. jobs[i].date, "First Name: " .. jobs[i].FirstName, "Last Name: " ..  jobs[i].LastName,"description: " .. jobs[i].description,"Amount: ".. jobs[i].amount)
    end
  end
	
	-- all objects must be added to group (e.g. self.view)
	sceneGroup:insert( background )

end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
    givelist()
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
    Date.isVisible = true
    date_field.isVisible = true
    Description.isVisible = true
    description_field.isVisible = true
    Price.isVisible = true
    price_field.isVisible = true
    First_Name.isVisible = true
    First_Name_field.isVisible = true
    Last_Name.isVisible = true
    Last_Name_field.isVisible = true
    
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

-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()




function scene:create( event )
	local sceneGroup = self.view
  
    Start_Date.isVisible = false
    Start_Date_field.isVisible = false
    End_Date.isVisible = false
    End_Date_field.isVisible = false

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.
	
	-- create a white background to fill screen
	local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor( 0 )	-- white
	
	-- create some text
  
  -- Form submission button -- 
  local SubmitBtn = display.newText("Submit", display.contentCenterX, display.contentCenterY * 1.7, native.SystemFont, 24)
  SubmitBtn:setFillColor( 1 )
  
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
      if(DB_input[0] ~= nil and DB_input[1] ~= nil and DB_input[2] ~= nil and DB_input[3] ~= nil and DB_input[4] ~= nil) then
        local info = 
        {
          {
            date = tostring(DB_input[0]),
            FirstName = tostring(DB_input[1]),
            LastName = tostring(DB_input[2]),
            amount = tostring(DB_input[3]),
            description = tostring(DB_input[4])
            
          }
        }
          for i = 1,#info do
           -- local q = [[INSERT INTO Job VALUES (NULL, ']] .. info[i].date .. [[',']] .. info[i].FirstName .. [[', ']] ..   info[i].LastName .. [[', ']] .. info[i].amount .. [[',']] .. info[i].description[[');]]
            local q = [[INSERT INTO Job VALUES (NULL, ']] .. info[i].date .. [[',']] .. info[i].FirstName .. [[', ']] ..   info[i]. LastName .. [[', ']] .. info[i].description .. [[', ']] .. info[i].amount .. [[');]]
            db:exec( q )
          end
          DB_input = {}
          date_field.text = ''
          description_field.text = ''
          price_field.text = ''
          First_Name_field.txt = ''
          Last_Name_field.txt = ''
      else
        print("invalid submission")
          
      end
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
     First_Name.isVisible = false
    First_Name_field.isVisible = false
    Last_Name.isVisible = false
    Last_Name_field.isVisible = false
    Start_Date.isVisible = true
    Start_Date_field.isVisible = true
    End_Date.isVisible = true
    End_Date_field.isVisible = true
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
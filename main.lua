-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- show default status bar (iOS)
display.setStatusBar( display.DefaultStatusBar )

-- Initialize database ---
require "sqlite3"

path = system.pathForFile( "data.db", system.DocumentsDirectory )
db = sqlite3.open( path )

tablesetup = [[CREATE TABLE IF NOT EXISTS Job (id INTEGER PRIMARY KEY autoincrement, Date, First_Name, Last_Name, Job_Description, Sale_Amount);]]
db:exec( tablesetup )

--drop_table = [[DROP TABLE Job;]]
--db:exec(drop_table)

--- local insertQuery = [[INSERT INTO Job VALUES (NULL, 'blah', 'blah blah', 'blahhh');]]
---   db:exec( insertQuery )
-- database end ---



-- include Corona's "widget" library
local widget = require "widget"
local composer = require "composer"



-- event listeners for tab buttons:
local function onFirstView( event )
  composer.gotoScene( "view1" )
end

local function onSecondView( event )
  composer.gotoScene( "view2" )
end


DB_input = {}
-- Inputting the Date --
Date = display.newText( "Date: ", display.contentCenterX * .16, (display.contentCenterY * .1), native.systemFont, 16 )
Date:setFillColor( 0 )	-- black

date_field = native.newTextField(display.contentCenterX * 1.45, display.contentCenterY * .1, (display.viewableContentWidth * .5), (display.viewableContentHeight * .05))
date_field.size = 12
date_field:resizeFontToFitHeight()

-- Date input is finished --

-- Inputting client First Name --
First_Name = display.newText( "First Name: ", display.contentCenterX * .3, (display.contentCenterY * .3), native.systemFont, 16 )
First_Name :setFillColor( 0 )	-- black

First_Name_field = native.newTextField(display.contentCenterX * 1.45, display.contentCenterY * .3, (display.viewableContentWidth * .5), (display.viewableContentHeight * .05))
First_Name_field.size = 12
First_Name_field:resizeFontToFitHeight()

-- First name input end --

-- Inputting Client Last Name --
Last_Name = display.newText( "Last Name: ", display.contentCenterX * .3, (display.contentCenterY * .5), native.systemFont, 16 )
Last_Name :setFillColor( 0 )	-- black

Last_Name_field = native.newTextField(display.contentCenterX * 1.45, display.contentCenterY * .5, (display.viewableContentWidth * .5), (display.viewableContentHeight * .05))
Last_Name_field.size = 12
Last_Name_field:resizeFontToFitHeight()
-- Last Name input finished --



-- Input Amount of Sale --

Price = display.newText( "Sale Amount: ", display.contentCenterX * .335, (display.contentCenterY * .7), native.systemFont, 16 )
Price:setFillColor( 0 )

price_field = native.newTextField(display.contentCenterX * 1.45, display.contentCenterY * .7, (display.viewableContentWidth * .5), (display.viewableContentHeight * .05))
price_field.size = 12
price_field:resizeFontToFitHeight()


-- Amount of Sale End --

-- Input Job Description -- 
Description = display.newText( "Job Description ", display.contentCenterX, (display.contentCenterY * .9), native.systemFont, 16 )
Description:setFillColor( 0 )

description_field = native.newTextField(display.contentCenterX, display.contentCenterY * 1.3, (display.viewableContentWidth * .9), (display.viewableContentHeight * .3))
description_field.size = 16
-- description_field:resizeFontToFitHeight()

-- Job Description End --

-- input start date range --
Start_Date = display.newText("Start Date: ",display.contentCenterX * .265, (display.contentCenterY * .1), native.systemFont, 16)
Start_Date:setFillColor(0)

Start_Date_field = native.newTextField(display.contentCenterX * 1.1, (display.contentCenterY * .1),(display.viewableContentWidth * .5), (display.viewableContentHeight * .05))
Start_Date_field.size = 12
Start_Date_field:resizeFontToFitHeight()
-- input start date range --

-- input end date --
End_Date = display.newText("End Date: ",display.contentCenterX * .25, (display.contentCenterY * .3), native.systemFont, 16)
End_Date:setFillColor(0)

End_Date_field = native.newTextField(display.contentCenterX * 1.1, (display.contentCenterY * .3),(display.viewableContentWidth * .5), (display.viewableContentHeight * .05))
End_Date_field.size = 12
End_Date_field:resizeFontToFitHeight()
-- input end date --


-- function to format date to cooperate with sqlite3 yyyy/mm/dd -- 
local function date_check(string)
  -- print("string",string)
  local regex = "[0-9][0-9][0-9][0-9][-][0-9][0-9][-][0-9][0-9]"
  local checker = string.match(string,regex)
  if(checker == nil) then
    print("date rejected")
    return false
  end    
  print("date accepted")
  return true
end

-- end of function -- 

-- function to check if amount of sale is in correct format--
local function price_check(string)
  -- ^ "expression" $ means to match the whole string not just part of it
  local regex = "^[0-9]+$"
  local checker = string.match(string,regex)
  if(checker == nil) then
    print("price rejected")
    return false
  end
  print("price accepted")
  return true
end

-- end of function --

--function to make sure first and last names are in the correct format
local function name_check(string)
  local regex = "^[a-zA-Z]+$"
  local checker = string.match(string,regex)
  if(checker == nil) then
    print("name rejected")
    return false
  end
  print("name accepted")
  return true
  
end


-- function end --


--Event Handlers--  
local function date_fieldHandler(event)
  if event.phase == "began" then
  elseif event.phase == "ended" then
    if(date_check(event.target.text)) then
      DB_input[0] = event.target.text
      print(DB_input[0])
    end
  elseif event.phase == "submitted" then
    print("submitted")
  elseif event.phase == "editing" then
    print("editing")
  end
end

local function First_Name_fieldHandler(event)
  if event.phase == "began" then
elseif event.phase == "ended" then
    if(name_check(event.target.text)) then
      DB_input[1] = event.target.text
      print(DB_input[1])
    end
  elseif event.phase == "submitted" then
    print("submitted")
  elseif event.phase == "editing" then
    print("editing")
  end
end

local function Last_Name_fieldHandler(event)
  if event.phase == "began" then
  elseif event.phase == "ended" then
    if(name_check(event.target.text)) then
      DB_input[2] = event.target.text
      print(DB_input[2])
    end
  elseif event.phase == "submitted" then
    print("submitted")
  elseif event.phase == "editing" then
    print("editing")
  end
end


local function price_fieldHandler(event)
  if event.phase == "began" then
  elseif event.phase == "ended" then
    if(price_check(event.target.text)) then
      DB_input[3] = event.target.text
      print(DB_input[3])
    end
  elseif event.phase == "submitted" then
    print("submitted")
  elseif event.phase == "editing" then
    print("editing")
  end
end

local function description_fieldHandler(event)
  if event.phase == "began" then
  elseif event.phase == "ended" then
    DB_input[4] = event.target.text
    print(DB_input[4])
  elseif event.phase == "submitted" then
    print("submitted")
  elseif event.phase == "editing" then
    print("editing")
  end
end

local function Start_Date_fieldHandler(event)
    if event.phase == "began" then
  elseif event.phase == "ended" then
  elseif event.phase == "submitted" then
    print("submitted")
  elseif event.phase == "editing" then
    print("editing")
  end
end

local function End_Date_fieldHandler(event)
    if event.phase == "began" then
  elseif event.phase == "ended" then
    if(date_check(event.target.text) and date_check(Start_Date_field.text)) then
      givelist(Start_Date_field.text,End_Date_field.text)
      print("date range is good")
    end
  elseif event.phase == "submitted" then
    print("submitted")
  elseif event.phase == "editing" then
    print("editing")
  end
end



-- view 1 listeners -- 
date_field:addEventListener("userInput",date_fieldHandler)
First_Name_field:addEventListener("userInput",First_Name_fieldHandler)
Last_Name_field:addEventListener("userInput",Last_Name_fieldHandler)
price_field:addEventListener("userInput",price_fieldHandler)
description_field:addEventListener("userInput",description_fieldHandler)

--view 1 listeners --

-- view 2 listeners --
Start_Date_field:addEventListener("userInput",Start_Date_fieldHandler)
End_Date_field:addEventListener("userInput",End_Date_fieldHandler)

-- view 2 listeners -- 

--Event Handlers End--


   -- scroll view to display DB data in view 2 --
  local function scrollListener(event)
    local phase = event.phase
    local direction = event.direction
    
    if event.limitReached then
      if "up" == direction then
        print("limit reached top")
      elseif "down" == direction then
        print("limit reached down")
      end
    end
    
    return true
    
  end
  -- scroll view to display DB data --
    scrollview = widget.newScrollView
  {
    left = 0,
    top = display.viewableContentHeight * .3,
    width = display.contentWidth,
    height = display.viewableContentHeight * .7,
    scrollHeight = display.viewableContentHeight * 3,
    horizontalScrollDisabled = true,
    verticalScrollDisabled = false,
    isBounceEnabled = true,
    Listener = scrollListener,
  }
  -- scroll view --
  

-- function to pull data from DB --
function givelist(start,stop)
  print(start)
  print(stop)
  --db:exec(query)
    local jobs = {}
    for row in db:nrows("SELECT * FROM Job WHERE Date BETWEEN ".."'"..start.."'".." AND ".."'"..stop.."'") do
          jobs[#jobs+1] =
      {
          date = row.Date,
          FirstName = row.First_Name,
          LastName = row.Last_Name,
          description = row.Job_Description,
          amount = row.Sale_Amount
      }
      
    end
    
    
    local text = ""
    for i=1,table.getn(jobs) do
      text = text .. " Date: " .. jobs[i].date .. "\nFirst Name: " .. jobs[i].FirstName .. "\nLast Name: " ..  jobs[i].LastName .."\ndescription: " .. jobs[i].description .. "\nAmount: ".. jobs[i].amount .. "\n\n"
    end
    print(text)
    if(text ~= nil) then
      textObj = display.newText(text, 0, 0, 300, 0, native.systemFont, 12)
      textObj:setTextColor(0)
      textObj.x = display.contentCenterX
      textObj.y = display.viewableContentHeight * .5
      scrollview:insert(textObj)
    end
  end

  
  -- Pulls Data --
  

-- create a tabBar widget with two buttons at the bottom of the screen

-- table to setup buttons
local tabButtons = {
  { label="First", defaultFile="icon1.png", overFile="icon1-down.png", width = 32, height = 32, onPress=onFirstView, selected=true },
  { label="Second", defaultFile="icon2.png", overFile="icon2-down.png", width = 32, height = 32, onPress=onSecondView },
}



-- create the actual tabBar widget
local tabBar = widget.newTabBar{
  top = display.contentHeight - 50,	-- 50 is default height for tabBar widget
  buttons = tabButtons
}




onFirstView()	-- invoke first tab button's onPress event manually
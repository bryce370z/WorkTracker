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
Date = display.newText( "Enter Job Completion Date: ", display.contentCenterX, (display.contentCenterY * .1), native.systemFont, 16 )
Date:setFillColor( 1 )	-- black

date_field = native.newTextField(display.contentCenterX, display.contentCenterY * .2, (display.viewableContentWidth * .5), (display.viewableContentHeight * .05))
date_field.size = 12
date_field:resizeFontToFitHeight()

-- Date input is finished --

-- Inputting client First Name --
First_Name = display.newText( "Enter Client First Name: ", display.contentCenterX, (display.contentCenterY * .3), native.systemFont, 16 )
First_Name :setFillColor( 1 )	-- black

First_Name_field = native.newTextField(display.contentCenterX, display.contentCenterY * .4, (display.viewableContentWidth * .5), (display.viewableContentHeight * .05))
First_Name_field.size = 12
First_Name_field:resizeFontToFitHeight()

-- First name input end --

-- Inputting Client Last Name --
Last_Name = display.newText( "Enter Client Last Name: ", display.contentCenterX, (display.contentCenterY * .5), native.systemFont, 16 )
Last_Name :setFillColor( 1 )	-- black

Last_Name_field = native.newTextField(display.contentCenterX, display.contentCenterY * .6, (display.viewableContentWidth * .5), (display.viewableContentHeight * .05))
Last_Name_field.size = 12
Last_Name_field:resizeFontToFitHeight()
-- Last Name input finished --



-- Input Amount of Sale --

Price = display.newText( "Enter Amount of Sale: ", display.contentCenterX, (display.contentCenterY * .7), native.systemFont, 16 )
Price:setFillColor( 1 )

price_field = native.newTextField(display.contentCenterX, display.contentCenterY * .8, (display.viewableContentWidth * .5), (display.viewableContentHeight * .05))
price_field.size = 12
price_field:resizeFontToFitHeight()


-- Amount of Sale End --

-- Input Job Description -- 
Description = display.newText( "Enter Job Description: ", display.contentCenterX, (display.contentCenterY * .9), native.systemFont, 16 )
Description:setFillColor( 1 )

description_field = native.newTextField(display.contentCenterX, display.contentCenterY * 1.3, (display.viewableContentWidth * .9), (display.viewableContentHeight * .3))
description_field.size = 16
-- description_field:resizeFontToFitHeight()

-- Job Description End --

-- input start date range --
Start_Date = display.newText("Enter Start Date: ",display.contentCenterX, (display.contentCenterY * .1), native.systemFont, 16)
Start_Date:setFillColor(0)

Start_Date_field = native.newTextField(display.contentCenterX, (display.contentCenterY * .2),(display.viewableContentWidth * .5), (display.viewableContentHeight * .05))
Start_Date_field.size = 12
Start_Date_field:resizeFontToFitHeight()
-- input start date range --

-- input end date --
End_Date = display.newText("Enter End Date: ",display.contentCenterX, (display.contentCenterY * .3), native.systemFont, 16)
End_Date:setFillColor(0)

End_Date_field = native.newTextField(display.contentCenterX, (display.contentCenterY * .4),(display.viewableContentWidth * .5), (display.viewableContentHeight * .05))
End_Date_field.size = 12
End_Date_field:resizeFontToFitHeight()
-- input end date --


-- function to format date to cooperate with sqlite3 yyyy/mm/dd -- 
function date_check(string)
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
function price_check(string)
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
function name_check(string)
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
    
    for i=1,table.getn(jobs)
    do
      print("Date: " .. jobs[i].date, "First Name: " .. jobs[i].FirstName, "Last Name: " ..  jobs[i].LastName,"description: " .. jobs[i].description,"Amount: ".. jobs[i].amount)
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
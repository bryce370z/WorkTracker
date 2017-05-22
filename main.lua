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

tablesetup = [[CREATE TABLE IF NOT EXISTS Job (id INTEGER PRIMARY KEY autoincrement, Date, Job_Description, Sale_Amount);]]
db:exec( tablesetup )

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
	Date = display.newText( "Enter Job Date: ", display.contentCenterX, (display.contentCenterY * .1), native.systemFont, 16 )
	Date:setFillColor( 0 )	-- black

date_field = native.newTextField(display.contentCenterX, display.contentCenterY * .2, (display.viewableContentWidth * .5), (display.viewableContentHeight * .05))
  date_field.size = 12
  date_field:resizeFontToFitHeight()
  
  -- Date input is finished --
  
  
  -- Input Job Description -- 
Description = display.newText( "Enter Job Description: ", display.contentCenterX, (display.contentCenterY * .3), native.systemFont, 16 )
	Description:setFillColor( 0 )
  
description_field = native.newTextField(display.contentCenterX, display.contentCenterY * .4, (display.viewableContentWidth * .5), (display.viewableContentHeight * .05))
  description_field.size = 12
  description_field:resizeFontToFitHeight()
  
	-- Job Description End --
  
  -- Input Amount of Sale --
  
  Price = display.newText( "Enter Amount of Sale: ", display.contentCenterX, (display.contentCenterY * .5), native.systemFont, 16 )
	Price:setFillColor( 0 )
  
 price_field = native.newTextField(display.contentCenterX, display.contentCenterY * .6, (display.viewableContentWidth * .5), (display.viewableContentHeight * .05))
  price_field.size = 12
  price_field:resizeFontToFitHeight()
  
  
  -- Amount of Sale End --
  
  
  --Event Handlers--  
    local function date_fieldHandler(event)
    if event.phase == "began" then
      event.target.text = ''
      
    elseif event.phase == "ended" then
      event.target.text = ''
    elseif event.phase == "submitted" then
      DB_input[0] = event.target.text
      print(DB_input[0])
      print("submitted")
    elseif event.phase == "editing" then
      print("editing")
    end
  end
  
    local function description_fieldHandler(event)
    if event.phase == "began" then
      event.target.text = ''
      
    elseif event.phase == "ended" then
      event.target.text = ''
    elseif event.phase == "submitted" then
      DB_input[1] = event.target.text
       print(DB_input[1])
      print("submitted")
    elseif event.phase == "editing" then
      print("editing")
    end
  end
  
    local function price_fieldHandler(event)
    if event.phase == "began" then
      event.target.text = ''
    elseif event.phase == "ended" then
      event.target.text = ''
    elseif event.phase == "submitted" then
      DB_input[2] = event.target.text
      print(DB_input[2])
      print("submitted")
    elseif event.phase == "editing" then
      print("editing")
    end
  end
  
  date_field:addEventListener("userInput",date_fieldHandler)
  description_field:addEventListener("userInput",description_fieldHandler)
  price_field:addEventListener("userInput",price_fieldHandler)
  --Event Handlers End--
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
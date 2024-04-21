
--[[
    :DISCLAIMER: This code should not go in this file, since for this example im extending the onModalDialog functionality.
                Probably the best way would be to create a custom event only for the jump window  but because of time
                constraints I have decided to do it here.

    Basically what I have implemented is a simple loop in which the update function is scheduled to be called every x miliseconds
     
    whenever the button reaches the limit or is pressed, its position is reset to the starting x and a random y in the range of the height
]]


modalDialog = nil
button = nil

function onJumpWindow()
    --Establish the size of the parent window
  WindowSize = {500  ,500 }
  
    --Create the actual window
  button = g_ui.createWidget('ModalButton', modalDialog)

    --set the function for the button when its clicked to the function that resets its position
  button.onClick = function(self)
    ResetButtonPos()
  end
  button:setText("Jump!")

  
  -- Resize the window to the established size
  modalDialog:resize(WindowSize[1] ,WindowSize[2])
  --set the position to the starting position
  pos = {WindowSize[1]-50,WindowSize[2]-50}

  --Actually move the button
  moveButton(pos[1],pos[2])
  --Start the loop
  UpdateJumpGame()
end

--This function is a wrapper to move the button for it to move in relation to its parent instead of in screen coordinates
function moveButton(x,y)
  local X = modalDialog:getX() + x
  local Y = modalDialog:getY() + y
  --actually move the button
  button:move(X,Y)
end

--actual game loop
function UpdateJumpGame()

--variables for the game
  local speed = 3
  local refreshMs = 10
  local limitX = 50
  
  --decrease the position by speed
  pos[1] = pos[1] - speed
  --call the function to move the button
  
  --check for case in which the button has reached the end unclicked    
  if (pos[1] < limitX) then
    ResetButtonPos()
    end

  --move the button 
  moveButton(pos[1],pos[2])

  --for the game to keep looping, schedule this function to be called in refresMS miliseconds
  scheduleEvent(UpdateJumpGame,refreshMs)
  
end

--Reset the button position to the right and at a random height
function ResetButtonPos()
    --right
  pos[1] = WindowSize[1]-50
  --random height
  pos[2] = math.random(50,WindowSize[2]-50)
end







function onModalDialog(id, title, message, buttons, enterButton, escapeButton, choices, priority)

  if modalDialog then
    return
  end

  modalDialog = g_ui.createWidget('ModalDialog', rootWidget)

  if (title == "JUMP!") then
    onJumpWindow()
    return
  end
  
  --THIS SHOULD NOT BE COMMENTED, ONLY COMMENTED WITH THE PURPOSE TO HIGHLIGHT WHAT MY CODE DOES AND SEPARATE IT FROM PROVIDED ONE-- 

--   local messageLabel = modalDialog:getChildById('messageLabel')
--   local choiceList = modalDialog:getChildById('choiceList')
--   local choiceScrollbar = modalDialog:getChildById('choiceScrollBar')
--   local buttonsPanel = modalDialog:getChildById('buttonsPanel')

--   modalDialog:setText(title)
  

--   local labelHeight
--   for i = 1, #choices do
--     local choiceId = choices[i][1]
--     local choiceName = choices[i][2]

--     local label = g_ui.createWidget('ChoiceListLabel', choiceList)
--     label.choiceId = choiceId
--     label:setText(choiceName)
--     label:setPhantom(false)
--     if not labelHeight then
--       labelHeight = label:getHeight()
--     end
--   end
--   choiceList:focusChild(choiceList:getFirstChild())

--   g_keyboard.bindKeyPress('Down', function() choiceList:focusNextChild(KeyboardFocusReason) end, modalDialog)
--   g_keyboard.bindKeyPress('Up', function() choiceList:focusPreviousChild(KeyboardFocusReason) end, modalDialog)

--   local buttonsWidth = 0
--   for i = 1, #buttons do
--     local buttonId = buttons[i][1]
--     local buttonText = buttons[i][2]

--     local button = g_ui.createWidget('ModalButton', buttonsPanel)
--     button:setText(buttonText)
--     button.onClick = function(self)
--                        local focusedChoice = choiceList:getFocusedChild()
--                        local choice = 0xFF
--                        if focusedChoice then
--                          choice = focusedChoice.choiceId
--                        end
--                        g_game.answerModalDialog(id, buttonId, choice)
--                        destroyDialog()
--                      end
--     buttonsWidth = buttonsWidth + button:getWidth() + button:getMarginLeft() + button:getMarginRight()
--   end

--   local additionalHeight = 0
--   if #choices > 0 then
--     choiceList:setVisible(true)
--     choiceScrollbar:setVisible(true)
    
--     additionalHeight = math.min(modalDialog.maximumChoices, math.max(modalDialog.minimumChoices, #choices)) * labelHeight
--     additionalHeight = additionalHeight + choiceList:getPaddingTop() + choiceList:getPaddingBottom()
--   end

--   local horizontalPadding = modalDialog:getPaddingLeft() + modalDialog:getPaddingRight()
--   buttonsWidth = buttonsWidth + horizontalPadding

--   modalDialog:setWidth(math.min(modalDialog.maximumWidth, math.max(buttonsWidth, messageLabel:getWidth(), modalDialog.minimumWidth)))
--   messageLabel:setWidth(math.min(modalDialog.maximumWidth, math.max(buttonsWidth, messageLabel:getWidth(), modalDialog.minimumWidth)) - horizontalPadding)
--   modalDialog:setHeight(modalDialog:getHeight() + additionalHeight + messageLabel:getHeight() - 8)

--   local enterFunc = function()
--     local focusedChoice = choiceList:getFocusedChild()
--     local choice = 0xFF
--     if focusedChoice then
--       choice = focusedChoice.choiceId
--     end
--     g_game.answerModalDialog(id, enterButton, choice)
--     destroyDialog()
--   end

--   local escapeFunc = function()
--     local focusedChoice = choiceList:getFocusedChild()
--     local choice = 0xFF
--     if focusedChoice then
--       choice = focusedChoice.choiceId
--     end
--     g_game.answerModalDialog(id, escapeButton, choice)
--     destroyDialog()
--   end

--   choiceList.onDoubleClick = enterFunc

--   modalDialog.onEnter = enterFunc
--   modalDialog.onEscape = escapeFunc
end

-- RealClock
--
-- @author  Grisu118 - VertexDezign.net
-- @history     v1.0    - 2016-10-25 - Initial implementation
--              v1.1    - 2017-09-11 - Add use of UI Scale
-- @Descripion: Shows the real time clock in the upper right corner
-- @web: http://grisu118.ch or http://vertexdezign.net
-- Copyright (C) Grisu118, All Rights Reserved.

RealClock = {}
RealClock.fontSize = 0.02

function RealClock:loadMap(name)
end
function RealClock:deleteMap()
end
function RealClock:mouseEvent(posX, posY, isDown, isUp, button)
end
function RealClock:keyEvent(unicode, sym, modifier, isDown)
end
function RealClock:update(dt)	
end

function RealClock:draw()
    setTextColor(1,1,1,1)
    local fontSize = g_gameSettings:getValue("uiScale") * RealClock.fontSize
    local date = getDate("%H:%M:%S")
    local width = getTextWidth(fontSize, date)
    local height = getTextHeight(fontSize, date)
    renderText(0.99 - width, 1 - height, fontSize, date)
    setTextColor(1,1,1,0)
end

addModEventListener(RealClock)
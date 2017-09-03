-- RealClock
--
-- @author  Grisu118 - VertexDezign.net
-- @history		v1.0 	- 2016-10-25 - Initial implementation
-- @Descripion: Shows the real time clock in the upper right corner
-- @web: http://grisu118.ch or http://vertexdezign.net
-- Copyright (C) Grisu118, All Rights Reserved.

RealClock = {}

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
    renderText(0.94, 0.98, 0.02, getDate("%H:%M:%S"))
    setTextColor(1,1,1,0)
end

addModEventListener(RealClock)
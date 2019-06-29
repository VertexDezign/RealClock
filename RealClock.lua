-- RealClock
--
-- @author        Grisu118 - VertexDezign.net
-- @contributors  Slivicon
-- @history       v1.0    - 2016-10-25 - Initial implementation
--                v1.1    - 2017-09-11 - Add use of UI Scale
--                v2.0    - 2017-09-23 - Add config xml
--                v2.0.1  - 2018-01-13 - Do not render clock when renderTime is false
--                v2.1    - 2019-01-14 - Move settings file to modSettings folder, do not draw when showTime is false
--                v2.1.1  - 2019-04-01 - Create modSettings folder
-- @descripion:   Shows the real time clock in the upper right corner
-- @web:          http://grisu118.ch or http://vertexdezign.net
-- Copyright (C) Grisu118, All Rights Reserved.

RealClock = {}
RealClock.configFileName = "realClock.xml"
RealClock.d = {}
RealClock.d.timeFormat = "%H:%M:%S"
RealClock.d.position = {}
RealClock.d.position.dynamic = true
RealClock.d.position.x = 0.9
RealClock.d.position.y = 0.98
RealClock.d.rendering = {}
RealClock.d.rendering.color = "white"
RealClock.d.rendering.fontSize = 0.015

local function protect(tbl)
  return setmetatable(
    {},
    {
      __index = tbl,
      __newindex = function(t, key, value)
        error("attempting to change constant " .. tostring(key) .. " to " .. tostring(value), 2)
      end
    }
  )
end

-- Protect the defaults, nobody should overwrite them!
RealClock.d = protect(RealClock.d)

function RealClock:loadMap(name)
  self.debugger = GrisuDebug:create("RealClock")
  self.debugger:setLogLvl(GrisuDebug.INFO)

  self.debugger:info("RealClock loading")

  self.position = {}
  self.position.dynamic = RealClock.d.position.dynamic
  self.position.x = RealClock.d.position.x
  self.position.y = RealClock.d.position.y
  self.rendering = {}
  self.rendering.color = RealClock.d.rendering.color
  self.rendering.fontSize = RealClock.d.rendering.fontSize
  self.timeFormat = RealClock.d.timeFormat

  if g_dedicatedServerInfo == nil then
    local xmlFile = g_modsDirectory .. "/" .. RealClock.configFileName
    if not fileExists(xmlFile) then
      local modSettingsDir = getUserProfileAppPath() .. "modsSettings"
      local newXmlFile = modSettingsDir .. "/" .. RealClock.configFileName
      if not fileExists(newXmlFile) then
        createFolder(modSettingsDir)

        -- Special handling for wrongly named file
        local wrongNamedFile = modSettingsDir .. RealClock.configFileName
        if (fileExists(wrongNamedFile)) then
          self:setValuesFromXML(wrongNamedFile)
          self:writeCurrentConfig(newXmlFile)
          self.debugger:warn("Config file created at correct place, you can safely delete the old file: " .. wrongNamedFile)
        else
          self:writeDefaultConfig(newXmlFile)
        end
      end
      self:setValuesFromXML(newXmlFile)
    else
      self.debugger:warn(
        "Loading configuration from mod folder, this is deprecated and will be removed in a furhter version. Move your " ..
          RealClock.configFileName .. " in the modSettings folder."
      )
      self:setValuesFromXML(xmlFile)
    end
  end
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
  if g_dedicatedServerInfo ~= nil or not g_currentMission.renderTime or not g_currentMission.hud.showTime then
    return
  end

  local r, g, b, a = self:getColor(self.rendering.color)
  setTextColor(r, g, b, a)
  local fontSize = g_gameSettings:getValue("uiScale") * self.rendering.fontSize
  local date = getDate(self.timeFormat)
  local posX = self.position.x
  local posY = self.position.y
  if self.position.dynamic then
    local width = getTextWidth(fontSize, date)
    local height = getTextHeight(fontSize, date)
    posX = 0.99 - width
    posY = 1 - height
  end
  renderText(posX, posY, fontSize, date)
  setTextColor(1, 1, 1, 1)
end

function RealClock:getColor(source)
  local color = source:lower()
  if color == "white" then
    return 1, 1, 1, 1
  elseif color == "black" then
    return 0, 0, 0, 1
  else
    local splitted = StringUtil.splitString(",", color)
    local colors = {}
    for _, v in pairs(splitted) do
      table.insert(colors, tonumber(v))
    end
    return unpack(colors)
  end
end

function RealClock:writeDefaultConfig(fileName)
  self.debugger:info(
    function()
      return "Write default Config to " .. fileName
    end
  )
  local xml = createXMLFile("RealClock", fileName, "RealClock")
  setXMLBool(xml, "RealClock.position#isDynamic", RealClock.d.position.dynamic)
  setXMLFloat(xml, "RealClock.position#x", RealClock.d.position.x)
  setXMLFloat(xml, "RealClock.position#y", RealClock.d.position.y)
  setXMLString(xml, "RealClock.rendering#color", RealClock.d.rendering.color)
  setXMLFloat(xml, "RealClock.rendering#fontSize", RealClock.d.rendering.fontSize)
  setXMLString(xml, "RealClock.format#string", RealClock.d.timeFormat)
  saveXMLFile(xml)
  delete(xml)
end

function RealClock:writeCurrentConfig(fileName)
  self.debugger:info(
    function()
      return "Write current Config to " .. fileName
    end
  )
  local xml = createXMLFile("RealClock", fileName, "RealClock")
  setXMLBool(xml, "RealClock.position#isDynamic", self.position.dynamic)
  setXMLFloat(xml, "RealClock.position#x", self.position.x)
  setXMLFloat(xml, "RealClock.position#y", self.position.y)
  setXMLString(xml, "RealClock.rendering#color", self.rendering.color)
  setXMLFloat(xml, "RealClock.rendering#fontSize", self.rendering.fontSize)
  setXMLString(xml, "RealClock.format#string", self.timeFormat)
  saveXMLFile(xml)
  delete(xml)
end

function RealClock:setValuesFromXML(fileName)
  self.debugger:info(
    function()
      return "Read from xml " .. fileName
    end
  )
  local xml = loadXMLFile("RealClock", fileName)
  self.position.dynamic = Utils.getNoNil(getXMLBool(xml, "RealClock.position#isDynamic"), RealClock.d.position.dynamic)
  self.debugger:debug(
    function()
      return "Position.dynamic: " .. tostring(self.position.dynamic)
    end
  )
  local x = Utils.getNoNil(getXMLFloat(xml, "RealClock.position#x"), RealClock.d.position.x)
  self.debugger:debug(
    function()
      return "Position.x: " .. tostring(x)
    end
  )
  if (self:validateFloat(x, "x")) then
    self.position.x = x
  end
  local y = Utils.getNoNil(getXMLFloat(xml, "RealClock.position#y"), RealClock.d.position.y)
  self.debugger:debug(
    function()
      return "Position.y: " .. tostring(y)
    end
  )
  if (self:validateFloat(y, "y")) then
    self.position.y = y
  end
  local color = Utils.getNoNil(getXMLString(xml, "RealClock.rendering#color"), RealClock.d.rendering.color)
  -- validate color
  if color:lower() ~= "white" and color:lower() ~= "black" then
    local c = StringUtil.splitString(",", color)
    if table.getn(c) == 4 then
      local valid = true
      for _, v in pairs(c) do
        if not self:validateFloat(v, "color") then
          valid = false
          break
        end
      end
      if valid then
        self.rendering.color = color
      else
        self.rendering.color = RealClock.d.rendering.color
      end
    else
      self.debugger:warn(
        function()
          return "Invalid value for color, only 'white', 'black' or a custom color like '0,0.5,1,0.8' allowed, found " ..
            color
        end
      )
      self.rendering.color = RealClock.d.rendering.color
    end
  else
    self.rendering.color = color
  end

  local fontSize = Utils.getNoNil(getXMLFloat(xml, "RealClock.rendering#fontSize"), RealClock.d.rendering.fontSize)
  if self:validateFloat(fontSize, "fontSize") then
    self.rendering.fontSize = fontSize
  end
  self.timeFormat = Utils.getNoNil(getXMLString(xml, "RealClock.format#string"), RealClock.d.timeFormat)
  delete(xml)
end

function RealClock:validateFloat(float, text)
  local f = tonumber(float)
  if f ~= nil and f >= 0 and f <= 1 then
    return true
  else
    self.debugger:warn(
      function()
        return "Invalid value for " .. text .. ", must be a value between 0 and 1 including both, was " .. float
      end
    )
    return false
  end
end

addModEventListener(RealClock)

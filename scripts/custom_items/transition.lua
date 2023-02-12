Transition = class(CustomItemProgressiveToggle2)

ENABLE_DEBUG_LOG_TRANSITION = false and ENABLE_DEBUG_LOG

--[[
    represents a area transition in SM
]]

Transition.STATES = {
    [0] = "hidden",
    [1] = "Aqueduct Top Left",
    [2] = "Caterpillar Room Top Right",
    [3] = "Crab Hole Bottom Left",
    [4] = "Crab Maze Left",
    [5] = "Crab Shaft Right",
    [6] = "Crocomire Room Top",
    [7] = "Crocomire Speedway Bottom",
    [8] = "DraygonRoomIn",
    [9] = "DraygonRoomOut",
    [10] = "East Tunnel Right",
    [11] = "East Tunnel Top Right",
    [12] = "Glass Tunnel Top",
    [13] = "Golden Four",
    [14] = "Green Brinstar Elevator",
    [15] = "Green Hill Zone Top Right",
    [16] = "Green Pirates Shaft Bottom Right",
    [17] = "Keyhunter Room Bottom",
    [18] = "KraidRoomIn",
    [19] = "KraidRoomOut",
    [20] = "Kronic Boost Room Bottom Left",
    [21] = "Lava Dive Right",
    [22] = "Le Coude Right",
    [23] = "Lower Mushrooms Left",
    [24] = "Main Street Bottom",
    [25] = "Moat Right",
    [26] = "Morph Ball Room Left",
    [27] = "Noob Bridge Right",
    [28] = "PhantoonRoomIn",
    [29] = "PhantoonRoomOut",
    [30] = "Red Brinstar Elevator",
    [31] = "Red Fish Room Left",
    [32] = "Red Tower Top Left",
    [33] = "RidleyRoomIn",
    [34] = "RidleyRoomOut",
    [35] = "Single Chamber Top Right",
    [36] = "Three Muskateers Room Left",
    [37] = "Warehouse Entrance Left",
    [38] = "Warehouse Entrance Right",
    [39] = "Warehouse Zeela Room Left",
    [40] = "West Ocean Left",
    ["hidden"] = 0,
    ["Aqueduct Top Left"] = 1,
    ["Caterpillar Room Top Right"] = 2,
    ["Crab Hole Bottom Left"] = 3,
    ["Crab Maze Left"] = 4,
    ["Crab Shaft Right"] = 5,
    ["Crocomire Room Top"] = 6,
    ["Crocomire Speedway Bottom"] = 7,
    ["DraygonRoomIn"] = 8,
    ["DraygonRoomOut"] = 9,
    ["East Tunnel Right"] = 10,
    ["East Tunnel Top Right"] = 11,
    ["Glass Tunnel Top"] = 12,
    ["Golden Four"] = 13,
    ["Green Brinstar Elevator"] = 14,
    ["Green Hill Zone Top Right"] = 15,
    ["Green Pirates Shaft Bottom Right"] = 16,
    ["Keyhunter Room Bottom"] = 17,
    ["KraidRoomIn"] = 18,
    ["KraidRoomOut"] = 19,
    ["Kronic Boost Room Bottom Left"] = 20,
    ["Lava Dive Right"] = 21,
    ["Le Coude Right"] = 22,
    ["Lower Mushrooms Left"] = 23,
    ["Main Street Bottom"] = 24,
    ["Moat Right"] = 25,
    ["Morph Ball Room Left"] = 26,
    ["Noob Bridge Right"] = 27,
    ["PhantoonRoomIn"] = 28,
    ["PhantoonRoomOut"] = 29,
    ["Red Brinstar Elevator"] = 30,
    ["Red Fish Room Left"] = 31,
    ["Red Tower Top Left"] = 32,
    ["RidleyRoomIn"] = 33,
    ["RidleyRoomOut"] = 34,
    ["Single Chamber Top Right"] = 35,
    ["Three Muskateers Room Left"] = 36,
    ["Warehouse Entrance Left"] = 37,
    ["Warehouse Entrance Right"] = 38,
    ["Warehouse Zeela Room Left"] = 39,
    ["West Ocean Left"] = 40
}

function Transition:init(name, codes, defaultState, enableStateChanging)
    if ENABLE_DEBUG_LOG_TRANSITION then
        print(string.format("Transition:init: name: %s, codes: %s, defaultState: %s, enableStateChanging: %s", name,
            codes, defaultState, enableStateChanging))
    end
    self:createItem(name)

    self.name = name
    self.codes = {}

    for code in string.gmatch(codes, "[^,]+") do
        local clean = string.gsub(code, "[%s]+", "")
        if ENABLE_DEBUG_LOG_TRANSITION then
            print(string.format("Transition:init: code: %s, clean: %s", code, clean))
        end
        table.insert(self.codes, clean)
    end
    if ENABLE_DEBUG_LOG_TRANSITION then
        print(string.format("Transition:init: self.codes len: %s", #self.codes))
        for _, v in ipairs(self.codes) do
            print(string.format("\t%s", v))
        end
    end
    self.active = true
    self.enableStateChanging = enableStateChanging
    self.state = defaultState
    self.old_value = self.state

    self:getImages()
    self:setState(self.state)
    self:setActive(self.active)
end

function Transition:getImages()
    self.images = {}
    for k, v in pairs(Transition.STATES) do
        if type(v) ~= "string" then
            -- skip reverse lookup entiers
        else
            local name = v:lower():gsub('[%s]+', '_')
            self.images[k] = ImageReference:FromPackRelativePath("images/trans/" .. name .. ".png")
        end
    end
end

function Transition:getState()
    return self.state
end

function Transition:setState(state)
    self:propertyChanged("state", state)
end

function Transition:setActive(active)
    self:propertyChanged("active", active)
end

function Transition:getActive()
    return self.active
end

function Transition:updateIcon()
    if self.active then
        self.ItemInstance.Icon = self.images[self.state]
    else
        self.ItemInstance.Icon = self.images[0]
    end
end

function Transition:onLeftClick()
    self:setActive(true)
end

function Transition:onRightClick()
    self:setActive(false)
end

function Transition:canProvideCode(code)
    for _, v in pairs(self.codes) do
        if code == v then
            return true
        end
    end
    return false
end

function Transition:providesCode(code)
    for _, v in pairs(self.codes) do
        if code == v then
            if self:getActive() then
                return self.state
            else
                return 0
            end
        end
    end
    return 0
end

function Transition:advanceToCode(code)
end

function Transition:save()
    local saveData = {}
    saveData["state"] = self:getState()
    saveData["active"] = self.active
    saveData["enableStateChanging"] = self.enableStateChanging
    return saveData
end

function Transition:load(data)
    if data["state"] ~= nil then
        self:setProperty("state", data["state"])
    end
    if data["active"] ~= nil then
        self:setProperty("active", data["active"])
    end
    if data["enableStateChanging"] ~= nil then
        self:setProperty("enableStateChanging", data["enableStateChanging"])
    end
    return true
end

function Transition:removeExit()
    if self.old_state ~= 0 and self.old_state ~= nil then
        if ENABLE_DEBUG_LOG_TRANSITION then
            print(string.format("\tremoving exit for %s (%s (%s))", self.name, self.old_state,
                Transition.STATES[self.old_state]))
        end
        local target_region = REGIONS[self.name]
        if target_region == nil and ENABLE_DEBUG_LOG_TRANSITION then
            print(string.format("\tdidn't find region for %s", self.name))
        end
        if target_region ~= nil then
            if target_region.exits[Transition.STATES[self.old_state]] ~= nil then
                target_region.exits[Transition.STATES[self.old_state]] = nil
            end
        end
    end
end

function Transition:addExit()
    if self.state ~= 0 then
        if ENABLE_DEBUG_LOG_TRANSITION then
            print(string.format("\tadding exit for %s (%s)", self.name, self.state))
        end
        local target_region = REGIONS[self.name]
        if target_region == nil and ENABLE_DEBUG_LOG_TRANSITION then
            print(string.format("\tdidn't find region for %s", self.name))
        end
        if target_region ~= nil then
            target_region.exits[Transition.STATES[self.state]] = target_region.traverse
        end
    end
end

function Transition:setDisplayName(name)
    self.display_name = name
    self.ItemInstance.Name = name
end

function Transition:updateDisplayName()
    if self.active then
        self:setDisplayName(Transition.STATES[self.state])
    else
        self:setDisplayName(Transition.STATES[0])
    end
end

function Transition:propertyChanged(key, value)
    if ENABLE_DEBUG_LOG_TRANSITION then
        print(string.format("Transition:propertyChanged for %s key %s with value %s", self.name, key, value))
    end
    if key == "state" then
        -- remove old exit    
        self:removeExit()
        self.state = value
        self.old_state = self.state
        -- add new exit
        if self.active then
            self:addExit()
        end

        -- set the opposite site as well
        -- local code = "trans_" .. Transition.STATES[value]:gsub("[%s]+", "")
        -- local obj = Tracker:FindObjectForCode(code)
        -- local state = Transition.STATES[self.name]   
        -- if obj and obj:Get("state") ~= Transition.STATES[self.name] then
        --    if ENABLE_DEBUG_LOG_TRANSITION then            
        --        print(string.format("\tchanging obj %s to state %s", code, state))
        --    end
        --    obj:Set("state", state)
        --    --obj:Set("active", true)
        -- end
    end
    if key == "active" then
        self.active = value
        -- add/remove exit
        if self.active then
            self:addExit()
        else
            self:removeExit()
        end
        if self.state then
            local code = "trans_" .. Transition.STATES[self.state]:gsub("[%s]+", "")
            local obj = Tracker:FindObjectForCode(code)
            if obj and obj:Get("active") ~= value then
                obj:Set("active", value)
            end
        end
    end
    if key == "enableStateChanging" then
        self.enableStateChanging = value
    end
    if key == "state" or key == "active" then
        self:updateIcon()
        self:updateDisplayName()
    end
end

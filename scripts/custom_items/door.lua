Door = class(CustomItemProgressiveToggle)

ENABLE_DEBUG_LOG_DOOR = false and ENABLE_DEBUG_LOG

--[[
    represents a door in SM
    the state holds the door's color:
        0 = hidden
        1 = grey
        2 = blue / blinking grey
        3 = red
        4 = green
        5 = yellow
        6 = wave
        7 = spazer
        8 = plasma
        9 = ice
]]
function Door:init(name, codes, defaultState, enableStateChanging, isAreaTrans)

    self.STATES = {
        0, --hidden
        1, --grey
        2, --blue
        3, --red
        4, --green
        5, --yellow
        6, --wave
        7, --spazer,
        8, --plasma
        9, --ice
    }

    self:createItem(name)

    if isAreaTrans == nil then
        isAreaTrans = false
    end
    self.codes = {}
    self.isAreaTrans = isAreaTrans
    
    for code in string.gmatch(codes, "[^,]+") do
        local clean = string.gsub(code, "[%s]+", "")
        if ENABLE_DEBUG_LOG_DOOR then
            print(string.format("Door:init: code: %s, clean: %s", code, clean))    
        end
        table.insert(self.codes, clean)
    end
    if ENABLE_DEBUG_LOG_DOOR then
        print(string.format("Door:init: self.codes len: %s", #self.codes))
        for _, v in ipairs(self.codes) do
            print(string.format("\t%s", v))
        end
    end    
    self.active = false
    self.enableStateChanging = enableStateChanging   
    self.state = defaultState
    

    self:getImages()
    self:setState(self.state)
    self:setActive(self.active)    
end

function Door:getImages()
    self.images = {}
    self.images[0] = ImageReference:FromPackRelativePath("images/items/doors/hidden.png")
    self.images[1] = ImageReference:FromPackRelativePath("images/items/doors/grey.png")
    self.images[2] = ImageReference:FromPackRelativePath("images/items/doors/blue.png")
    self.images[3] = ImageReference:FromPackRelativePath("images/items/doors/red.png")
    self.images[4] = ImageReference:FromPackRelativePath("images/items/doors/green.png")
    self.images[5] = ImageReference:FromPackRelativePath("images/items/doors/yellow.png")
    self.images[6] = ImageReference:FromPackRelativePath("images/items/doors/wave.png")
    self.images[7] = ImageReference:FromPackRelativePath("images/items/doors/spazer.png")
    self.images[8] = ImageReference:FromPackRelativePath("images/items/doors/plasma.png")
    self.images[9] = ImageReference:FromPackRelativePath("images/items/doors/ice.png")
end

function Door:getState()
    return self.state
end

function Door:setState(state)
    self:propertyChanged("state",state)
end

function Door:setActive(active)
    self:propertyChanged("active",active)
end

function Door:getActive()
    return self.active
end

function Door:updateIcon()
    if self.active then
        self.ItemInstance.Icon = self.images[self.state]
    else
        self.ItemInstance.Icon = self.images[0]
    end
end

function Door:onLeftClick()
    self:setActive(true)
end

function Door:onRightClick()
    self:setActive(false)
end

function Door:canProvideCode(code)
    for _,v in pairs(self.codes) do
        if code == v then
            return true
        end
    end    
    return false
end

function Door:providesCode(code)
    for _,v in pairs(self.codes) do
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

function Door:advanceToCode(code)
end

function Door:save()
    local saveData = {}
    saveData["state"] = self:getState()
    saveData["active"] = self.active
    saveData["enableStateChanging"] = self.enableStateChanging
    return saveData
end

function Door:load(data)
    if data["state"] ~= nil then
        self:setProperty("state",data["state"])
    end
    if data["active"] ~= nil then
        self:setProperty("active",data["active"])
    end
    if data["enableStateChanging"] ~= nil then
        self:setProperty("enableStateChanging",data["enableStateChanging"])
    end
    return true
end

function Door:propertyChanged(key, value)
    if ENABLE_DEBUG_LOG_DOOR then
        print(string.format("Door:propertyChanged key %s with value %s",key,value))        
    end
    if key == "state" then
        self.state = value
    end
    if key == "active" then
        self.active = value
    end
    if key == "enableStateChanging" then
        self.enableStateChanging = value
    end
    if key == "state" or key == "active" then
        self:updateIcon()
    end
end

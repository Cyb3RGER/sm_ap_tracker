DOOR_COLOR_MAPPING = {
    ['hidden'] = 0,
    ['grey'] = 1,
    ['blue'] = 2,
    ['red'] = 3,
    ['green'] = 4,
    ['yellow'] = 5,
    ['wave'] = 6,
    ['spazer'] = 7,
    ['plasma'] = 8,
    ['ice'] = 9,
}

function set_doors(slot_data)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_DOORS then
        print(string.format("called setDoors"))
    end
    if slot_data == nil or slot_data['Doors'] == nil or slot_data['doors_colors_rando'] == nil then
        return
    end
    for k,v in pairs(slot_data['Doors']) do
        local obj = Tracker:FindObjectForCode(k)
        if obj then
            obj:Set("state", DOOR_COLOR_MAPPING[v])            
            obj:Set("active", (is_door_rando() == 0) or (obj:Get("isAreaTrans") and is_area_rando() > 0))
        end
    end
end

function traverse(door_code)
    local door_state = Tracker:ProviderCountForCode(door_code)
    local value = 0
    if door_state == 0 and door_state == 1 then
        value = 0
    elseif door_state == 2 then
        value = 1
    elseif door_state == 3 then
        if missile() > 0 then
            value = 1
        else
            value = 0        
        end
    elseif door_state == 4 then
        if super() > 0 then
            value = 1
        else
            value = 0        
        end 
    elseif door_state == 5 then
        if can_use_power_bombs() > 0 then
            value = 1
        else
            value = 0        
        end 
    elseif door_state == 6 then
        if wave() > 0 then
            value = 1
        else
            value = 0        
        end 
    elseif door_state == 7 then
        if spazer() > 0 then
            value = 1
        else
            value = 0        
        end 
    elseif door_state == 8 then
        if plasma() > 0 then
            value = 1
        else
            value = 0        
        end 
    elseif door_state == 9 then
        if ice() > 0 then
            value = 1
        else
            value = 0        
        end     
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_DOORS then
        print(string.format("called traverse: door_code: %s, door_state: %s, value: %s", door_code, door_state, value))
    end
    if value > 0 then
        return 1
    end
    return 0
end
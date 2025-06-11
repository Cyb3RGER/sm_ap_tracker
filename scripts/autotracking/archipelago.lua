ScriptHost:LoadScript("scripts/autotracking/item_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/location_mapping.lua")

-- used for hint tracking to quickly map hint status to a value from the Highlight enum
HINT_STATUS_MAPPING = {}
if Highlight then
    HINT_STATUS_MAPPING = {
        [20] = Highlight.Avoid,
        [40] = Highlight.None,
        [10] = Highlight.NoPriority,
        [0] = Highlight.Unspecified,
        [30] = Highlight.Priority,
    }
end


LOCAL_ITEMS = {}
GLOBAL_ITEMS = {}

function onClear(slot_data)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
        print(string.format("called onClear, slot_data:\n%s", dump_table(slot_data)))
    end
    Tracker.BulkUpdate = true
    SLOT_DATA = slot_data
    CUR_INDEX = -1
    set_transitions(slot_data)
    set_doors(slot_data)
    for _, v in pairs(LOCATION_MAPPING) do
        if v[1] then
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                print(string.format("onClear: clearing location %s", v[1]))
            end
            local obj = Tracker:FindObjectForCode(v[1])
            if obj then
                if v[1]:sub(1, 1) == "@" then
                    obj.AvailableChestCount = obj.ChestCount
                    if obj.Highlight then
                        obj.Highlight = Highlight.None
                    end
                else
                    obj.Active = false
                end
            elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                print(string.format("onClear: could not find object for code %s", v[1]))
            end
        end
    end
    for _, v in pairs(ITEM_MAPPING) do
        if v[1] and v[2] then
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                print(string.format("onClear: clearing item %s of type %s", v[1], v[2]))
            end
            local obj = Tracker:FindObjectForCode(v[1])
            if obj then
                if v[2] == "toggle" then
                    obj.Active = false
                elseif v[2] == "progressive" then
                    obj.CurrentStage = 0
                    obj.Active = false
                elseif v[2] == "consumable" then
                    obj.AcquiredCount = 0
                elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                    print(string.format("onClear: unknown item type %s for code %s", v[2], v[1]))
                end
            elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                print(string.format("onClear: could not find object for code %s", v[1]))
            end
        end
    end
    REACHED_ACCESS_POINTS = {}
    LOCAL_ITEMS = {}
    GLOBAL_ITEMS = {}
    --manually run snes interface functions after onClear in case we are already ingame
    if PopVersion < "0.20.1" or AutoTracker:GetConnectionState("SNES") == 3 then
        update_saved_map_data()
        update_boss_data()
    end
    -- setup data storage tracking for hint tracking
    local data_strorage_keys = { getHintDataStorageKey() }
    -- subscribes to the data storage keys for updates
    Archipelago:SetNotify(data_strorage_keys)
    -- gets the current value for the data storage keys
    Archipelago:Get(data_strorage_keys)
    Tracker.BulkUpdate = false
end

function onItem(index, item_id, item_name, player_number)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
        print(string.format("called onItem: %s, %s, %s, %s, %s", index, item_id, item_name, player_number, CUR_INDEX))
    end
    if index <= CUR_INDEX then return end
    local is_local = player_number == Archipelago.PlayerNumber
    CUR_INDEX = index;
    local v = ITEM_MAPPING[item_id]
    if not v then
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
            print(string.format("onItem: could not find item mapping for id %s", item_id))
        end
        return
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
        print(string.format("onItem: code: %s, type %s", v[1], v[2]))
    end
    if not v[1] then
        return
    end
    local obj = Tracker:FindObjectForCode(v[1])
    if obj then
        if v[2] == "toggle" then
            obj.Active = true
        elseif v[2] == "progressive" then
            if obj.Active then
                obj.CurrentStage = obj.CurrentStage + 1
            else
                obj.Active = true
            end
        elseif v[2] == "consumable" then
            obj.AcquiredCount = obj.AcquiredCount + obj.Increment
        elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING then
            print(string.format("onItem: unknown item type %s for code %s", v[2], v[1]))
        end
    elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING then
        print(string.format("onItem: could not find object for code %s", v[1]))
    end
    --track local items via snes interface
    if is_local then
        if LOCAL_ITEMS[v[1]] then
            LOCAL_ITEMS[v[1]] = LOCAL_ITEMS[v[1]] + 1
        else
            LOCAL_ITEMS[v[1]] = 1
        end
    else
        if GLOBAL_ITEMS[v[1]] then
            GLOBAL_ITEMS[v[1]] = GLOBAL_ITEMS[v[1]] + 1
        else
            GLOBAL_ITEMS[v[1]] = 1
        end
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
        print(string.format("local items: %s", dump_table(LOCAL_ITEMS)))
        print(string.format("global items: %s", dump_table(GLOBAL_ITEMS)))
    end
    if PopVersion < "0.20.1" or AutoTracker:GetConnectionState("SNES") == 3 then
        update_item_data()
    end
end

function onLocation(location_id, location_name)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
        print(string.format("called onLocation: %s, %s", location_id, location_name))
    end
    local v = LOCATION_MAPPING[location_id]
    if not v and AUTOTRACKER_ENABLE_DEBUG_LOGGING then
        print(string.format("onLocation: could not find location mapping for id %s", location_id))
    end
    if not v[1] then
        return
    end
    local obj = Tracker:FindObjectForCode(v[1])
    if obj then
        if v[1]:sub(1, 1) == "@" then
            obj.AvailableChestCount = obj.AvailableChestCount - 1
        else
            obj.Active = true
        end
    elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING then
        print(string.format("onLocation: could not find object for code %s", v[1]))
    end
end

-- gets the data storage key for hints for the current player
-- returns nil when not connected to AP
function getHintDataStorageKey()
    if AutoTracker:GetConnectionState("AP") ~= 3 or Archipelago.TeamNumber == nil or Archipelago.TeamNumber == -1 or Archipelago.PlayerNumber == nil or Archipelago.PlayerNumber == -1 then
        print("Tried to call getHintDataStorageKey while not connected to AP server")
        return nil
    end
    return string.format("_read_hints_%s_%s", Archipelago.TeamNumber, Archipelago.PlayerNumber)
end


-- called whenever Archipelago:Get returns data from the data storage or
-- whenever a subscribed to (via Archipelago:SetNotify) key in data storgae is updated
-- oldValue might be nil (always nil for "_read" prefixed keys and via retrieved handler (from Archipelago:Get))
function onDataStorageUpdate(key, value, oldValue)
    --if you plan to only use the hints key, you can remove this if
    if key == getHintDataStorageKey() then
        onHintsUpdate(value)
    end
end

-- called whenever the hints key in data storage updated
function onHintsUpdate(hints)
    if not AUTOTRACKER_ENABLE_LOCATION_TRACKING then
        return
    end
    local player_number = Archipelago.PlayerNumber
    for _, hint in ipairs(hints) do
        -- we only care about hints in our world
        if hint.finding_player == player_number then
            updateHint(hint)
        end
    end
end

function updateHint(hint)
    -- get the highlight enum value for the hint status
    local hint_status = hint.status
    local highlight_code = nil
    if hint_status then
        highlight_code = HINT_STATUS_MAPPING[hint_status]
    end
    if not highlight_code then
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
            print(string.format("updateHint: unknown hint status %s for hint on location id %s", hint.status,
                hint.location))
        end
        -- try to "recover" by checking hint.found (older AP versions without hint.status)
        if hint.found == true then
            highlight_code = Highlight.None
        elseif hint.found == false then
            highlight_code = Highlight.Unspecified
        else
            return
        end
    end
    -- get the location mapping for the location id
    local mapping_entry = LOCATION_MAPPING[hint.location]
    if not mapping_entry then
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
            print(string.format("updateHint: could not find location mapping for id %s", hint.location))
        end
        return
    end
    for _, location_code in pairs(mapping_entry) do
        -- skip hosted items, they don't support Highlight
        if location_code and location_code:sub(1, 1) == "@" then
            -- find the location object
            local obj = Tracker:FindObjectForCode(location_code)
            -- check if we got the location and if it supports Highlight
            if obj and obj.Highlight then
                obj.Highlight = highlight_code
            elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                print(string.format("updateHint: could update section %s (obj doesn't support Highlight)", location_code))
            end
        end
    end
end

Archipelago:AddClearHandler("clear handler", onClear)
Archipelago:AddItemHandler("item handler", onItem)
Archipelago:AddLocationHandler("location handler", onLocation)
Archipelago:AddRetrievedHandler("retrieved handler", onDataStorageUpdate)
Archipelago:AddSetReplyHandler("set reply handler", onDataStorageUpdate)

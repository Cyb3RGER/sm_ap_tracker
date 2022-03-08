-- items
function charge()
    local value = Tracker:ProviderCountForCode('charge')
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_ITEMS then
        print(string.format("called charge: value: %s",value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function wave()
    local value = Tracker:ProviderCountForCode('wave')
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_ITEMS then
        print(string.format("called wave: value: %s",value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function ice()
    local value = Tracker:ProviderCountForCode('ice')
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_ITEMS then
        print(string.format("called ice: value: %s",value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function plasma()
    local value = Tracker:ProviderCountForCode('plasma')
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_ITEMS then
        print(string.format("called plasma: value: %s",value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function spazer()
    local value = Tracker:ProviderCountForCode('spazer')
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_ITEMS then
        print(string.format("called spazer: value: %s",value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function varia()
    local value = Tracker:ProviderCountForCode('varia')
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_ITEMS then
        print(string.format("called varia: value: %s",value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function gravity()
    local value = Tracker:ProviderCountForCode('gravity')
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_ITEMS then
        print(string.format("called gravity: value: %s",value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function morph()
    local value = Tracker:ProviderCountForCode('morph')
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_ITEMS then
        print(string.format("called morph: value: %s",value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function bomb()
    local value = Tracker:ProviderCountForCode('bomb')
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_ITEMS then
        print(string.format("called bomb: value: %s",value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function spring()
    local value = Tracker:ProviderCountForCode('spring')
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_ITEMS then
        print(string.format("called spring: value: %s",value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function hijump()
    local value = Tracker:ProviderCountForCode('hijump')
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_ITEMS then
        print(string.format("called hijump: value: %s",value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function space()
    local value = Tracker:ProviderCountForCode('space')
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_ITEMS then
        print(string.format("called space: value: %s",value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function speed()
    local value = Tracker:ProviderCountForCode('speed')
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_ITEMS then
        print(string.format("called speed: value: %s",value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function grapple()
    local value = Tracker:ProviderCountForCode('grapple')
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_ITEMS then
        print(string.format("called grapple: value: %s",value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function xray()
    local value = Tracker:ProviderCountForCode('xray')
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_ITEMS then
        print(string.format("called xray: value: %s",value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function screw()
    local value = Tracker:ProviderCountForCode('screw')
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_ITEMS then
        print(string.format("called screw: value: %s",value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function hyper()
    local value = Tracker:ProviderCountForCode('hyper')
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_ITEMS then
        print(string.format("called hyper: value: %s",value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function ridley()
    local value = Tracker:ProviderCountForCode('ridley')
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_ITEMS then
        print(string.format("called ridley: value: %s",value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function kraid()
    local value = Tracker:ProviderCountForCode('kraid')
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_ITEMS then
        print(string.format("called kraid: value: %s",value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function phantoon()
    local value = Tracker:ProviderCountForCode('phantoon')
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_ITEMS then
        print(string.format("called phantoon: value: %s",value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function draygon()
    local value = Tracker:ProviderCountForCode('draygon')
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_ITEMS then
        print(string.format("called draygon: value: %s",value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function motherbrain()
    local value = Tracker:ProviderCountForCode('motherbrain')
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_ITEMS then
        print(string.format("called motherbrain: value: %s",value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function missile()
    local value = Tracker:ProviderCountForCode('missile')
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_ITEMS then
        print(string.format("called missile: value: %s",value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function super()
    local value = Tracker:ProviderCountForCode('super')
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_ITEMS then
        print(string.format("called super: value: %s",value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function powerbomb()
    local value = Tracker:ProviderCountForCode('powerbomb')
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_ITEMS then
        print(string.format("called powerbomb: value: %s",value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function etank()
    local value = Tracker:ProviderCountForCode('etank')
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_ITEMS then
        print(string.format("called etank: value: %s",value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function reserve()
    local value = Tracker:ProviderCountForCode('reserve')
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_ITEMS then
        print(string.format("called reserve: value: %s",value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

-- item helper
function get_consumable_qty(code)
    
    local obj = Tracker:FindObjectForCode(code)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_ITEMS then
        print(string.format("called get_consumable_qty: code: %s, obj %s",code, obj))
    end
    if obj then        
        return obj.AcquiredCount / obj.Increment
    end
    return 0
end
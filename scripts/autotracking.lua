-- Configuration --------------------------------------
AUTOTRACKER_ENABLE_DEBUG_LOGGING = false or ENABLE_DEBUG_LOG
AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC = false and AUTOTRACKER_ENABLE_DEBUG_LOGGING
AUTOTRACKER_ENABLE_DEBUG_LOGGING_UTILS = false and AUTOTRACKER_ENABLE_DEBUG_LOGGING
AUTOTRACKER_ENABLE_DEBUG_LOGGING_ITEMS = false and AUTOTRACKER_ENABLE_DEBUG_LOGGING
AUTOTRACKER_ENABLE_DEBUG_LOGGING_ACCESS = false and AUTOTRACKER_ENABLE_DEBUG_LOGGING
AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOCATION = false and AUTOTRACKER_ENABLE_DEBUG_LOGGING
AUTOTRACKER_ENABLE_DEBUG_LOGGING_DOORS = false and AUTOTRACKER_ENABLE_DEBUG_LOGGING
AUTOTRACKER_ENABLE_DEBUG_LOGGING_SNES = false and AUTOTRACKER_ENABLE_DEBUG_LOGGING
AUTOTRACKER_ENABLE_ITEM_TRACKING = true
AUTOTRACKER_ENABLE_LOCATION_TRACKING = true and not IS_ITEMS_ONLY
AUTOTRACKER_ENABLE_AUTO_MAP_SWITCHING = true and not IS_ITEMS_ONLY
-------------------------------------------------------

print("")
print("Active Auto-Tracker Configuration")
print("---------------------------------------------------------------------")
print("Enable Item Tracking:        ", AUTOTRACKER_ENABLE_ITEM_TRACKING)
print("Enable Location Tracking:    ", AUTOTRACKER_ENABLE_LOCATION_TRACKING)
if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
    print("Enable Debug Logging:        ", AUTOTRACKER_ENABLE_DEBUG_LOGGING)
    print("Enable Utils Debug Logging:        ", AUTOTRACKER_ENABLE_DEBUG_LOGGING_UTILS)
    print("Enable Items Debug Logging:        ", AUTOTRACKER_ENABLE_DEBUG_LOGGING_ITEMS)
    print("Enable Access Debug Logging:        ", AUTOTRACKER_ENABLE_DEBUG_LOGGING_ACCESS)
    print("Enable Locations Debug Logging:        ", AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOCATION)
    print("Enable Doors Debug Logging:        ", AUTOTRACKER_ENABLE_DEBUG_LOGGING_DOORS)
    print("Enable SNES Debug Logging:        ", AUTOTRACKER_ENABLE_DEBUG_LOGGING_SNES)
end
print("---------------------------------------------------------------------")
print("")

CUR_INDEX = -1
SLOT_DATA = nil

ScriptHost:LoadScript("scripts/autotracking/archipelago.lua")
ScriptHost:LoadScript("scripts/autotracking/snes.lua")


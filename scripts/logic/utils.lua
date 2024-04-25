function wand(args)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_UTILS then
        print(string.format("called wand: args %s", args))
    end
    local result = true
    for i = 1, #args do
        if not result then
            break
        end
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING_UTILS then
            print(string.format("\targs[i]: %s, result: %s", args[i], result))
        end
        result = result and args[i] > 0
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_UTILS then
        print(string.format("\t\tresult: %s", result))
    end
    if result then
        return 1
    end
    return 0
end

function wor(args)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_UTILS then
        print(string.format("called wor: args %s", args))
    end
    local result = false
    for i = 1, #args do
        if result then
            break
        end
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING_UTILS then
            print(string.format("\targs[i]: %s, result: %s", args[i], result))
        end
        result = result or args[i] > 0
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_UTILS then
        print(string.format("\t\tresult: %s", result))
    end
    if result then
        return 1
    end
    return 0
end

function wnot(arg)
    if arg > 0 then
        return 0
    else
        return 1
    end
end

-- https://stackoverflow.com/questions/18313171/lua-rounding-numbers-and-then-truncate
function round(num, numDecimalPlaces)
    local mult = 10 ^ (numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

-- from https://www.lua.org/pil/19.3.html
-- returns pairs by key of a table in order of the supplied sort function "f"
-- when f == nil => defaults to a comparision with >
function pairsByKeys(t, f)
    local a = {}
    for n in pairs(t) do table.insert(a, n) end
    table.sort(a, f)
    local i = 0              -- iterator variable
    local iter = function()  -- iterator function
        i = i + 1
        if a[i] == nil then
            return nil
        else
            return a[i], t[a[i]]
        end
    end
    return iter
end

-- from https://stackoverflow.com/questions/9168058/how-to-dump-a-table-to-console
function dump_table(o, depth)
    if depth == nil then
        depth = 0
    end
    if type(o) == 'table' then
        local tabs = ('\t'):rep(depth)
        local tabs2 = ('\t'):rep(depth + 1)
        local s = '{\n'
        for k, v in pairs(o) do
            if type(k) ~= 'number' then k = '"' .. k .. '"' end
            s = s .. tabs2 .. '[' .. k .. '] = ' .. dump_table(v, depth + 1) .. ',\n'
        end
        return s .. tabs .. '}'
    else
        return tostring(o)
    end
end

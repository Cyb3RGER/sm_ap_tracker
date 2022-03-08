TRANSITIONS = {}

DEFAULT_TRANSITIONS = {
    [1] = 5,
    [2] = 31,
    [3] = 11,
    [4] = 22,
    [5] = 1,
    [6] = 7, 
    [7] = 6,
    [8] = 9,
    [9] = 8,
    [10] = 37,
    [11] = 3,
    [12] = 24,
    [13] = 16,
    [14] = 23,
    [15] = 26,
    [16] = 13,
    [17] = 30,
    [18] = 19,
    [19] = 18,
    [20] = 21,
    [21] = 20,
    [22] = 4,
    [23] = 14,
    [24] = 12,
    [25] = 40,
    [26] = 15,
    [27] = 32,
    [28] = 29,
    [29] = 28,
    [30] = 17,
    [31] = 2,
    [32] = 27,
    [33] = 34,
    [34] = 33,
    [35] = 36,
    [36] = 35,
    [37] = 10,
    [38] = 39,
    [39] = 38,
    [40] = 25
}
BOSS_TRANSITIONS = {}

for k, v in pairs(Transition.STATES) do
    if k == "hidden" or type(k) ~= "string" then
        --skip hidden and backwards lookup entries
    else        
        if ENABLE_DEBUG_LOG then
            print(string.format('adding transition %s with code %s and default state %s', k, "trans_"..(k:gsub("[%s]+","")), DEFAULT_TRANSITIONS[v]))
        end
        local item = Transition(k, "trans_"..(k:gsub("[%s]+","")), DEFAULT_TRANSITIONS[v], false)
        table.insert(TRANSITIONS, item)
        if k:find('In') or k:find('Out') then
            table.insert(BOSS_TRANSITIONS, item)
        end
    end
end
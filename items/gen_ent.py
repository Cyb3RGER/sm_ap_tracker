import json

STATES = {
    "hidden",
    "Aqueduct Top Left",
    "Caterpillar Room Top Right",
    "Crab Hole Bottom Left",
    "Crab Maze Left",
    "Crab Shaft Right",
    "Crocomire Room Top",
    "Crocomire Speedway Bottom",
    "DraygonRoomIn",
    "DraygonRoomOut",
    "East Tunnel Right",
    "East Tunnel Top Right",
    "Glass Tunnel Top",
    "Golden Four",
    "Green Brinstar Elevator",
    "Green Hill Zone Top Right",
    "Green Pirates Shaft Bottom Right",
    "Keyhunter Room Bottom",
    "KraidRoomIn",
    "KraidRoomOut",
    "Kronic Boost Room Bottom Left",
    "Lava Dive Right",
    "Le Coude Right",
    "Lower Mushrooms Left",
    "Main Street Bottom",
    "Moat Right",
    "Morph Ball Room Left",
    "Noob Bridge Right",
    "PhantoonRoomIn",
    "PhantoonRoomOut",
    "Red Brinstar Elevator",
    "Red Fish Room Left",
    "Red Tower Top Left",
    "RidleyRoomIn",
    "RidleyRoomOut",
    "Single Chamber Top Right",
    "Three Muskateers Room Left",
    "Warehouse Entrance Left",
    "Warehouse Entrance Right",
    "Warehouse Zeela Room Left",
    "West Ocean Left",
    "Arrow"
}
LABLES = {
    "Crateria",
    "Crocomire",
    "Green Brinstar",
    "Red Brinstar",
    "Upper Norfair",
    "Lower Norfair",
    "East Maridia",
    "West Maridia",
    "Wrecked Ship",
    "Tourian",
    "Kraid's Lair"
}

result  = []

for state in STATES:
    print(state)
    img = state.lower().replace(" ","_")
    code = state.replace(" ","")
    item = {
        "name": state,
        "type": "static",
        "img": "images/trans/" + img + ".png",
        "codes": "static_" + code
    }
    result.append(item)
    
for label in LABLES:
    print(label)
    img = label.lower().replace(" ","_").replace("'","")
    code = label.replace(" ","").replace("'","")
    item = {
        "name": label,
        "type": "static",
        "img": "images/trans/" + img + ".png",
        "codes": "static_" + code
    }
    result.append(item)
    
item = {
    "name": "Arrow",
    "type": "static",
    "img": "images/trans/arrow.png",
    "codes": "arrow"
}
result.append(item)

with open('entrances.json', 'w', encoding='utf-8') as f:
    json.dump(result, f, indent=4)
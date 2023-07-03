--
--[====[

generate procedual graphics
==============
Generates graphics for necromancer experiments and divine creatures and puts it into your current save folder

]====]
local utils = require 'utils'

math.randomseed(os.time()) -- random initialize
math.random(); math.random(); math.random() -- warming up

function randomnumber( oneortwo )
        -- random generating
        if oneortwo == 1 then
            value1 = math.random(0,31)
            return value1
        end
        if oneortwo == 2 then
            value2 = math.random(0,29)
            return value2
    end
end
    local selection
    local key = 1
    local hfexpId = {}

    for id, raw in pairs(df.global.world.raws.creatures.all) do
        if raw.creature_id:startswith('HFEXP') then
            hfexpId[key] = raw.creature_id
            key = key + 1
        end
    end

    local key2 = 1
    local hfId = {}

    for id, raw in pairs(df.global.world.raws.creatures.all) do
        if raw.creature_id:startswith('HF') and not raw.creature_id:startswith('HFEXP') then
            hfId[key2] = raw.creature_id
            key2 = key2 + 1
        end
    end

function dfhack.getSavePath()
    if dfhack.isWorldLoaded() then
        return dfhack.getDFPath() .. '/data/save/' .. df.global.world.cur_savegame.save_dir .. '/raw/graphics/'
    end
end

os.execute('mkdir' .. dfhack.getSavePath()..'graphics_procedual_hfexp.txt')
file = io.open(dfhack.getSavePath()..'graphics_procedual_hfexp.txt', 'w')
file:write('denzi/graphics_procedual_hfexp\n')
file:write('[OBJECT:GRAPHICS] \n')
file:write('[TILE_PAGE:NECRO] \n')
file:write('[FILE:procedual_hfexp.png] \n')
file:write('[TILE_DIM:32:32] \n')
file:write('[PAGE_DIM:26:30] \n \n')

for i in ipairs(hfexpId) do
    file:write('[CREATURE_GRAPHICS:', hfexpId[i], '] \n')
    file:write('[DEFAULT:NECRO'..':'..randomnumber(1)..':'..randomnumber(2)..':AS_IS:DEFAULT] \n')
end

file:close()

os.execute('mkdir' .. dfhack.getSavePath()..'graphics_procedual_divine.txt')
file = io.open(dfhack.getSavePath()..'graphics_procedual_divine.txt', 'w')
file:write('denzi/graphics_procedual_divine\n')
file:write('[OBJECT:GRAPHICS] \n')
file:write('[TILE_PAGE:DIVINE] \n')
file:write('[FILE:procedual_divine.png] \n')
file:write('[TILE_DIM:32:32] \n')
file:write('[PAGE_DIM:26:30] \n \n')

for i in ipairs(hfId) do
    file:write('[CREATURE_GRAPHICS:', hfId[i], '] \n')
    file:write('[DEFAULT:DIVINE'..':'..randomnumber(1)..':'..randomnumber(2)..':AS_IS:DEFAULT] \n')
end

file:close()

print('Generated graphics for Divine and Experiments')
print('Found '..(key - 1)..' Experiments')
print('Found '..(key2 - 1)..' Angels')

return

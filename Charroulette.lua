-- Charroulette Balatro Mod
-- Main
-- lu1smgb@18/12/2024

local log_loading_key = 'CHR'

local jokers_module, error = SMODS.load_file('src/Jokers.lua', mod_id)
if not error and jokers_module then
    jokers_module()
else
    sendErrorMessage("Could not load jokers", log_loading_key)
end
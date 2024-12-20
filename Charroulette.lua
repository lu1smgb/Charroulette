-- Charroulette Balatro Mod
-- Main
-- lu1smgb@18/12/2024

local mod_id = 'Charroulette'

local modules = {
    'src/Sounds.lua',
    'src/Jokers.lua'
}

for _, module in ipairs(modules) do
    sendInfoMessage("Loading module "..module, mod_id)
    local mod_content, error = SMODS.load_file(module, mod_id)
    if error then
        sendErrorMessage("Could not load module in "..module, mod_id)
    elseif mod_content then
        mod_content()
    end
end

-- local jokers_module, error = SMODS.load_file('src/Jokers.lua', log_loading_key)
-- if not error and jokers_module then
--     jokers_module()
-- else
--     sendErrorMessage("Could not load jokers", log_loading_key)
-- end
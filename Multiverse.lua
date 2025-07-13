Multiverse = {}
local mod_path = "" .. SMODS.current_mod.path
Multiverse.path = mod_path

local files = {
    "content/atlases.lua",
    "content/jokers.lua",
    "content/transmuted_jokers.lua"
}

for _, path in ipairs(files) do
    SMODS.load_file(path)()
end
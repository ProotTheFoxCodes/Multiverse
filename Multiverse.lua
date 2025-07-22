Multiverse = {}
local mod_path = "" .. SMODS.current_mod.path
Multiverse.path = mod_path

Multiverse.TRANSMUTED_GRADIENT = SMODS.Gradient {
    key = "transmuted_gradient",
    colours = {
        HEX("89C41B"),
        HEX("C5CC41")
    },
    cycle = 1.5
}

local files = {
    "misc/util.lua",
    "mod/atlases.lua",
    "mod/stickers.lua",
    "mod/overrides.lua",
    "mod/transmuted_jokers.lua",
    "mod/jokers.lua",
    "mod/tarots.lua",
    "mod/spectrals.lua",
    --"mod/myth.lua"
}

for _, path in ipairs(files) do
    SMODS.load_file(path)()
end
Multiverse = {}
Multiverse.path = "" .. SMODS.current_mod.path
SMODS.optional_features.quantum_enhancements = true
Multiverse.TRANSMUTED_GRADIENT = SMODS.Gradient {
    key = "transmuted_gradient",
    colours = {
        HEX("89C41B"),
        HEX("C5CC41")
    },
    cycle = 1.5
}

Multiverse.config = SMODS.current_mod.config

local misc_files = NFS.getDirectoryItems(Multiverse.path .. "misc")
for _, item in ipairs(misc_files) do
    print("Multiverse: Loading " .. item)
    local f, err = SMODS.load_file("misc/" .. item)
    if err then error(err) elseif f then f() end
end
local mod_files = NFS.getDirectoryItems(Multiverse.path .. "mod")
for _, item in ipairs(mod_files) do
    print("Multiverse: Loading " .. item)
    local f, err = SMODS.load_file("mod/" .. item)
    if err then error(err) elseif f then f() end
end
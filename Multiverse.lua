Multiverse = {}
Multiverse.path = "" .. SMODS.current_mod.path
Multiverse.TRANSMUTED_GRADIENT = SMODS.Gradient {
    key = "transmuted_gradient",
    colours = {
        HEX("89C41B"),
        HEX("C5CC41")
    },
    cycle = 1.5
}
Multiverse.C = {}
Multiverse.C.PRIMARY1 = HEX("89C41B")
Multiverse.C.PRIMARY2 = HEX("C5CC41")
Multiverse.config = SMODS.current_mod.config
Multiverse.selected_music_page = 1

---@param path string
function Multiverse.recursive_load(path)
    local files = NFS.getDirectoryItems(Multiverse.path .. path)
    for _, item in ipairs(files) do
        if string.sub(item, -4) == ".lua" then
            print("Multiverse: Loading " .. item)
            local f, err = SMODS.load_file(path .. "/" .. item:gsub("%d+_", ""))
            if err then error(err) elseif f then f() end
        elseif path:find("%.") == nil then
            Multiverse.recursive_load(path .. "/" .. item)
        end
    end
end

Multiverse.recursive_load("misc")
Multiverse.recursive_load("mod")
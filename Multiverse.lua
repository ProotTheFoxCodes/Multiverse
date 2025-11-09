Multiverse = SMODS.current_mod
Multiverse.TRANSMUTED_GRADIENT = SMODS.Gradient({
	key = "transmuted_gradient",
	colours = {
		HEX("89C41B"),
		HEX("C5CC41"),
	},
	cycle = 1.5,
})
Multiverse.C = {}
Multiverse.C.PRIMARY1 = HEX("89C41B")
Multiverse.C.PRIMARY2 = HEX("C5CC41")
Multiverse.selected_music_page = 1
Multiverse.transmutable_sticker_anim_state = 0
Multiverse.debug = false

SMODS.ObjectType({
	key = "mul_can_transmute",
	default = "j_joker",
})

---@param path string
function Multiverse.recursive_load(path)
	local files = NFS.getDirectoryItems(Multiverse.path .. path)
	for _, item in ipairs(files) do
		if string.sub(item, -4) == ".lua" then
			print("Multiverse: Loading " .. item:gsub("%d+_", ""))
			local f, err = SMODS.load_file(path .. "/" .. item)
			if err then
				error(err)
			elseif f then
				f()
			end
		elseif path:find("%.") == nil then
			Multiverse.recursive_load(path .. "/" .. item)
		end
	end
end

Multiverse.recursive_load("misc")
Multiverse.recursive_load("mod")

if SMODS.load_file("debug.lua") then
	Multiverse.debug = true
end

Multiverse = {}
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

---Talisman compatibility?
to_big = to_big or function(x)
	return x
end
to_number = to_number or function(x)
	return x
end

SMODS.ObjectType({
	key = "mul_can_transmute",
	default = "j_joker",
})

SMODS.current_mod.calculate = function(self, context)
	if context.end_of_round and not context.blueprint and not context.game_over and context.main_eval then
		Multiverse.hide_blind_instructions()
		Multiverse.ease_thaumaturgy_energy(G.GAME.mul_thaumaturgy_energy_rate, { from_charge = true })
		if G.GAME.mul_thaumaturgy_energy >= 100 then
			Multiverse.ease_thaumaturgy_energy(-G.GAME.mul_thaumaturgy_energy, { from_magnum_opus = true })
			add_tag(Tag("tag_mul_magnum_opus", false, "Small"))
		end
	end
end

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

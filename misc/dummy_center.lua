Multiverse.DummyCenters = {}
Multiverse.DummyCenter = SMODS.Center:extend({
	set = "mul_Dummy",
	obj_buffer = {},
	obj_table = Multiverse.DummyCenters,
	required_params = {
		"key",
	},
	class_prefix = "du",
	in_pool = function(self, args)
		return false
	end,
	no_collection = true,
	pre_inject_class = function(self)
		G.P_CENTER_POOLS[self.set] = {}
	end
})

Multiverse.DummyCenter({
	key = "all_enchants",
	loc_vars = function(self, info_queue, card)
		if G.GAME.mul_deck_enchantments then
			for _, key in ipairs(Multiverse.DeckEnchantment.obj_buffer) do
				if Multiverse.DeckEnchantments[key]:get_level() > 0 then
					info_queue[#info_queue + 1] = Multiverse.DeckEnchantments[key]
				end
			end
		end
	end,
})

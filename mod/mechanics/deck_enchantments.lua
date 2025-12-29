Multiverse.DeckEnchantment({
	key = "dark",
	max_level = 2,
	loc_vars = function(self, info_queue, card)
		local colours = {}
		local ret = {
			Multiverse.number_to_roman(self:get_level()),
		}
		Multiverse.handle_deck_enchantment_loc_colours(self, colours, G.C.FILTER)
		Multiverse.handle_deck_enchantment_loc_colours(self, colours, G.C.BLUE)
		for i = 1, self.max_level do
			ret[#ret + 1] = i
		end
		ret.colours = colours
		return {
			vars = ret,
		}
	end,
	on_change_level = function(self, delta, final_level)
		G.jokers:change_size(delta)
		ease_hands_played(-delta)
		G.GAME.round_resets.hands = G.GAME.round_resets.hands - delta
	end,
	deck_incompat = {
		"b_black",
	},
})
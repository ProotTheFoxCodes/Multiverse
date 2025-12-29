Multiverse.DeckEnchantment({
	key = "dark_affinity",
	max_level = 2,
	loc_vars = function(self, info_queue, card)
		local colours = {}
		local ret = {
			(self:get_level() > 0 and " " or "") .. Multiverse.number_to_roman(self:get_level()),
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
    enchantment_type = "neutral",
    in_pool = function (self, args)
        return G.GAME.round_resets.hands > args.level_amt
    end
})

Multiverse.DeckEnchantment({
    key = "flame_affinity",
    max_level = 2,
    loc_vars = function (self, info_queue, card)
        local colours = {}
		local ret = {
			(self:get_level() > 0 and " " or "") .. Multiverse.number_to_roman(self:get_level()),
		}
		Multiverse.handle_deck_enchantment_loc_colours(self, colours, G.C.RED)
		Multiverse.handle_deck_enchantment_loc_colours(self, colours, G.C.BLUE)
		for i = 1, self.max_level do
			ret[#ret + 1] = i * 2
		end
        for i = 1, self.max_level do
			ret[#ret + 1] = i
		end
		ret.colours = colours
		return {
			vars = ret,
		}
    end,
    on_change_level = function (self, delta, final_level)
        ease_discard(delta * 2)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + delta * 2
        ease_hands_played(-delta)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - delta
    end,
    deck_incompat = {
		"b_red",
	},
    enchantment_type = "neutral",
    in_pool = function (self, args)
        return G.GAME.round_resets.hands > args.level_amt
    end
})

Multiverse.DeckEnchantment({
    key = "aqua_affinity",
    max_level = 2,
    loc_vars = function (self, info_queue, card)
        local colours = {}
		local ret = {
			(self:get_level() > 0 and " " or "") .. Multiverse.number_to_roman(self:get_level()),
		}
		Multiverse.handle_deck_enchantment_loc_colours(self, colours, G.C.BLUE)
		Multiverse.handle_deck_enchantment_loc_colours(self, colours, G.C.RED)
		for i = 1, self.max_level do
			ret[#ret + 1] = i * 2
		end
        for i = 1, self.max_level do
			ret[#ret + 1] = i
		end
		ret.colours = colours
		return {
			vars = ret,
		}
    end,
    on_change_level = function (self, delta, final_level)
        ease_hands_played(delta * 2)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + delta * 2
        ease_discard(-delta)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - delta
    end,
    deck_incompat = {
		"b_blue",
	},
    enchantment_type = "neutral",
    in_pool = function (self, args)
        return G.GAME.round_resets.discards >= args.level_amt
    end
})

Multiverse.DeckEnchantment({
    key = "cosmic_affinity",
    max_level = 2,
    loc_vars = function (self, info_queue, card)
        local colours = {}
		local ret = {
			(self:get_level() > 0 and " " or "") .. Multiverse.number_to_roman(self:get_level()),
		}
		Multiverse.handle_deck_enchantment_loc_colours(self, colours, G.C.FILTER)
		Multiverse.handle_deck_enchantment_loc_colours(self, colours, G.C.RED)
		for i = 1, self.max_level do
			ret[#ret + 1] = i
		end
		ret.colours = colours
		return {
			vars = ret,
		}
    end,
    on_change_level = function (self, delta, final_level)
        G.consumeables:change_size(-delta)
    end,
    deck_incompat = {
		"b_nebula",
	},
    enchantment_type = "neutral",
    in_pool = function (self, args)
        return G.GAME.round_resets.discards >= args.level_amt
    end,
    calculate = function(self, enchantment, context)
        if context.using_consumeable and context.consumeable.ability.set == "Planet" then
            local hand = Multiverse.get_most_played_hand()
            SMODS.upgrade_poker_hands({
                hands = { hand },
                level_up = enchantment.level
            })
        end
    end
})
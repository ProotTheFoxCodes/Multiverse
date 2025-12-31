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
	in_pool = function(self, args)
		return G.GAME.round_resets.hands > args.level_amt
	end,
})

Multiverse.DeckEnchantment({
	key = "flame_affinity",
	max_level = 2,
	loc_vars = function(self, info_queue, card)
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
	on_change_level = function(self, delta, final_level)
		ease_discard(delta * 2)
		G.GAME.round_resets.discards = G.GAME.round_resets.discards + delta * 2
		ease_hands_played(-delta)
		G.GAME.round_resets.hands = G.GAME.round_resets.hands - delta
	end,
	deck_incompat = {
		"b_red",
	},
	enchantment_type = "neutral",
	in_pool = function(self, args)
		return math.min(G.GAME.round_resets.hands, G.GAME.current_round.hands_left) > args.level_amt
	end,
})

Multiverse.DeckEnchantment({
	key = "aqua_affinity",
	max_level = 2,
	loc_vars = function(self, info_queue, card)
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
	on_change_level = function(self, delta, final_level)
		ease_hands_played(delta * 2)
		G.GAME.round_resets.hands = G.GAME.round_resets.hands + delta * 2
		ease_discard(-delta)
		G.GAME.round_resets.discards = G.GAME.round_resets.discards - delta
	end,
	deck_incompat = {
		"b_blue",
	},
	enchantment_type = "neutral",
	in_pool = function(self, args)
		return math.min(G.GAME.round_resets.discards, G.GAME.current_round.discards_left) >= args.level_amt
	end,
})

Multiverse.DeckEnchantment({
	key = "cosmic_affinity",
	max_level = 2,
	loc_vars = function(self, info_queue, card)
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
	on_change_level = function(self, delta, final_level)
		G.consumeables:change_size(-delta)
	end,
	deck_incompat = {
		"b_nebula",
	},
	enchantment_type = "neutral",
	in_pool = function(self, args)
		return G.consumeables.config.card_limit >= args.level_amt
	end,
	calculate = function(self, enchantment, context)
		if context.using_consumeable and context.consumeable.ability.set == "Planet" then
			local hand = Multiverse.get_most_played_hand()
			return {
				level_up = enchantment.level,
				level_up_hand = hand,
			}
		end
	end,
})

Multiverse.DeckEnchantment({
	key = "druidic_affinity",
	max_level = 2,
	loc_vars = function(self, info_queue, card)
		local colours = {}
		local ret = {
			(self:get_level() > 0 and " " or "") .. Multiverse.number_to_roman(self:get_level()),
		}
		Multiverse.handle_deck_enchantment_loc_colours(self, colours, G.C.MONEY)
		Multiverse.handle_deck_enchantment_loc_colours(self, colours, G.C.MONEY)
		for i = 1, self.max_level do
			ret[#ret + 1] = i
		end
		for i = 1, self.max_level do
			ret[#ret + 1] = i * 3
		end
		ret.colours = colours
		return {
			vars = ret,
		}
	end,
	on_change_level = function(self, delta, final_level)
		G.GAME.modifiers.money_per_hand = (G.GAME.modifiers.money_per_hand or 1) + delta
		G.GAME.modifiers.money_per_discard = (G.GAME.modifiers.money_per_discard or 0) + delta
		G.GAME.inflation = G.GAME.inflation + delta * 3
	end,
	deck_incompat = {
		"b_green",
	},
	enchantment_type = "neutral",
})

Multiverse.DeckEnchantment({
	key = "artistic_affinity",
	max_level = 2,
	loc_vars = function(self, info_queue, card)
		local colours = {}
		local ret = {
			(self:get_level() > 0 and " " or "") .. Multiverse.number_to_roman(self:get_level()),
		}
		Multiverse.handle_deck_enchantment_loc_colours(self, colours, G.C.FILTER)
		Multiverse.handle_deck_enchantment_loc_colours(self, colours, G.C.RED)
		for i = 1, self.max_level do
			ret[#ret + 1] = i * 3
		end
		for i = 1, self.max_level do
			ret[#ret + 1] = i
		end
		ret.colours = colours
		return {
			vars = ret,
		}
	end,
	on_change_level = function(self, delta, final_level)
		G.hand:change_size(delta * 3)
		G.jokers:change_size(-delta)
	end,
	deck_incompat = {
		"b_painted",
	},
	enchantment_type = "neutral",
	in_pool = function(self, args)
		return G.jokers.config.card_limit >= args.level_amt
	end,
})

Multiverse.DeckEnchantment({
	key = "light_affinity",
	max_level = 2,
	loc_vars = function(self, info_queue, card)
		local colours = {}
		local ret = {
			(self:get_level() > 0 and " " or "") .. Multiverse.number_to_roman(self:get_level()),
		}
		Multiverse.handle_deck_enchantment_loc_colours(self, colours, G.C.MONEY)
		Multiverse.handle_deck_enchantment_loc_colours(self, colours, G.C.RED)
		for i = 1, self.max_level do
			ret[#ret + 1] = i * 6
		end
		for i = 1, self.max_level do
			ret[#ret + 1] = i
		end
		ret.colours = colours
		return {
			vars = ret,
		}
	end,
	on_change_level = function(self, delta, final_level)
		G.hand:change_size(-delta)
	end,
	deck_incompat = {
		"b_yellow",
	},
	enchantment_type = "neutral",
	in_pool = function(self, args)
		return G.jokers.config.card_limit >= args.level_amt
	end,
	calc_dollar_bonus = function(self, enchantment)
		return enchantment.level * 6
	end,
})

Multiverse.DeckEnchantment({
	key = "arcane_affinity",
	max_level = 2,
	loc_vars = function(self, info_queue, card)
		local colours = {}
		local ret = {
			(self:get_level() > 0 and " " or "") .. Multiverse.number_to_roman(self:get_level()),
		}
		Multiverse.handle_deck_enchantment_loc_colours(self, colours, G.C.FILTER)
		Multiverse.handle_deck_enchantment_loc_colours(self, colours, G.C.MONEY)
		for i = 1, self.max_level do
			ret[#ret + 1] = i
		end
		for i = 1, self.max_level do
			ret[#ret + 1] = i * 2
		end
		ret.colours = colours
		info_queue[#info_queue + 1] = G.P_CENTERS.c_fool
		return {
			vars = ret,
		}
	end,
	on_change_level = function(self, delta, final_level)
		G.GAME.round_resets.reroll_cost = G.GAME.round_resets.reroll_cost + delta * 2
	end,
	deck_incompat = {
		"b_magic",
	},
	enchantment_type = "neutral",
	in_pool = function(self, args)
		return G.jokers.config.card_limit >= args.level_amt
	end,
	calculate = function(self, enchantment, context)
		if context.open_booster and context.booster.kind == "Arcana" then
			G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + enchantment.level
			G.E_MANAGER:add_event(Event({
				func = function()
					for i = 1, enchantment.level do
						G.E_MANAGER:add_event(Event({
							func = function()
								SMODS.add_card({
									key = "c_fool",
									edition = "e_negative",
								})

								G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
								return true
							end,
						}))
						SMODS.calculate_effect({
							message = localize("k_plus_tarot"),
							colour = G.C.PURPLE,
						}, G.deck.cards[1] or G.deck)
					end
					return true
				end,
			}))
		end
	end,
})

Multiverse.DeckEnchantment({
	key = "supernatural_affinity",
	max_level = 2,
	loc_vars = function(self, info_queue, card)
		local colours = {}
		local ret = {
			(self:get_level() > 0 and " " or "") .. Multiverse.number_to_roman(self:get_level()),
		}
		Multiverse.handle_deck_enchantment_loc_colours(self, colours, G.C.FILTER)
		Multiverse.handle_deck_enchantment_loc_colours(self, colours, G.C.WHITE)
		Multiverse.handle_deck_enchantment_loc_colours(self, colours, G.C.PURPLE, lighten(G.C.UI.TEXT_INACTIVE, 0.3))
		for i = 1, self.max_level do
			ret[#ret + 1] = i
		end
		for i = 1, self.max_level do
			ret[#ret + 1] = 1 + i * 0.5
		end
		ret.colours = colours
		return {
			vars = ret,
		}
	end,
	deck_incompat = {
		"b_magic",
	},
	enchantment_type = "neutral",
	in_pool = function(self, args)
		return G.jokers.config.card_limit >= args.level_amt
	end,
	calculate = function(self, enchantment, context)
		if context.setting_blind then
			return {
				message = localize({
					type = "variable",
					key = "a_mul_x_blind_size",
					vars = { 1 + enchantment.level * 0.5 },
				}),
				func = function()
					Multiverse.change_blind_size(function(chips)
						return chips * (1 + enchantment.level * 0.5)
					end)
				end
			}
		end
		if context.end_of_round and context.main_eval and not context.game_over and context.beat_boss then
			G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + enchantment.level
			G.E_MANAGER:add_event(Event({
				func = function()
					for i = 1, enchantment.level do
						G.E_MANAGER:add_event(Event({
							func = function()
								SMODS.add_card({
									set = "Spectral",
									edition = "e_negative",
								})

								G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
								return true
							end,
						}))
						SMODS.calculate_effect({
							message = localize("k_plus_spectral"),
							colour = G.C.SECONDARY_SET.Spectral,
						}, G.deck.cards[1] or G.deck)
					end
					return true
				end,
			}))
		end
	end,
})

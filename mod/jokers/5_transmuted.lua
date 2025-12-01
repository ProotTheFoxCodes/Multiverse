SMODS.Rarity({
	key = "transmuted",
	default_weight = 0,
	badge_colour = Multiverse.TRANSMUTED_GRADIENT,
	pools = {
		["Joker"] = true,
	},
})

SMODS.Joker({
	key = "ren_amamiya",
	atlas = "ren_amamiya",
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
	rarity = "mul_transmuted",
	blueprint_compat = false,
	cost = 40,
	loc_vars = function(self, info_queue, card)
		table.insert(info_queue, G.P_CENTERS.m_mul_calling_card)
		local tarots_held = { n = 0 }
		if G.consumeables then
			for _, c in ipairs(G.consumeables.cards) do
				if not tarots_held[c.config.center.key] and c.ability.set == "Tarot" then
					tarots_held[c.config.center.key] = 1
					tarots_held.n = tarots_held.n + 1
				end
			end
		end
		return { vars = { tarots_held.n } }
	end,
	calculate = function(self, card, context)
		if not context.blueprint then
			if context.before then
				local changed_card = context.scoring_hand[1]
				if not SMODS.has_enhancement(changed_card, "m_mul_calling_card") then
					assert(SMODS.change_base(changed_card, "Hearts", "Ace"))
					G.E_MANAGER:add_event(Event({
						func = function()
							changed_card:mul_safe_dissolve(nil, false, 1.6)
							return true
						end,
					}))
					delay(1.75)
					changed_card:set_ability("m_mul_calling_card", false, true)
					G.E_MANAGER:add_event(Event({
						func = function()
							changed_card:start_materialize(nil, false, 1.6)
							return true
						end,
					}))
				end
			end
			if context.initial_scoring_step then
				local has_call_card = false
				for _, c in ipairs(G.hand.cards) do
					if c.config.center.key == "m_mul_calling_card" then
						has_call_card = true
						break
					end
				end
				for _, c in ipairs(context.full_hand) do
					if c.config.center.key == "m_mul_calling_card" or has_call_card then
						has_call_card = true
						break
					end
				end
				if has_call_card then
					delay(0.9)
					G.E_MANAGER:add_event(Event({
						trigger = "ease",
						ref_table = G.GAME,
						ref_value = "mul_call_card_anim_state",
						ease_to = 6,
						delay = 1.2,
					}))
				end
			end
			if
				context.repetition
				and context.cardarea == G.play
				and SMODS.has_enhancement(context.other_card, "m_mul_calling_card")
			then
				local tarots_held = { n = 0 }
				if G.consumeables then
					for _, c in ipairs(G.consumeables.cards) do
						if not tarots_held[c.config.center.key] and c.ability.set == "Tarot" then
							tarots_held[c.config.center.key] = 1
							tarots_held.n = tarots_held.n + 1
						end
					end
				end
				if tarots_held.n > 0 then
					return { repetitions = tarots_held.n }
				end
			end
			if context.after then
				local has_call_card = false
				for _, c in ipairs(G.hand.cards) do
					if c.config.center.key == "m_mul_calling_card" then
						has_call_card = true
						break
					end
				end
				for _, c in ipairs(context.full_hand) do
					if c.config.center.key == "m_mul_calling_card" or has_call_card then
						has_call_card = true
						break
					end
				end
				if has_call_card then
					G.E_MANAGER:add_event(Event({
						trigger = "ease",
						ref_table = G.GAME,
						ref_value = "mul_call_card_anim_state",
						ease_to = 0,
						delay = 1.8,
					}))
					delay(0.5)
				end
			end
		end
	end,
})

Multiverse.UsableJoker({
	key = "steve",
	atlas = "placeholder",
	pos = { x = 4, y = 0 },
	rarity = "mul_transmuted",
	blueprint_compat = false,
	cost = 40,
	loc_vars = function(self, info_queue, card)
		table.insert(info_queue, G.P_CENTERS.m_mul_netherite)
		table.insert(info_queue, {
			set = "Other",
			key = "mul_steve_ability",
			vars = {
				card.ability.extra.tp_cost,
			},
		})
		return { vars = { card.ability.extra.size_inc } }
	end,
	config = { extra = { size_inc = 5, tp_cost = 20 } },
	add_to_deck = function(self, card, from_debuff)
		G.hand:change_size(card.ability.extra.size_inc)
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.hand:change_size(-card.ability.extra.size_inc)
	end,
	calculate = function(self, card, context)
		if not context.blueprint and context.before then
			for _, c in ipairs(G.hand.cards) do
				if next(SMODS.get_enhancements(c)) and not SMODS.has_enhancement(c, "m_mul_netherite") then
					c:set_ability("m_mul_netherite")
				end
			end
		end
	end,
	use_ability = function(self, card)
		local cards_to_create = #G.hand.highlighted
		Multiverse.effect_animation(card, function()
			Multiverse.ease_TP(-card.ability.extra.tp_cost, { instant = true })
			SMODS.destroy_cards(G.hand.highlighted)
			for i = 1, cards_to_create do
				SMODS.add_card({
					set = "Enhanced",
					key = "m_mul_netherite",
					edition = SMODS.poll_edition({ no_negative = true, guaranteed = true, key = "mul_steve" }),
					seal = SMODS.poll_seal({ guaranteed = true, key = "mul_steve" }),
					area = G.hand,
				})
			end
		end)
	end,
	can_use_ability = function(self, card)
		return G.hand and #G.hand.highlighted > 0 and G.GAME.mul_TP >= card.ability.extra.tp_cost
	end,
})

SMODS.Joker({
	key = "gerson",
	atlas = "placeholder",
	pos = { x = 4, y = 0 },
	rarity = "mul_transmuted",
	blueprint_compat = false,
	cost = 40,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.joker_xmult, card.ability.extra.increment } }
	end,
	config = { extra = { joker_xmult = 1, increment = 0.5 } },
	add_to_deck = function(self, card, from_debuff)
		if G.GAME.blind and G.GAME.blind.boss and not G.GAME.blind.disabled then
			card:juice_up(0.4, 0.4)
			G.E_MANAGER:add_event(Event({
				func = function()
					G.GAME.blind:disable()
					play_sound("mul_gerson_laugh", 1, 1)
					delay(0.4)
					G.E_MANAGER:add_event(Event({
						func = function()
							Multiverse.start_animation("gerson_disable")
							return true
						end,
					}))
					return true
				end,
			}))
		end
	end,
	calculate = function(self, card, context)
		if context.setting_blind and context.blind.boss and not context.blueprint then
			card.ability.extra.joker_xmult = card.ability.extra.joker_xmult + card.ability.extra.increment
			card:juice_up(0.4, 0.4)
			G.E_MANAGER:add_event(Event({
				func = function()
					G.GAME.blind:disable()
					play_sound("mul_gerson_laugh", 1, 1)
					delay(0.4)
					G.E_MANAGER:add_event(Event({
						func = function()
							Multiverse.start_animation("gerson_disable")
							return true
						end,
					}))
					return true
				end,
			}))
		end
		if context.other_joker and not context.blueprint and card.ability.extra.joker_xmult > 1 then
			return {
				xmult = card.ability.extra.joker_xmult,
			}
		end
	end,
})

SMODS.Joker({
	key = "waldo",
	atlas = "placeholder",
	pos = { x = 4, y = 0 },
	config = { extra = { xmult_inc = 1 } },
	rarity = "mul_transmuted",
	cost = 40,
	blueprint_compat = false,
	loc_vars = function(self, info_queue, card)
		local cards_in_deck = 0
		if G.playing_cards then
			cards_in_deck = #G.playing_cards
		end
		return { vars = { card.ability.extra.xmult_inc, (card.ability.extra.xmult_inc * cards_in_deck + 1) } }
	end,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			SMODS.add_card({
				set = "Base",
				area = G.deck,
				skip_materialize = true,
				enhancement = "m_mul_waldo",
			})
		end
	end,
	calculate = function(self, card, context)
		if
			context.individual
			and not context.blueprint
			and SMODS.has_enhancement(context.other_card, "m_mul_waldo")
		then
			return {
				xmult = card.ability.extra.xmult_inc * #G.playing_cards + 1,
			}
		end
	end,
})

Multiverse.UsableJoker({
	key = "heavy",
	atlas = "placeholder",
	pos = { x = 4, y = 0 },
	rarity = "mul_transmuted",
	blueprint_compat = false,
	cost = 40,
	loc_vars = function(self, info_queue, card)
		table.insert(info_queue, {
			set = "Other",
			key = "mul_heavy_ability",
			vars = {
				card.ability.extra.tp_cost,
				card.ability.extra.hand_boost,
			},
		})
		table.insert(info_queue, {
			set = "Other",
			key = "mul_distributed_retriggers",
		})
		local hands = G.GAME and G.GAME.current_round.hands_left or 0
		return {
			vars = {
				card.ability.extra.hands,
				card.ability.extra.retriggers,
				card.ability.extra.retriggers_per_hand,
				card.ability.extra.retriggers + card.ability.extra.retriggers_per_hand * hands,
			},
		}
	end,
	config = { extra = { retriggers = 8, retriggers_per_hand = 4, hands = 2, hand_boost = 4, tp_cost = 30 } },
	calculate = function(self, card, context)
		if not context.blueprint and context.repetition and context.cardarea == G.play then
			local amt = card.ability.extra.retriggers
				+ (G.GAME.current_round.hands_left + 1) * card.ability.extra.retriggers_per_hand
			-- adjusted for the -1 hand that happens when hand is played
			local current_index = 1
			for i, c in ipairs(context.scoring_hand) do
				if c == context.other_card then
					current_index = i
					break
				end
			end
			return {
				repetitions = math.floor(amt / #context.scoring_hand)
					+ ((current_index <= amt % #context.scoring_hand) and 1 or 0),
			}
		end
	end,
	use_ability = function(self, card)
		G.E_MANAGER:add_event(Event({
			func = function()
				ease_hands_played(card.ability.extra.hand_boost)
				return true
			end,
		}))
	end,
	can_use_ability = function(self, card)
		return G.GAME.mul_TP >= card.ability.extra.tp_cost
	end,
	add_to_deck = function(self, card, from_debuff)
		G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
		ease_hands_played(card.ability.extra.hands)
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands
		ease_hands_played(-card.ability.extra.hands)
	end,
})

SMODS.Joker({
	key = "aftermath",
	atlas = "placeholder",
	pos = { x = 0, y = 0 },
	config = { extra = { chips = 19 } },
	rarity = 1,
	blueprint_compat = true,
	cost = 5,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if G.GAME.current_round.hands_left == 0 then
				return {
					chips = card.ability.extra.chips,
				}
			end
		end
	end,
})

SMODS.Joker({
	key = "villager",
	atlas = "placeholder",
	pos = { x = 0, y = 0 },
	config = {
		extra = {
			mult = 20,
			money_loss = 1,
			transmute_req = Multiverse.set_transmute_requirements(25),
			transmute_progress = 0,
		},
	},
	rarity = 1,
	blueprint_compat = true,
	cost = 6,
	loc_vars = function(self, info_queue, card)
		table.insert(info_queue, {
			set = "Other",
			key = "mul_villager_hint",
			vars = {
				card.ability.extra.transmute_progress,
				card.ability.extra.transmute_req,
			},
		})
		return {
			vars = {
				card.ability.extra.mult,
				card.ability.extra.money_loss,
			},
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) - card.ability.extra.money_loss
			ease_dollars(-card.ability.extra.money_loss)
			return {
				mult = card.ability.extra.mult,
				func = function()
					G.E_MANAGER:add_event(Event({
						func = function()
							G.GAME.dollar_buffer = 0
							return true
						end,
					}))
				end,
			}
		end
		if not context.blueprint then
			if context.playing_card_added then
				for _, c in ipairs(context.cards) do
					if
						SMODS.has_enhancement(c, "m_steel")
						or SMODS.has_enhancement(c, "m_gold")
						or SMODS.has_enhancement(c, "m_stone")
					then
						card.ability.extra.transmute_progress = card.ability.extra.transmute_progress + 1
						Multiverse.transmute_check(card)
					end
				end
			end
			if context.mul_villager_transmute_check then
				Multiverse.transmute_check(card)
			end
		end
	end,
	pools = { ["mul_can_transmute"] = true },
})

local set_ability_hook = Card.set_ability
function Card:set_ability(center, initial, delay_sprites)
	set_ability_hook(self, center, initial, delay_sprites)
	if
		not initial
		and self.playing_card
		and (
			SMODS.has_enhancement(self, "m_stone")
			or SMODS.has_enhancement(self, "m_steel")
			or SMODS.has_enhancement(self, "m_gold")
		)
	then
		SMODS.calculate_context({ mul_villager_transmute_check = true })
	end
end

SMODS.Joker({
	key = "red_bloon",
	atlas = "placeholder",
	pos = { x = 0, y = 0 },
	config = { extra = { money = 1, rounds_held = 0, total_rounds = 3 } },
	blueprint_compat = true,
	eternal_compat = false,
	cost = 4,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.money, card.ability.extra.rounds_held, card.ability.extra.total_rounds } }
	end,
	calculate = function(self, card, context)
		G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.money
		if context.individual and context.cardarea == G.play then
			return {
				dollars = card.ability.extra.money,
				func = function()
					G.E_MANAGER:add_event(Event({
						func = function()
							G.GAME.dollar_buffer = 0
							return true
						end,
					}))
				end,
			}
		end
		if context.end_of_round and context.main_eval and not context.game_over and not context.blueprint then
			card.ability.extra.rounds_held = card.ability.extra.rounds_held + 1
			if card.ability.extra.rounds_held >= 3 then
				SMODS.destroy_cards(card)
				return { message = localize("k_mul_popped") }
			else
				return { message = card.ability.extra.rounds_held .. "/" .. card.ability.extra.total_rounds }
			end
		end
	end,
})

SMODS.Joker({
	key = "foddian_struggle",
	atlas = "placeholder",
	pos = { x = 0, y = 0 },
	config = { extra = { mult = 0, mult_gain = 2 } },
	rarity = 1,
	cost = 6,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		local suit = G.GAME.current_round.mul_foddian_suit or "Hearts"
		return {
			vars = {
				localize(suit, "suits_plural"),
				card.ability.extra.mult_gain,
				card.ability.extra.mult,
				colours = { G.C.SUITS[suit] },
			},
		}
	end,
	calculate = function(self, card, context)
		if context.before and context.main_eval and not context.blueprint then
			for _, c in ipairs(context.full_hand) do
				if c:is_suit(G.GAME.current_round.mul_foddian_suit) then
					card.ability.extra.mult = 0
					return {
						message = localize("k_reset"),
					}
				end
			end
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "mult",
				scalar_value = "mult_gain",
			})
		end
		if context.joker_main and card.ability.extra.mult > 0 then
			return {
				mult = card.ability.extra.mult,
			}
		end
	end,
})

SMODS.Joker({
	key = "peashooter",
	atlas = "placeholder",
	pos = { x = 0, y = 0 },
	config = { extra = { mult = 0, mult_gain = 1 } },
	rarity = 1,
	cost = 6,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult_gain, card.ability.extra.mult } }
	end,
	calculate = function(self, card, context)
		if context.before and context.main_eval and not context.blueprint then
			if #context.full_hand == 1 then
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "mult",
					scalar_value = "mult_gain",
				})
			end
		end
		if context.joker_main and card.ability.extra.mult > 0 then
			return {
				mult = card.ability.extra.mult,
			}
		end
	end,
})

SMODS.Joker({
	key = "slime",
	atlas = "placeholder",
	pos = { x = 0, y = 0 },
	config = { extra = { dollars = 2, min_cards = 5 } },
	rarity = 1,
	cost = 6,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.min_cards, card.ability.extra.dollars } }
	end,
	calculate = function(self, card, context)
		if context.before and #context.scoring_hand >= card.ability.extra.min_cards then
			G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.dollars
			return {
				dollars = card.ability.extra.dollars,
				func = function()
					G.E_MANAGER:add_event(Event({
						func = function()
							G.GAME.dollar_buffer = 0
							return true
						end,
					}))
				end,
			}
		end
	end,
})

SMODS.Joker({
	key = "jack_frost",
	atlas = "placeholder",
	pos = { x = 0, y = 0 },
	config = { extra = { rank = "Jack" } },
	rarity = 1,
	cost = 5,
	blueprint_compat = false,
	calculate = function(self, card, context)
		if context.before and not context.blueprint and context.scoring_hand[1] then
			assert(SMODS.change_base(context.scoring_hand[1], nil, "Jack"))
		end
	end,
})
